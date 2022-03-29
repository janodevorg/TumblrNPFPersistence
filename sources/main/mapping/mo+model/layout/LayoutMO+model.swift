import CoreData
import Foundation
import TumblrNPF

public extension LayoutMO
{
    static func map(model: Layout?, context: NSManagedObjectContext) -> LayoutMO?
    {
        guard let model = model else { return nil }
        switch model {
        case .ask(let layout): return AskLayoutMO(model: layout, context: context)
        case .condensed(let layout): return CondensedLayoutMO(model: layout, context: context)
        case .rows(let layout): return RowsLayoutMO(model: layout, context: context)
        case .unknown: return nil
        }
    }
}
