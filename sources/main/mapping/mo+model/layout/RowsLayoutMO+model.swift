import CoreData
import Foundation
import TumblrNPF

public extension RowsLayoutMO
{
    convenience init?(model: RowsLayout?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: RowsLayout, context: NSManagedObjectContext) {
        self.init(using: context)
        self.type = model.type
        self.truncateAfter = model.truncateAfter.flatMap { $0 as NSNumber }
        let rowLayout: [RowLayoutMO]? = model.display.map { RowLayoutMO(model: $0, context: context) }
        self.display = rowLayout.flatMap { NSSet(array: $0) }
    }
}
