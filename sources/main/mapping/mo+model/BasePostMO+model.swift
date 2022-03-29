import CoreData
import Foundation
import TumblrNPF

public extension BasePostMO
{
    convenience init?(model: BasePost?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: BasePost, context: NSManagedObjectContext) { // swiftlint:disable:this function_body_length
        self.init(using: context)

        self.blog = model.blog.flatMap { BlogMO.upsert(model: $0, context: context) }
        self.blogName = model.blogName
        self.canDelete = model.canDelete.flatMap { $0 as NSNumber }
        self.canEdit = model.canEdit.flatMap { $0 as NSNumber }
        self.canLike = model.canLike.flatMap { $0 as NSNumber }
        self.canReblog = model.canReblog.flatMap { $0 as NSNumber }
        self.canReply = model.canReply.flatMap { $0 as NSNumber }
        self.canSendInMessage = model.canSendInMessage.flatMap { $0 as NSNumber }
        self.classification = model.classification
        let content: [ContentMO]? = model.content?.compactMap { ContentMO.map(model: $0, context: context) }
        self.content = content.flatMap { NSSet(array: $0) }
        self.date = model.date
        self.displayAvatar = model.displayAvatar.flatMap { $0 as NSNumber }
        self.embedURL = model.embedURL
        self.followed = model.followed.flatMap { $0 as NSNumber }
        self.idString = model.idString
        self.interactabilityReblog = model.interactabilityReblog
        self.isNSFW = model.isNSFW.flatMap { $0 as NSNumber }
        self.isPaywalled = model.isPaywalled.flatMap { $0 as NSNumber }

        let layout: [LayoutMO]? = model.layout?.compactMap { LayoutMO.map(model: $0, context: context) }
        self.layout = layout.flatMap { NSSet(array: $0) }

        self.likeCount = model.likeCount.flatMap { $0 as NSNumber }
        self.liked = model.liked.flatMap { $0 as NSNumber }
        self.noteCount = model.noteCount.flatMap { $0 as NSNumber }
        self.nsfwScore = model.nsfwScore.flatMap { $0 as NSNumber }
        self.objectType = model.objectType
        self.originalType = model.originalType
        self.paywallAccess = model.paywallAccess?.rawValue

        let basePost: BasePost? = model.paywallReblogView?.post
        self.paywallReblogView = basePost.flatMap { BasePostMO(model: $0, context: context) }
        
        self.postURL = model.postURL
        self.reblogCount = model.reblogCount.flatMap { $0 as NSNumber }
        self.reblogKey = model.reblogKey
        self.recommendedColor = model.recommendedColor
        self.recommendedSource = model.recommendedSource
        self.replyCount = model.replyCount.flatMap { $0 as NSNumber }
        self.shortURL = model.shortURL
        self.shouldOpenInLegacy = model.shouldOpenInLegacy.flatMap { $0 as NSNumber }
        self.slug = model.slug
        self.state = model.state
        self.summary = model.summary
        self.tags = model.tags
        self.timestamp = model.timestamp.flatMap { Int($0) as NSNumber }
        let trail: [TrailMO]? = model.trail?.map { TrailMO(model: $0, context: context) }
        self.trail = trail.flatMap { NSSet(array: $0) }
        self.type = model.type
    }
}
