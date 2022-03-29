import CoreData
import Foundation
import TumblrNPF

public extension PostAttributionObjectMO
{
    convenience init?(model: PostAttributionObject?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: PostAttributionObject, context: NSManagedObjectContext) {
        self.init(using: context)
        blog = BlogMO.upsert(model: model.blog, context: context)
        post = PostMO.upsert(model: model.post, context: context)
        type = model.type
        url = model.url
    }
}
