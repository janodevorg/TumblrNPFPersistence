import CoreData
import Foundation
import TumblrNPF

public extension TrailMO
{
    convenience init?(model: Trail?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: Trail, context: NSManagedObjectContext) {
        self.init(using: context)
        self.brokenBlogName = model.brokenBlogName
        self.blog = BlogMO.upsert(model: model.blog, context: context)
        self.post = model.post.flatMap { PostMO.upsert(model: $0, context: context) }
        let content: [ContentMO]? = model.content.compactMap { ContentMO.map(model: $0, context: context) }
        self.content = content.flatMap { NSSet(array: $0) }
        let layout: [LayoutMO]? = model.layout.compactMap { LayoutMO.map(model: $0, context: context) }
        self.layout = layout.flatMap { NSSet(array: $0) }
    }
}
