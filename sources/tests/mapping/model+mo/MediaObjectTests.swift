import CoreData
import TumblrNPF
import TumblrNPFPersistence
import XCTest

final class MediaObjectTests: MOTestCase
{
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
        url: URL(string: "https://domain.com/mediaObject.gif")!,
        width: 500
    )

    func testCreateModelFromJSON() throws {
        let jsonData = try BundleFile(filename: "mediaObject.json").data
        let modelFromJSON = try! JSONDecoder().decode(MediaObject.self, from: jsonData)
        compareMediaObject(model1: modelFromJSON, model2: model)
    }

    // manual test of MO created from a model
    func testCreateMOFromModel() throws {
        let mo = MediaObjectMO(model: model, context: context)
        guard let model = MediaObject(mo: mo) else {
            XCTFail("Couldn’t create media object")
            return
        }
        compareMediaObject(mo: mo, model: model)
    }

    // auto test of MO created from a model
    func testAutoCompare() {
        let mo = MediaObjectMO(model: model, context: context)
        Equality(mo, model).assert()
    }

    // MARK: - Manual comparison

    // manual compare of MO and model
    func compareMediaObject(mo: MediaObjectMO?, model: MediaObject?) {
        guard let mo = mo, let model = model else {
            if (mo == nil && model != nil) || (mo != nil && model == nil) {
                XCTFail("mo and model are not both nil or non nil")
            }
            return
        }
        XCTAssertTrue(mo.cropped?.boolValue == model.cropped)
        XCTAssertTrue(mo.hasOriginalDimensions?.boolValue == model.hasOriginalDimensions)
        XCTAssertTrue(mo.height?.intValue == model.height)
        XCTAssertTrue(mo.originalDimensionsMissing?.boolValue == model.originalDimensionsMissing)
        compareMediaObject(mo: mo.poster, model: model.poster?.media)
        XCTAssertEqual(mo.type, model.type)
        XCTAssertEqual(mo.url, model.url)
        XCTAssertTrue(mo.width?.intValue == model.width)
    }

    // manual compare of two models
    func compareMediaObject(model1: MediaObject?, model2: MediaObject?) {
        guard let model1 = model1, let model2 = model2 else {
            if (model1 == nil && model2 != nil) || (model1 != nil && model2 == nil) {
                XCTFail("mo and model are not both nil or non nil")
            }
            return
        }
        XCTAssertTrue(model1.cropped == model2.cropped)
        XCTAssertTrue(model1.hasOriginalDimensions == model2.hasOriginalDimensions)
        XCTAssertTrue(model1.height == model2.height)
        XCTAssertTrue(model1.originalDimensionsMissing == model2.originalDimensionsMissing)
        compareMediaObject(model1: model1.poster?.media, model2: model2.poster?.media)
        XCTAssertEqual(model1.type, model2.type)
        XCTAssertEqual(model1.url, model2.url)
        XCTAssertTrue(model1.width == model2.width)
    }
}
