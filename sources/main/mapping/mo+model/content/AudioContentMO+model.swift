import CoreData
import Foundation
import TumblrNPF

public extension AudioContentMO
{
    convenience init?(model: AudioContent?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: AudioContent, context: NSManagedObjectContext) {
        self.init(using: context)
        self.album = model.album
        self.artist = model.artist
        self.attribution = model.attribution.flatMap { AttributionObjectMO.map(model: $0, context: context) }
        self.embedHTML = model.embedHTML
        self.embedURL = model.embedURL
        self.media = model.media.flatMap { MediaObjectMO(model: $0, context: context) }

        let poster: [MediaObjectMO]? = model.poster.flatMap { $0 }?.map { MediaObjectMO(model: $0, context: context) }
        self.poster = poster.flatMap { NSSet(array: $0) }

        self.provider = model.provider
        self.title = model.title
        self.type = model.type
        self.url = model.url
    }
}
