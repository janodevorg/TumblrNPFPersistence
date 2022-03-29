import CoreData
import Foundation
import os
import TumblrNPF

public extension PostMO
{
    /// Updates an existing instance or creates a new one.
    static func upsert(model: Post?, context: NSManagedObjectContext) -> PostMO? {
        guard let model = model else {
            return nil
        }
        let id = model.id.value
        let fetchRequest = NSFetchRequest<PostMO>(entityName: PostMO.entityName())
        // string because NSPredicate doesn’t handle Int64 👇
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(id)")
        if let firstPost = try? context.fetch(fetchRequest).first {
            firstPost.update(with: model, context: context)
            return firstPost
        } else {
            return PostMO(model: model, context: context)
        }
    }

    private static var log: Logger {
        Logger(subsystem: "dev.jano", category: "persistence")
    }

    /// Creates a new instance.
    /// Private because this managed object has a unique constraint 'id', so we must upsert to avoid duplicates.
    private convenience init?(model: Post?, context: NSManagedObjectContext) {
        guard let model = model else {
            return nil
        }
        self.init(model: model, context: context)
    }

    /// Creates a new instance
    /// Private because this managed object has a unique constraint 'id', so we must upsert to avoid duplicates.
    private convenience init(model: Post, context: NSManagedObjectContext) {
        self.init(using: context)
        update(with: model, context: context)
    }

    /// Updates properties with the given model.
    private func update(with model: Post, context: NSManagedObjectContext)
    {
        self.id = "\(model.id.value)"
        self.blog = BlogMO.upsert(model: model.basePost.blog, context: context)
        self.blogName = model.basePost.blogName
        self.canDelete = model.basePost.canDelete.flatMap { $0 as NSNumber }
        self.canEdit = model.basePost.canEdit.flatMap { $0 as NSNumber }
        self.canLike = model.basePost.canLike.flatMap { $0 as NSNumber }
        self.canReblog = model.basePost.canReblog.flatMap { $0 as NSNumber }
        self.canReply = model.basePost.canReply.flatMap { $0 as NSNumber }
        self.canSendInMessage = model.basePost.canSendInMessage.flatMap { $0 as NSNumber }
        self.classification = model.basePost.classification
        let content: [ContentMO]? = model.basePost.content?.compactMap { ContentMO.map(model: $0, context: context) }
        self.content = content.flatMap { NSSet(array: $0) }
        self.date = model.basePost.date
        self.displayAvatar = model.basePost.displayAvatar.flatMap { $0 as NSNumber }
        self.embedURL = model.basePost.embedURL
        self.followed = model.basePost.followed.flatMap { $0 as NSNumber }
        self.idString = model.basePost.idString
        self.interactabilityReblog = model.basePost.interactabilityReblog
        self.isNSFW = model.basePost.isNSFW.flatMap { $0 as NSNumber }
        self.isPaywalled = model.basePost.isPaywalled.flatMap { $0 as NSNumber }

        let layout: [LayoutMO]? = model.basePost.layout?.compactMap { LayoutMO.map(model: $0, context: context) }
        self.layout = layout.flatMap { NSSet(array: $0) }

        self.likeCount = model.basePost.likeCount.flatMap { $0 as NSNumber }
        self.liked = model.basePost.liked.flatMap { $0 as NSNumber }
        self.noteCount = model.basePost.noteCount.flatMap { $0 as NSNumber }
        self.nsfwScore = model.basePost.nsfwScore.flatMap { $0 as NSNumber }
        self.objectType = model.basePost.objectType
        self.originalType = model.basePost.originalType
        self.paywallAccess = model.basePost.paywallAccess?.rawValue

        let basePost: BasePost? = model.basePost.paywallReblogView?.post
        self.paywallReblogView = basePost.flatMap { BasePostMO(model: $0, context: context) }

        self.postURL = model.basePost.postURL
        self.reblogCount = model.basePost.reblogCount.flatMap { $0 as NSNumber }
        self.reblogKey = model.basePost.reblogKey
        self.recommendedColor = model.basePost.recommendedColor
        self.recommendedSource = model.basePost.recommendedSource
        self.replyCount = model.basePost.replyCount.flatMap { $0 as NSNumber }
        self.shortURL = model.basePost.shortURL
        self.shouldOpenInLegacy = model.basePost.shouldOpenInLegacy.flatMap { $0 as NSNumber }
        self.slug = model.basePost.slug
        self.state = model.basePost.state
        self.summary = model.basePost.summary
        self.tags = model.basePost.tags
        self.timestamp = model.basePost.timestamp.flatMap { Int($0) as NSNumber }

        let trail: [TrailMO]? = model.basePost.trail?.map { TrailMO(model: $0, context: context) }
        self.trail = trail.flatMap { NSSet(array: $0) }
        self.type = model.basePost.type
    }
}
