import CoreData
import Foundation
import TumblrNPF

public extension PaywallCTAMO
{
    convenience init?(model: PaywallCTA?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: PaywallCTA, context: NSManagedObjectContext) {
        self.init(using: context)
        self.isVisible = model.isVisible.flatMap { $0 as NSNumber }
        self.subtype = model.subtype
        self.title = model.title
        self.text = model.text
        self.type = model.type
        self.url = model.url
    }
}
