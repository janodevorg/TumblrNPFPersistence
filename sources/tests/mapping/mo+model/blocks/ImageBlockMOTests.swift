import CoreData
@testable import TumblrNPF
@testable import TumblrNPFPersistence
import XCTest

final class ImageBlockMOTests: MOTestCase
{
    func testImageJPEG() throws {
        let postMO = try createPostMO(filename: "imageJPEGBlock.json")
        XCTAssertEqual(postMO?.id, "1234567891234567")
        let imageContent = postMO?.content?.allObjects.first as? ImageContentMO
        XCTAssertEqual(imageContent?.altText, "Sonic the Hedgehog and friends")
        XCTAssertEqual(imageContent?.caption, "I'm living my best life on earth.")
        XCTAssertEqual(imageContent?.feedbackToken, "abcdef123456")
        XCTAssertEqual(imageContent?.colors, ["c0": "a24615", "c1": "ff7c00"])

        let media = imageContent?.media?.allObjects.first as? MediaObjectMO
        XCTAssertEqual(media?.type, "image/jpeg")
        XCTAssertEqual(media?.url, URL(string: "http://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1_250.jpg")!) // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(media?.width, 250)
        XCTAssertEqual(media?.height, 150)
    }

    func testImageGIF() throws {
        let postMO = try createPostMO(filename: "imageGIFBlock.json")
        XCTAssertEqual(postMO?.id, "1234567891234567")
        let imageContent = postMO?.content?.allObjects.first as? ImageContentMO

        XCTAssertNil(imageContent?.poster)

        let media = imageContent?.media?.allObjects.first as? MediaObjectMO
        XCTAssertEqual(media?.type, "image/gif")
        XCTAssertEqual(media?.url, URL(string: "https://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1_500.gif")!) // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(media?.width, 500)
        XCTAssertEqual(media?.height, 400)

        let poster = media?.poster
        XCTAssertEqual(poster?.type, "image/jpeg")
        XCTAssertEqual(poster?.url, URL(string: "https://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1_500.jpg")!) // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(poster?.width, 500)
        XCTAssertEqual(poster?.height, 400)
    }

    // MARK: - Private

    private func createPostMO(filename: String) throws -> PostMO? {
        let jsonData = try BundleFile(filename: filename).data
        guard let model = try? JSONDecoder().decode(Post.self, from: jsonData) else {
            XCTFail("Failed to create Post")
            return nil
        }
        return PostMO.upsert(model: model, context: context)
    }
}
