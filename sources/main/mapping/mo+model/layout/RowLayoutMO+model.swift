import CoreData
import Foundation
import TumblrNPF

public extension RowLayoutMO
{
    convenience init?(model: RowLayout?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: RowLayout, context: NSManagedObjectContext) {
        self.init(using: context)
        self.blocks = model.blocks
        self.mode = model.mode?.type
    }
}
