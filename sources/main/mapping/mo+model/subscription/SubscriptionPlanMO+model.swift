import CoreData
import Foundation
import TumblrNPF

public extension SubscriptionPlanMO
{
    convenience init?(model: SubscriptionPlan?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: SubscriptionPlan, context: NSManagedObjectContext) {
        self.init(using: context)

        self.checkoutLabels = CheckoutLabelsMO(model: model.checkoutLabels, context: context)
        self.currencyCode = model.currencyCode
        self.desc = model.desc
        self.isValid = model.isValid.flatMap { $0 as NSNumber }
        self.memberPerks = model.memberPerks
        self.monthlyPrice = model.monthlyPrice
        self.subscriptionLabel = model.subscriptionLabel
        self.yearlyPrice = model.yearlyPrice

        self.monthly = model.checkoutLabels?.monthly
        self.support = model.checkoutLabels?.support
        self.yearly = model.checkoutLabels?.yearly
    }
}
