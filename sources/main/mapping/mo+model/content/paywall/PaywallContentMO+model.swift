import CoreData
import Foundation
import TumblrNPF

public extension PaywallContentMO
{
    static func map(model: PaywallContent?, context: NSManagedObjectContext) -> PaywallContentMO?
    {
        guard let model = model else { return nil }
        switch model {
        case .cta(let content): return PaywallCTAMO(model: content, context: context)
        case .disabled(let content): return PaywallDisabledMO(model: content, context: context)
        case .divider(let content): return PaywallDividerMO(model: content, context: context)
        case .unknown: return nil
        }
    }
}
