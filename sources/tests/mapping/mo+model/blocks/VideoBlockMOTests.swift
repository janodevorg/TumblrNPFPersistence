import CoreData
@testable import TumblrNPF
@testable import TumblrNPFPersistence
import XCTest

final class VideoBlockMOTests: MOTestCase
{
    func testVideoBlock1() throws {
        let postMO = try createPostMO(filename: "videoBlock1.json")
        let videoContent = postMO?.content?.allObjects.first as? VideoContentMO
        XCTAssertEqual(postMO?.id, "1234567891234567")
        XCTAssertEqual(videoContent?.type, "video")

        let media = videoContent?.media
        XCTAssertEqual(media?.type, "video/mp4")
        XCTAssertEqual(media?.url, URL(string: "http://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1.mp4")!) // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(media?.height, 640)
        XCTAssertEqual(media?.width, 480)
        XCTAssertEqual(media?.hd, false)

        let poster = videoContent?.poster?.allObjects[0] as? MediaObjectMO
        XCTAssertEqual(poster?.type, "image/jpeg")
        XCTAssertEqual(poster?.url, URL(string: "https://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1_500.jpg")!) // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(poster?.height, 400)
        XCTAssertEqual(poster?.width, 500)

        let stripOne = videoContent?.filmstrip?.allObjects[0] as? MediaObjectMO
        XCTAssertEqual(stripOne?.type, "image/jpeg")
        XCTAssertTrue(stripOne?.url?.absoluteString.starts(with: "https://66.media.tumblr.com/previews/tumblr_nshp8oVOnV1rg0s9xo1_filmstrip_frame") ?? false)
        XCTAssertEqual(stripOne?.height, 125)
        XCTAssertEqual(stripOne?.width, 200)

        let stripTwo = videoContent?.filmstrip?.allObjects[1] as? MediaObjectMO
        XCTAssertEqual(stripTwo?.type, "image/jpeg")
        XCTAssertTrue(stripTwo?.url?.absoluteString.starts(with: "https://66.media.tumblr.com/previews/tumblr_nshp8oVOnV1rg0s9xo1_filmstrip_frame") ?? false)
        XCTAssertEqual(stripTwo?.height, 125)
        XCTAssertEqual(stripTwo?.width, 200)

        XCTAssertEqual(videoContent?.canAutoplayOnCellular, true)
    }

    func testVideoBlock2() throws {
        let postMO = try createPostMO(filename: "videoBlock2.json")
        let videoContent = postMO?.content?.allObjects.first as? VideoContentMO
        XCTAssertEqual(postMO?.id, "1234567891234567")
        XCTAssertEqual(videoContent?.type, "video")
        XCTAssertEqual(videoContent?.provider, "youtube")
        XCTAssertEqual(videoContent?.url, URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!) // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(videoContent?.embedHTML, "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/dQw4w9WgXcQ\" frameborder=\"0\" allowfullscreen></iframe>")

        XCTAssertEqual(videoContent?.embedURL, URL(string: "https://www.youtube.com/embed/dQw4w9WgXcQ")!) // swiftlint:disable:this force_unwrapping

        let poster = videoContent?.poster?.allObjects.first as? MediaObjectMO
        XCTAssertEqual(poster?.type, "image/jpeg")
        XCTAssertEqual(poster?.url, URL(string: "https://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1_500.jpg")!) // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(poster?.height, 400)
        XCTAssertEqual(poster?.width, 500)
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
