import CoreData
@testable import TumblrNPFPersistence
@testable import TumblrNPF
import XCTest

final class MediaObjectMOTests: MOTestCase
{
    private lazy var poster: MediaObject = MediaObject(
        cropped: true,
        hasOriginalDimensions: true,
        hd: nil,
        height: 38,
        originalDimensionsMissing: true,
        poster: nil,
        type: "image/png",
        url: URL(string: "https://domain.com/poster.png")!,
        width: 46
    )

    private lazy var mediaObject = MediaObject(
        cropped: true,
        hasOriginalDimensions: true,
        hd: nil,
        height: 38,
        originalDimensionsMissing: true,
        poster: MediaObjectWrap(media: poster),
        type: "image/gif",
        url: URL(string: "https://domain.com/mediaObject.gif")!,
        width: 46
    )

    func testDescription() {
        let mo = MediaObjectMO(model: mediaObject, context: context)
        print(mo.description)
    }

    func testModelToJSON() {
        let model = MediaObject(
            cropped: nil,
            hasOriginalDimensions: nil,
            hd: nil,
            height: 400,
            originalDimensionsMissing: nil,
            poster: MediaObjectWrap(media: MediaObject(cropped: nil,
                                                       hasOriginalDimensions: nil,
                                                       hd: nil,
                                                       height: 400,
                                                       originalDimensionsMissing: nil,
                                                       poster: nil,
                                                       type: "image/jpeg",
                                                       url: URL(string: "https://domain.com/poster.jpg")!,
                                                       width: 500)),
            type: "image/gif",
            url: URL(string: "https://domain.com/mediaObject.png")!,
            width: 500
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try! encoder.encode(model)
        print(String(data: jsonData, encoding: .utf8)!)
    }

    /// Test model to Core Data and back
    func testMediaObject() throws {

        // Given an object created
        let createdMO = MediaObjectMO(model: mediaObject, context: context)
        try context.save()

        // When I read it back
        let name = MediaObjectMO.entityName()
        let fetchRequest = NSFetchRequest<MediaObjectMO>(entityName: name)
        let predicate = NSPredicate(format: "type == %@", "image/gif")
        fetchRequest.predicate = predicate
        let mediaObjects = try context.fetch(fetchRequest)
        guard let readBackMO = mediaObjects.first else {
            XCTFail("Couldn’t find a media object")
            return
        }

        // Then

        // it is equal to the original object
        XCTAssertEqual(createdMO, readBackMO)

        // it has the same fields than the model
        XCTAssertEqual(mediaObject.cropped, readBackMO.cropped?.boolValue)
        XCTAssertEqual(mediaObject.hasOriginalDimensions, readBackMO.hasOriginalDimensions?.boolValue)
        XCTAssertEqual(mediaObject.height, readBackMO.height?.intValue)
        XCTAssertEqual(mediaObject.originalDimensionsMissing, readBackMO.originalDimensionsMissing?.boolValue)
        XCTAssertEqual(mediaObject.type, readBackMO.type)
        XCTAssertEqual(mediaObject.url, readBackMO.url)
        XCTAssertEqual(mediaObject.width, readBackMO.width?.intValue)

        let media = mediaObject.poster?.media
        let poster = readBackMO.poster

        XCTAssertEqual(media?.cropped, poster?.cropped?.boolValue)
        XCTAssertEqual(media?.hasOriginalDimensions, poster?.hasOriginalDimensions?.boolValue)
        XCTAssertEqual(media?.height, poster?.height?.intValue)
        XCTAssertEqual(media?.originalDimensionsMissing, poster?.originalDimensionsMissing?.boolValue)
        XCTAssertEqual(media?.type, poster?.type)
        XCTAssertEqual(media?.url, poster?.url)
        XCTAssertEqual(media?.width, poster?.width?.intValue)
    }
}
