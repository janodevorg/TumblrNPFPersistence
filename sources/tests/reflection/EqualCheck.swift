import CoreData
import Foundation
import TumblrNPF
import os
import TumblrNPFPersistence
import XCTest

/// Differences between two members of an object.
struct Diff: MirrorDescripting {
    let object: String
    let label: String
    let property: String
    let value1: String
    let value2: String
}

/// Inequality found between two members of an object.
enum EqualityError: Error, CustomStringConvertible {
    case differentKeys([String], [String]) // keys
    case unknownTypeLabeled(String, Any, Any) // key of the unknown type plus two values
    case differentValues(Diff) // type representing the diff

    var description: String {
        switch self {
        case .differentKeys(let labels1, let labels2):
            let diff = Set(labels1).symmetricDifference(labels2)
            return "differentKeys: \(diff.sorted())\nlabels1: \(labels1.sorted())\nlabels2: \(labels2.sorted())"
        case let .unknownTypeLabeled(string, any1, any2): return "unknownTypeLabeled(\(string)). v1: \(any1), v2: \(any2)"
        case .differentValues(let diff): return "differentValues(\(diff.description))"
        }
    }
}

/// Asserts equality of two objects using reflection.
struct Equality
{
    private let model1: Any
    private let model2: Any
    private let log = Logger(subsystem: "dev.jano", category: "persistence")

    init(_ model1: Any, _ model2: Any) {
        self.model1 = model1
        self.model2 = model2
    }

    func assert() {
        switch check(model1, model2) {
        case .success: ()
        case .failure(let error): XCTFail(error.description)
        }
    }

    func assertFailure() {
        switch check(model1, model2) {
        case .success: XCTFail("Expected failure but objects seem equal.")
        case .failure: ()
        }
    }

    private func check(_ model1: Any, _ model2: Any) -> Result<(), EqualityError>  {

        log.trace("Model1: \(String(describing: model1))")
        log.trace("Model2: \(String(describing: model2))")

        let dict1: [String?: Any] = Mirror(reflecting: model1).children.compactMap { $0 }.reduce(into: [:]) { $0[$1.0] = $1.1 }
        let dict2: [String?: Any] = Mirror(reflecting: model2).children.compactMap { $0 }.reduce(into: [:]) { $0[$1.0] = $1.1 }
        guard Set(dict1.keys) == Set(dict2.keys) else {
            return .failure(.differentKeys(dict1.keys.compactMap { $0 }, dict2.keys.compactMap { $0 }))
        }
        for key in dict1.keys.compactMap({ $0 }) {
            switch (dict1[key], dict2[key]) {

            // properties
            case let (v1, v2) as (String, String):
                guard v1 == v2 else { return diffFailure(key, v1, v2) }
            case let (v1, v2) as (Int, Int):
                guard v1 == v2 else { return diffFailure(key, v1, v2) }
            case let (v1, v2) as (URL, URL):
                guard v1 == v2 else { return diffFailure(key, v1, v2) }
            case let (v1, v2) as (NSNumber, NSNumber):
                guard v1 == v2 else { return diffFailure(key, v1, v2) }

            // arrays of properties
            case let (v1, v2) as ([String], [String]):
                guard v1 == v2 else { return diffFailure(key, v1, v2) }
            case let (v1, v2) as ([Int], [Int]):
                guard v1 == v2 else { return diffFailure(key, v1, v2) }
            case let (v1, v2) as ([URL], [URL]):
                guard v1 == v2 else { return diffFailure(key, v1, v2) }
            case let (v1, v2) as ([NSNumber], [NSNumber]):
                guard v1 == v2 else { return diffFailure(key, v1, v2) }

            // core data

            case let (v1, v2) as (MediaObjectMO, MediaObject) where model1 is NSManagedObject:
                guard check(v1, v2).isSuccess  else { return diffFailure(key, v1, v2) }
            case let (v1, v2) as (MediaObject, MediaObjectMO) where model2 is NSManagedObject:
                guard check(v1, v2).isSuccess else { return diffFailure(key, v1, v2) }

            case let (v1, v2) as (MediaObjectMO, MediaObjectWrap) where model1 is NSManagedObject:
                guard check(v1, v2.media).isSuccess  else { return diffFailure(key, v1, v2.media) }
            case let (v1, v2) as (MediaObjectWrap, MediaObjectMO) where model2 is NSManagedObject:
                guard check(v1.media, v2).isSuccess else { return diffFailure(key, v1.media, v2) }

            case let (v1, v2) as (NSNumber, Int) where model1 is NSManagedObject:
                guard v1.isEqual(v2) else { return diffFailure(key, v1.intValue, v2) }
            case let (v1, v2) as (Int, NSNumber) where model2 is NSManagedObject:
                guard v2.isEqual(v1) else { return diffFailure(key, v1, v2.intValue) }

            default:
                if (String(describing: dict1[key]) == "Optional(nil)")
                    && (String(describing: dict2[key]) == "Optional(nil)") {
                    return .success(())
                }
                return .failure(.unknownTypeLabeled(key, dict1[key] as Any, dict2[key] as Any))
            }
        }
        return .success(())
    }

    private func diffFailure<T,U>(_ label: String, _ value1: T, _ value2: U) -> Result<(), EqualityError> {
        .failure(
            .differentValues(
                Diff(object: "\(type(of: model1))",
                     label: label,
                     property: "\(T.self)",
                     value1: "\(value1)",
                     value2: "\(value2)")
            )
        )
    }
}
