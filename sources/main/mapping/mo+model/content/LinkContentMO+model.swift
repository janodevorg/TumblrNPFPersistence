import CoreData
import Foundation
import TumblrNPF

public extension LinkContentMO
{
    convenience init?(model: LinkContent?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: LinkContent, context: NSManagedObjectContext) {
        self.init(using: context)
        self.author = model.author
        self.desc = model.description
        self.displayURL = model.displayURL

        let poster: [MediaObjectMO]? = model.poster.flatMap { $0 }?.map { MediaObjectMO(model: $0, context: context) }
        self.poster = poster.flatMap { NSSet(array: $0) }

        self.siteName = model.siteName
        self.title = model.title
        self.type = model.type
        self.url = model.url
    }
}
