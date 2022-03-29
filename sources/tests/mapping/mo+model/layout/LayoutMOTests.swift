import CoreData
@testable import TumblrNPFPersistence
@testable import TumblrNPF
import XCTest

final class LayoutMOTests: MOTestCase
{
    // RowsLayoutMO
    func testLayout1() throws {
        let rowsLayoutMO = try createRowsLayoutMO(filename: "layout1.json")
        XCTAssertEqual(rowsLayoutMO.type, "rows")
        XCTAssert(rowsLayoutMO.display?.allObjects.count == 2)
    }

    // RowsLayoutMO
    func testLayout2() throws {
        let rowsLayoutMO = try createRowsLayoutMO(filename: "layout2.json")
        XCTAssertEqual(rowsLayoutMO.type, "rows")
        let carousel = rowsLayoutMO.display?.first(where: { object in
            (object as? RowLayoutMO)?.mode == "carousel"
        })
        XCTAssertNotNil(carousel)
    }

    // RowsLayoutMO
    func testLayout3() throws {
        let layoutMO = try createLayoutMO(filename: "layout3.json")
        guard let rowsLayoutMO = layoutMO as? RowsLayoutMO else {
            XCTFail("Expected RowsLayoutMO, got \(type(of: layoutMO))")
            return
        }
        XCTAssertEqual(rowsLayoutMO.truncateAfter?.intValue, 1)
        XCTAssertEqual(rowsLayoutMO.type, "rows")
        XCTAssertEqual(rowsLayoutMO.display?.count, 2)
    }

    // CondensedLayoutMO
    func testLayout4() throws {
        let layoutMO = try createLayoutMO(filename: "layout4.json")
        guard let condensed = layoutMO as? CondensedLayoutMO else {
            XCTFail("Expected CondensedLayoutMO")
            return
        }
        XCTAssertEqual(condensed.truncateAfter?.intValue, 1)
        XCTAssertEqual(condensed.type, "condensed")
    }

    // CondensedLayoutMO
    func testLayout5() throws {
        let layoutMO = try createLayoutMO(filename: "layout5.json")
        guard let condensed = layoutMO as? CondensedLayoutMO else {
            XCTFail("Expected CondensedLayoutMO")
            return
        }
        XCTAssertEqual(condensed.truncateAfter?.intValue, 3)
        XCTAssertEqual(condensed.type, "condensed")
        XCTAssertEqual(condensed.blocks?.count, 4)
    }

    // AskLayoutMO
    func testLayout6() throws {
        let layoutMO = try createLayoutMO(filename: "layout6.json")
        guard let askLayout = layoutMO as? AskLayoutMO else {
            XCTFail("Expected AskLayoutMO")
            return
        }
        XCTAssertEqual(askLayout.type, "ask")
        XCTAssertEqual(askLayout.blocks?.count, 2)
        guard let attribution = askLayout.attribution as? BlogAttributionObjectMO else {
            XCTFail("Expected BlogAttributionObjectMO")
            return
        }
        XCTAssertEqual(attribution.type, "blog")
        XCTAssertEqual(attribution.url?.absoluteString, "https://cyle.tumblr.com")
    }

    // MARK: - Private

    private func createRowsLayoutMO(filename: String) throws -> RowsLayoutMO {
        let jsonData = try BundleFile(filename: filename).data
        let rowsLayout = try! JSONDecoder().decode(RowsLayout.self, from: jsonData)
        return RowsLayoutMO(model: rowsLayout, context: context)
    }

    private func createLayoutMO(filename: String) throws -> LayoutMO? {
        let jsonData = try BundleFile(filename: filename).data
        let model = try! JSONDecoder().decode(Layout.self, from: jsonData)
        return LayoutMO.map(model: model, context: context)
    }
}
