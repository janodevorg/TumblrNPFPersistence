import CoreData
@testable import TumblrNPF
@testable import TumblrNPFPersistence
import XCTest

final class FormattingMOTests: MOTestCase
{
    func testOverlappingRanges() throws
    {
        let postMO = try createPostMO(filename: "formattingOverlappingRanges.json")
        guard let textContent = (postMO?.content?.allObjects as? [TextContentMO])?.first else {
            XCTFail("Expected [TextContentMO]")
            return
        }

        let formatting = textContent.formatting?.allObjects as? [FormattingMO]

        let boldFormat = formatting?.first { $0.type == "bold" }
        XCTAssert(boldFormat?.start?.intValue == 0)
        XCTAssert(boldFormat?.end?.intValue == 20)

        let italicFormat = formatting?.first { $0.type == "italic" }
        XCTAssert(italicFormat?.start?.intValue == 9)
        XCTAssert(italicFormat?.end?.intValue == 34)
    }

    func testLink() throws
    {
        let postMO = try createPostMO(filename: "formattingLink.json")
        guard let textContent = (postMO?.content?.allObjects as? [TextContentMO])?.first else {
            XCTFail("Expected [TextContentMO]")
            return
        }

        let formatting = textContent.formatting?.allObjects as? [FormattingMO]

        let linkFormat = formatting?.first { $0.type == "link" }
        XCTAssertEqual(linkFormat?.start, 6)
        XCTAssertEqual(linkFormat?.end, 10)
        XCTAssertEqual(linkFormat?.type, "link")
        XCTAssertEqual(linkFormat?.url, URL(string: "https://www.nasa.gov")!) // swiftlint:disable:this force_unwrapping
    }

    func testMention() throws
    {
        let postMO = try createPostMO(filename: "formattingMention.json")
        guard let textContent = (postMO?.content?.allObjects as? [TextContentMO])?.first else {
            XCTFail("Expected [TextContentMO]")
            return
        }

        let formatting = textContent.formatting?.allObjects as? [FormattingMO]

        let linkFormat = formatting?.first { $0.type == "mention" }
        XCTAssertEqual(linkFormat?.start, 13)
        XCTAssertEqual(linkFormat?.end, 19)
        XCTAssertEqual(linkFormat?.type, "mention")
        XCTAssertEqual(linkFormat?.blog?.uuid, "t:123456abcdf")
        XCTAssertEqual(linkFormat?.blog?.name, "david")
        XCTAssertEqual(linkFormat?.blog?.url, URL(string: "https://davidslog.com/"))
    }

    func testColor() throws
    {
        let postMO = try createPostMO(filename: "formattingColor.json")
        guard let textContent = (postMO?.content?.allObjects as? [TextContentMO])?.first else {
            XCTFail("Expected [TextContentMO]")
            return
        }

        let formatting = textContent.formatting?.allObjects as? [FormattingMO]

        let format = formatting?.first { $0.type == "color" }
        XCTAssertEqual(format?.start, 10)
        XCTAssertEqual(format?.end, 15)
        XCTAssertEqual(format?.type, "color")
        XCTAssertEqual(format?.hex, "#ff492f")
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
