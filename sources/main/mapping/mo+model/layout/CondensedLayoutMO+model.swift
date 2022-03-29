import CoreData
import Foundation
import TumblrNPF

public extension CondensedLayoutMO
{
    convenience init?(model: CondensedLayout?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: CondensedLayout, context: NSManagedObjectContext) {
        self.init(using: context)
        self.blocks = model.blocks
        self.truncateAfter = model.truncateAfter.flatMap { $0 as NSNumber }
        self.type = model.type
    }
}
