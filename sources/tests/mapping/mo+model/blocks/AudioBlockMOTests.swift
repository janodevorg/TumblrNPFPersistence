import CoreData
@testable import TumblrNPF
@testable import TumblrNPFPersistence
import XCTest

final class AudioBlockMOTests: MOTestCase
{
    func testAudio() throws {
        let postMO = try createPostMO(filename: "audioBlock.json")
        XCTAssertEqual(postMO?.id, "1234567891234567")

        let audioContent = postMO?.content?.allObjects.first as? AudioContentMO
        XCTAssertEqual(audioContent?.type, "audio")
        XCTAssertEqual(audioContent?.provider, "tumblr")
        XCTAssertEqual(audioContent?.title, "Track Title")
        XCTAssertEqual(audioContent?.artist, "Track Artist")
        XCTAssertEqual(audioContent?.album, "Track Album")

        let media = audioContent?.media
        XCTAssertEqual(media?.type, "audio/mp3")
        XCTAssertEqual(media?.url, URL(string: "https://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1.mp3")!) // swiftlint:disable:this force_unwrapping

        let poster = audioContent?.poster?.allObjects.first as? MediaObjectMO
        XCTAssertEqual(poster?.type, "image/jpeg")
        XCTAssertEqual(poster?.url, URL(string: "https://69.media.tumblr.com/b06fe71cc4ab47e93749df060ff54a90/tumblr_nshp8oVOnV1rg0s9xo1_500.jpg")!) // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(poster?.width, 500)
        XCTAssertEqual(poster?.height, 400)
    }

    // MARK: - Private

    private func createPostMO(filename: String) throws -> PostMO? {
        let jsonData = try BundleFile(filename: filename).data
        guard let model = try? JSONDecoder().decode(Post.self, from: jsonData) else {
            XCTFail("Failed to create post")
            return nil
        }
        return PostMO.upsert(model: model, context: context)
    }
}
