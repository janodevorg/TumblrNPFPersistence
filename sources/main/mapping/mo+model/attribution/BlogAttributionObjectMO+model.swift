import CoreData
import Foundation
import TumblrNPF

public extension BlogAttributionObjectMO
{
    convenience init?(model: BlogAttributionObject?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: BlogAttributionObject, context: NSManagedObjectContext) {
        self.init(using: context)
        self.blog = BlogMO.upsert(model: model.blog, context: context)
        self.type = model.type
        self.url = model.url
    }
}
