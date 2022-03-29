import CoreData
@testable import TumblrNPFPersistence
@testable import TumblrNPF
import XCTest

final class TrailMOTests: MOTestCase
{
    func testTrail() throws {
        let trailMO = try createTrailMO(filename: "trail.json")
        XCTAssertEqual(trailMO?.post?.id, "12345")
        XCTAssertEqual(trailMO?.post?.isPaywalled, true)
        XCTAssertEqual(trailMO?.post?.paywallAccess, "non-member")
        XCTAssertEqual(trailMO?.blog?.name, "blog-that-has-a-paywall")
        XCTAssertEqual(trailMO?.blog?.subscriptionPlan?.desc, "Hey I'm Jeff....")
        XCTAssertEqual(trailMO?.blog?.subscriptionPlan?.currencyCode, "USD")
        XCTAssertEqual(trailMO?.blog?.subscriptionPlan?.monthlyPrice, "199")
        XCTAssertEqual(trailMO?.blog?.subscriptionPlan?.yearlyPrice, "2000")
        XCTAssertEqual(trailMO?.blog?.subscriptionPlan?.memberPerks, ["bonus content"])
        XCTAssertEqual(trailMO?.blog?.subscriptionPlan?.subscriptionLabel, "Post+")
        XCTAssertEqual(trailMO?.blog?.subscriptionPlan?.checkoutLabels?.monthly, "Subscribe for %s/month*")
        XCTAssertEqual(trailMO?.blog?.subscriptionPlan?.checkoutLabels?.yearly, "%s/year*. 2 months FREE!")
        XCTAssertEqual(trailMO?.blog?.subscriptionPlan?.checkoutLabels?.support, "Show Your Support")
        XCTAssertEqual(trailMO?.blog?.subscriptionPlan?.isValid, true)
    }

    // MARK: - Private

    private func createTrailMO(filename: String) throws -> TrailMO? {
        let jsonData = try BundleFile(filename: filename).data
        let trail = try! JSONDecoder().decode(Trail.self, from: jsonData)
        return TrailMO(model: trail, context: context)
    }
}
