import CoreData
@testable import TumblrNPF
@testable import TumblrNPFPersistence
import XCTest

final class TextBlockMOTests: MOTestCase
{
    func testBlockText() throws {
        let postMO = try createPostMO(filename: "textBlock.json")
        let textContent = postMO?.content?.allObjects.first as? TextContentMO
        XCTAssertEqual(postMO?.id, "1234567891234567")
        XCTAssertEqual(textContent?.type, "text")
        XCTAssertEqual(textContent?.text, "It's like Ben Franklin always said:")
    }

    // MARK: - Private

    private func createPostMO(filename: String) throws -> PostMO? {
        let jsonData = try BundleFile(filename: filename).data
        guard let attribution = try? JSONDecoder().decode(Post.self, from: jsonData) else {
            XCTFail("Failed to create Post")
            return nil
        }
        return PostMO.upsert(model: attribution, context: context)
    }
}
