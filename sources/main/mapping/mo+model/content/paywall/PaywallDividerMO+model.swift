import CoreData
import Foundation
import TumblrNPF

public extension PaywallDividerMO
{
    convenience init?(model: PaywallDivider?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: PaywallDivider, context: NSManagedObjectContext) {
        self.init(using: context)
        self.color = model.color
        self.isVisible = model.isVisible.flatMap { $0 as NSNumber }
        self.subtype = model.subtype
        self.text = model.text
        self.type = model.type
        self.url = model.url
    }
}
