import CoreData
@testable import TumblrNPF
@testable import TumblrNPFPersistence
import XCTest

final class PaywallMOTests: MOTestCase
{
    func testPaywallCTA() throws {
        let postMO = try createPostMO(filename: "paywallCTA.json")
        XCTAssertEqual(postMO?.id, "1234567891234567")
        let paywall = postMO?.content?.allObjects.first as? PaywallCTAMO
        XCTAssertEqual(paywall?.type, "paywall")
        XCTAssertEqual(paywall?.subtype, "cta")
        XCTAssertEqual(paywall?.url, URL(string: "https://tumblr.com/creator/acoolcreatorblog")!) // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(paywall?.title, "For Supporters")
        XCTAssertEqual(paywall?.text, "Support %s by subscribing to their +Posts. As a supporter you'll get access to exclusive content and perks.")
    }

    func testPaywallDivider() throws {
        let postMO = try createPostMO(filename: "paywallDivider.json")
        XCTAssertEqual(postMO?.id, "1234567891234567")
        let paywall = postMO?.content?.allObjects.first as? PaywallDividerMO
        XCTAssertEqual(paywall?.color, "#eeeee")
        XCTAssertEqual(paywall?.isVisible, true)
        XCTAssertEqual(paywall?.subtype, "divider")
        XCTAssertEqual(paywall?.text, "the teaser label")
        XCTAssertEqual(paywall?.type, "paywall")
        XCTAssertEqual(paywall?.url, URL(string: "https://tumblr.com/creator/acoolcreatorblog")!) // swiftlint:disable:this force_unwrapping
    }

    // MARK: - Private

    private func createPostMO(filename: String) throws -> PostMO? {
        let jsonData = try BundleFile(filename: filename).data
        guard let model = try? JSONDecoder().decode(Post.self, from: jsonData) else {
            XCTFail("Expected to create Post")
            return nil
        }
        return PostMO.upsert(model: model, context: context)
    }
}
