import CoreData
import Foundation
import TumblrNPF

public extension ImageContentMO
{
    convenience init?(model: ImageContent?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: ImageContent, context: NSManagedObjectContext) {
        self.init(using: context)
        self.altText = model.altText
        self.attribution = model.attribution.flatMap { AttributionObjectMO.map(model: $0, context: context) }
        self.caption = model.caption
        self.colors = model.colors
        self.feedbackToken = model.feedbackToken
        let media: [MediaObjectMO]? =  model.media.compactMap { MediaObjectMO(model: $0, context: context) }
        self.media = media.flatMap { NSSet(array: $0) }
        self.poster = model.poster.flatMap { MediaObjectMO(model: $0, context: context) }
    }
}
