import TumblrNPF

public extension Post
{
    init?(mo: PostMO) // swiftlint:disable:this function_body_length
    {
        guard let stringId = mo.id, let id = Int64(stringId) else {
            return nil
        }
        let blog: Blog? = mo.blog.flatMap { Blog(mo: $0, skipPosts: true) }

        let basePost = BasePost(
            blog: blog,
            blogName: mo.blogName,
            canDelete: mo.canDelete?.boolValue,
            canEdit: mo.canEdit?.boolValue,
            canLike: mo.canLike?.boolValue,
            canReblog: mo.canReblog?.boolValue,
            canReply: mo.canReply?.boolValue,
            canSendInMessage: mo.canSendInMessage?.boolValue,
            classification: mo.classification,
            content: (mo.content?.allObjects as? [ContentMO] ?? []).compactMap { Content.map(mo: $0) },
            date: mo.date,
            displayAvatar: mo.displayAvatar?.boolValue,
            embedURL: mo.embedURL,
            followed: mo.followed?.boolValue,
            idString: mo.idString,
            interactabilityReblog: mo.interactabilityReblog,
            isNSFW: mo.isNSFW?.boolValue,
            isPaywalled: mo.isPaywalled?.boolValue,
            layout: (mo.layout?.allObjects as? [LayoutMO] ?? []).compactMap { Layout.map(mo: $0) },
            likeCount: mo.likeCount?.intValue,
            liked: mo.liked?.boolValue,
            noteCount: mo.noteCount?.intValue,
            nsfwScore: mo.nsfwScore?.intValue,
            objectType: mo.objectType,
            originalType: mo.originalType,
            paywallAccess: mo.paywallAccess.flatMap { PaywallAccess(rawValue: $0) },
            paywallReblogView: mo.paywallReblogView.flatMap { BasePost(mo: $0) }.flatMap { PostWrap(post: $0) },
            postURL: mo.postURL,
            reblogCount: mo.reblogCount?.intValue,
            reblogKey: mo.reblogKey,
            recommendedColor: mo.recommendedColor,
            recommendedSource: mo.recommendedSource,
            replyCount: mo.replyCount?.intValue,
            shortURL: mo.shortURL,
            shouldOpenInLegacy: mo.shouldOpenInLegacy?.boolValue,
            slug: mo.slug,
            state: mo.state,
            summary: mo.summary,
            tags: mo.tags,
            timestamp: mo.timestamp?.int64Value,
            trail: (mo.trail?.allObjects as? [TrailMO] ?? []).compactMap { Trail(mo: $0, skipPost: true) },
            type: mo.type
        )
        self.init(
            id: PostId(integerLiteral: id),
            basePost: basePost
        )
    }
}
