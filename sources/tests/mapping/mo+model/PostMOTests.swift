import CoreData
@testable import TumblrNPF
@testable import TumblrNPFPersistence
import XCTest

final class PostMOTests: MOTestCase
{
    func testPost1() throws {
        let postMO = try createPostMO(filename: "post1.json")
        XCTAssertEqual(postMO?.id, "1234567891234567")
        // ?? XCTAssertEqual(attr.blog, ["Standard API Short Blog Info object": "goes here"])
    }

    // MARK: - Private

    private func createPostMO(filename: String) throws -> PostMO? {
        let jsonData = try BundleFile(filename: filename).data
        guard let post = try? JSONDecoder().decode(Post.self, from: jsonData) else {
            XCTFail("Failed to create Post")
            return nil
        }
        return PostMO.upsert(model: post, context: context)
    }
}
