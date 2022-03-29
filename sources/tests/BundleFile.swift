import Foundation
@testable import TumblrNPFPersistence

enum FileError: Error {
    case notUTF8, missing, unreadable
}

struct BundleFile
{
    let filename: String

    var string: String {
        get throws {
            guard let url = Bundle.module.url(forResource: filename, withExtension: nil) else {
                throw FileError.missing
            }
            do {
                return try String(contentsOf: url)
            } catch {
                throw FileError.unreadable
            }
        }
    }

    var data: Data {
        get throws {
            guard let data = try string.data(using: .utf8) else {
                throw FileError.notUTF8
            }
            return data
        }
    }
}
