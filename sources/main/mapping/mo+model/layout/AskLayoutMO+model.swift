import CoreData
import Foundation
import TumblrNPF

public extension AskLayoutMO
{
    convenience init?(model: AskLayout?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: AskLayout, context: NSManagedObjectContext) {
        self.init(using: context)
        self.type = model.type
        self.blocks = model.blocks
        self.attribution = AttributionObjectMO.map(model: model.attribution, context: context)
    }
}
