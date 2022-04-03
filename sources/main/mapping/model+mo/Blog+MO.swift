import CodableHelpers
import Foundation
import TumblrNPF

public extension Blog {
    init?(mo: BlogMO, skipPosts: Bool = false)
    {
        let postMOs = mo.posts?.allObjects as? [PostMO] ?? []
        let posts: [Post] = skipPosts ? [] : postMOs.compactMap { Post(mo: $0) }

        let avatarMOs: [AvatarMO] = mo.avatar?.allObjects as? [AvatarMO] ?? []
        let avatars: [Avatar] = avatarMOs.compactMap { Avatar(mo: $0) }

        self.init(allowSearchIndexing: mo.allowSearchIndexing?.boolValue,
                  ask: mo.ask?.boolValue,
                  askPageTitle: mo.askPageTitle,
                  avatar: avatars,
                  canBeFollowed: mo.canBeFollowed?.boolValue,
                  canSubmit: mo.canSubmit?.boolValue,
                  canSubscribe: mo.canSubscribe?.boolValue,
                  followed: mo.followed?.boolValue,
                  isBlockedFromPrimary: mo.isBlockedFromPrimary?.boolValue,
                  isHiddenFromBlogNetwork: mo.isHiddenFromBlogNetwork?.boolValue,
                  isOptoutAds: mo.isOptoutAds?.boolValue,
                  name: mo.name,
                  paywallAccess: mo.paywallAccess.flatMap { CodableBoolOrString(stringLiteral: $0) },
                  posts: posts,
                  shareLikes: mo.shareLikes?.boolValue,
                  subscribed: mo.subscribed?.boolValue,
                  subscriptionPlan: mo.subscriptionPlan.flatMap { SubscriptionPlan(mo: $0) },
                  theme: mo.theme.flatMap { Theme(mo: $0) },
                  title: mo.title,
                  url: mo.url,
                  uuid: mo.uuid)
    }
}
