import CoreData
@testable import TumblrNPFPersistence
@testable import TumblrNPF
import XCTest

final class AttributionMOTests: MOTestCase
{
    func testPostAttribution() throws {
        let attributionMO = try createAttributionMO(filename: "postAttribution.json")
        guard let attr = attributionMO as? PostAttributionObjectMO else {
            XCTFail("Expected PostAttributionObjectMO, got \(attributionMO as Any)")
            return
        }
        XCTAssertEqual(attr.blog?.name, "david")
        XCTAssertEqual(attr.blog?.uuid, "t:123456abcdf")
        XCTAssertEqual(attr.blog?.url, URL(string: "https://davidslog.com/"))
        XCTAssertEqual(attr.post?.id, "1234567890")
        XCTAssertEqual(attr.type, "post")
        XCTAssertEqual(attr.url, URL(string: "http://www.davidslog.com/153957802620/five-years-of-working-with-this-awesome-girl"))
    }

    func testLinkAttribution() throws {
        let attributionMO = try createAttributionMO(filename: "linkAttribution.json")
        guard let attr = attributionMO as? LinkAttributionObjectMO else {
            XCTFail("Expected LinkAttributionObjectMO, got \(attributionMO as Any)")
            return
        }
        XCTAssertEqual(attr.type, "link")
        XCTAssertEqual(attr.url, URL(string: "http://shahkashani.com/")!)
    }

    func testBlogAttribution() throws {
        let attributionMO = try createAttributionMO(filename: "blogAttribution.json")
        guard let attr = attributionMO as? BlogAttributionObjectMO else {
            XCTFail("Expected BlogAttributionObjectMO, got \(attributionMO as Any)")
            return
        }
        XCTAssertEqual(attr.type, "blog")
        XCTAssertEqual(attr.url, URL(string: "https://randerson.tumblr.com")!)
    }

    func testAppAttribution() throws {
        let attributionMO = try createAttributionMO(filename: "appAttribution.json")
        guard let attr = attributionMO as? AppAttributionObjectMO else {
            XCTFail("Expected AppAttributionObjectMO, got \(attributionMO as Any)")
            return
        }
        XCTAssertEqual(attr.type, "app")
        XCTAssertEqual(attr.appName, "Instagram")
        XCTAssertEqual(attr.displayText, "tibbythecorgi - Very Cute")
        XCTAssertEqual(attr.url, URL(string: "https://www.instagram.com/p/BVZyxTklQWX/")!)
        XCTAssertEqual(attr.logo?.url, URL(string: "https://scontent.cdninstagram.com/path/to/logo.jpg")!)
        XCTAssertEqual(attr.logo?.type, "image/jpeg")
        XCTAssertEqual(attr.logo?.width, 64)
        XCTAssertEqual(attr.logo?.height, 64)
    }

    // MARK: - Private

    private func createAttributionMO(filename: String) throws -> AttributionObjectMO? {
        let jsonData = try BundleFile(filename: filename).data
        let attribution = try! JSONDecoder().decode(AttributionObject.self, from: jsonData)
        return AttributionObjectMO.map(model: attribution, context: context)
    }
}
