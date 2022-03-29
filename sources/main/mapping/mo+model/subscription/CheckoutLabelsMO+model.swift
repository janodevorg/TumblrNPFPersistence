import CoreData
import Foundation
import TumblrNPF

public extension CheckoutLabelsMO
{
    convenience init?(model: CheckoutLabels?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: CheckoutLabels, context: NSManagedObjectContext) {
        self.init(using: context)
        self.monthly = model.monthly
        self.support = model.support
        self.yearly = model.yearly
    }
}
