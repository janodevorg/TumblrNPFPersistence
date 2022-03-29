import Foundation
import TumblrNPF

public extension Layout
{
    static func map(mo: LayoutMO) -> Layout? {
        switch mo {
        case let ask as AskLayoutMO: return AskLayout(mo: ask).flatMap { .ask($0) }
        case let condensed as CondensedLayoutMO: return CondensedLayout(mo: condensed).flatMap { .condensed($0) }
        case let rows as RowsLayoutMO: return RowsLayout(mo: rows).flatMap { .rows($0) }
        default: return nil
        }
    }
}
