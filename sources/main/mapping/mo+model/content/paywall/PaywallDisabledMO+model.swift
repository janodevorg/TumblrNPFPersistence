import CoreData
import Foundation
import TumblrNPF

public extension PaywallDisabledMO
{
    convenience init?(model: PaywallDisabled?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: PaywallDisabled, context: NSManagedObjectContext) {
        self.init(using: context)
        self.isVisible = model.isVisible.flatMap { $0 as NSNumber }
        self.subtype = model.subtype
        self.text = model.text
        self.title = model.title
        self.type = model.type
        self.url = model.url
    }
}
