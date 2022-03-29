import CoreData
import Foundation
import TumblrNPF

public extension LinkAttributionObjectMO
{
    convenience init?(model: LinkAttributionObject?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: LinkAttributionObject, context: NSManagedObjectContext) {
        self.init(using: context)
        self.url = model.url
        self.type = model.type
    }
}
