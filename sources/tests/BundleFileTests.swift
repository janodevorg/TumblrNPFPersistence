@testable import TumblrNPFPersistence
@testable import TumblrNPF
import XCTest

final class BundleFileTests: XCTestCase
{
    func testBundleFile() throws {
        let file = BundleFile(filename: "layout1.json")
        XCTAssertNotNil(try file.data)
        XCTAssertNotNil(try file.string)
    }
}
