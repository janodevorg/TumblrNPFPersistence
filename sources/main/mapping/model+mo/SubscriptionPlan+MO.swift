import TumblrNPF

public extension SubscriptionPlan
{
    init?(mo: SubscriptionPlanMO)
    {
        var checkoutLabels: CheckoutLabels?
        if let monthly = mo.monthly,
           let support = mo.support,
           let yearly = mo.yearly {
            checkoutLabels = CheckoutLabels(monthly: monthly, support: support, yearly: yearly)
        }
        guard
            let checkoutLabels = checkoutLabels,
            let currencyCode = mo.currencyCode,
            let desc = mo.desc,
            let isValid = mo.isValid?.boolValue,
            let memberPerks = mo.memberPerks,
            let monthlyPrice = mo.monthlyPrice,
            let subscriptionLabel = mo.subscriptionLabel,
            let yearlyPrice = mo.yearlyPrice
        else {
                return nil
            }

        self.init(
            checkoutLabels: checkoutLabels,
            currencyCode: currencyCode,
            desc: desc,
            isValid: isValid,
            memberPerks: memberPerks,
            monthlyPrice: monthlyPrice,
            subscriptionLabel: subscriptionLabel,
            yearlyPrice: yearlyPrice
        )
    }
}
