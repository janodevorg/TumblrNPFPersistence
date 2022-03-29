import CoreData
import Foundation
import TumblrNPF

public extension AttributionObjectMO
{
    static func map(model: AttributionObject?, context: NSManagedObjectContext) -> AttributionObjectMO?
    {
        guard let model = model else { return nil }
        switch model {

        case .app(let appAttributionObject):
            return AppAttributionObjectMO(model: appAttributionObject, context: context)

        case .blog(let blogAttributionObject):
            return BlogAttributionObjectMO(model: blogAttributionObject, context: context)

        case .link(let linkAttributionObject):
            return LinkAttributionObjectMO(model: linkAttributionObject, context: context)

        case .post(let postAttributionObject):
            return PostAttributionObjectMO(model: postAttributionObject, context: context)

        case .unknown:
            return nil
        }
    }
}
