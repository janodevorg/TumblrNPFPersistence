import CoreData
@testable import TumblrNPF
@testable import TumblrNPFPersistence
import XCTest

final class TestBlockSubtypeTests: MOTestCase
{
    func testPostTextSubtypes() throws
    {
        let postMO = try createPostMO(filename: "textSubtypesBlock.json")
        guard let textContent = postMO?.content?.allObjects as? [TextContentMO] else {
            XCTFail("Expected [TextContentMO]")
            return
        }
        XCTAssertEqual(postMO?.id, "1234567891234567")

        // heading 1
        var content = textContent.first { $0.subtype == TextBlockSubtype.heading1.rawValue }
        XCTAssertEqual(content?.type, "text")
        XCTAssertEqual(content?.text, "New Post Forms Manifesto")

        // heading 2
        content = textContent.first { $0.subtype == TextBlockSubtype.heading2.rawValue }
        XCTAssertEqual(content?.type, "text")
        XCTAssertEqual(content?.text, "what a great conversation")

        // quote
        content = textContent.first { $0.subtype == TextBlockSubtype.quote.rawValue }
        XCTAssertEqual(content?.type, "text")
        XCTAssertEqual(content?.text, "Genius without education is like silver in the mine.")

        // chat
        content = textContent.first { $0.subtype == TextBlockSubtype.chat.rawValue }
        XCTAssertEqual(content?.type, "text")
        XCTAssertEqual(content?.text, "oli: i'm oli")
        guard let formatting = content?.formatting?.allObjects as? [FormattingMO] else {
            XCTFail("Expected FormattingMO")
            return
        }
        XCTAssertEqual(formatting[0].start, 0)
        XCTAssertEqual(formatting[0].end, 3)
        XCTAssertEqual(formatting[0].type, "bold")

        // orderedListItem
        content = textContent.first {
            $0.subtype == TextBlockSubtype.orderedListItem.rawValue
        }
        XCTAssertEqual(content?.type, "text")
        XCTAssertEqual(content?.text, "Sword")

        // unorderedListItem
        content = textContent.first { $0.subtype == TextBlockSubtype.unorderedListItem.rawValue }
        XCTAssertEqual(content?.type, "text")
        XCTAssertEqual(content?.text, "Death, which is uncountable on this list.")
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
