import CoreData
import CodableHelpers
import Foundation
import os
import TumblrNPF

public extension BlogMO
{
    /// Updates an existing instance or creates a new one.
    static func upsert(model: Blog?, context: NSManagedObjectContext) -> BlogMO? {

        guard let model = model else {
            return nil
        }

        guard let uuid = model.uuid else {
            return BlogMO(model: model, context: context)
        }

        let fetchRequest = NSFetchRequest<BlogMO>(entityName: BlogMO.entityName())
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", uuid)
        if let firstBlog = try? context.fetch(fetchRequest).first {
            firstBlog.update(with: model, context: context)
            return firstBlog
        } else {
            return BlogMO(model: model, context: context)
        }
    }

    private static var log: Logger {
        Logger(subsystem: "dev.jano", category: "persistence")
    }

    /// Creates a new instance.
    /// Private because this managed object has a unique constraint 'name', so we must upsert to avoid duplicates.
    private convenience init?(model: Blog?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    /// Creates a new instance
    /// Private because this managed object has a unique constraint 'name', so we must upsert to avoid duplicates.
    private convenience init(model: Blog, context: NSManagedObjectContext) {
        Self.log.debug("🐸 CREATED and saved")
        self.init(using: context)
        self.uuid = model.uuid
//        try? context.save()
        update(with: model, context: context)
    }

    /// Updates properties with the given model.
    private func update(with model: Blog, context: NSManagedObjectContext)
    {
        if let avatars = model.avatar {
            let avatarMOs = avatars.map { AvatarMO(model: $0, context: context) }
            self.avatar = NSSet(array: avatarMOs)
        }
        self.canBeFollowed = model.canBeFollowed.flatMap { $0 as NSNumber }
        self.followed = model.followed.flatMap { $0 as NSNumber }
        self.name = model.name
        if let posts = model.posts {
            let postMOs: [PostMO]? = posts.compactMap { PostMO.upsert(model: $0, context: context) }
            self.posts = postMOs.flatMap { NSSet(array: $0) }
        }
        self.theme = ThemeMO(model: model.theme, context: context)
        self.title = model.title
        self.uuid = model.uuid
        self.url = model.url
        self.subscriptionPlan = model.subscriptionPlan.flatMap { SubscriptionPlanMO(model: $0, context: context) }

        // The following are single blog properties. They appear when retrieving a blog by id.
        self.allowSearchIndexing = model.allowSearchIndexing.flatMap { $0 as NSNumber }
        self.ask = model.ask.flatMap { $0 as NSNumber }
        self.askPageTitle = model.askPageTitle
        self.canSubmit = model.canSubmit.flatMap { $0 as NSNumber }
        self.canSubscribe = model.canSubscribe.flatMap { $0 as NSNumber }
        self.isBlockedFromPrimary = model.isBlockedFromPrimary.flatMap { $0 as NSNumber }
        self.isHiddenFromBlogNetwork = model.isHiddenFromBlogNetwork.flatMap { $0 as NSNumber }
        self.isOptoutAds = model.isOptoutAds.flatMap { $0 as NSNumber }
        self.paywallAccess = model.paywallAccess?.string
        self.shareLikes = model.shareLikes.flatMap { $0 as NSNumber }
        self.subscribed = model.subscribed.flatMap { $0 as NSNumber }
    }
}
