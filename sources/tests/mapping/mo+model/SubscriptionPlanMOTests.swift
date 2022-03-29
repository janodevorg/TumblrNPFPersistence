import CoreData
@testable import TumblrNPFPersistence
@testable import TumblrNPF
import XCTest

final class SubscriptionPlanMOTests: MOTestCase
{
    func testSubscriptionPlan() throws {
        let subMO = try createSubscriptionPlanMO(filename: "subscriptionPlan.json")
        XCTAssertEqual(subMO?.desc, "Subscribe to my blog!")
        XCTAssertEqual(subMO?.currencyCode, "USD")
        XCTAssertEqual(subMO?.monthlyPrice, "199")
        XCTAssertEqual(subMO?.yearlyPrice, nil)
        XCTAssertEqual(subMO?.memberPerks, ["Bonus Content", "creative prompts", "commissioned art"])
        XCTAssertEqual(subMO?.subscriptionLabel, "Post+")
        XCTAssertEqual(subMO?.checkoutLabels?.monthly, "Subscribe for %s/month*")
        XCTAssertEqual(subMO?.checkoutLabels?.yearly, "%s/year*. 2 months FREE!")
        XCTAssertEqual(subMO?.checkoutLabels?.support, "Show your Support")
    }

    // MARK: - Private

    private func createSubscriptionPlanMO(filename: String) throws -> SubscriptionPlanMO? {
        let jsonData = try BundleFile(filename: filename).data
        let model = try! JSONDecoder().decode(SubscriptionPlan.self, from: jsonData)
        return SubscriptionPlanMO(model: model, context: context)
    }
}
