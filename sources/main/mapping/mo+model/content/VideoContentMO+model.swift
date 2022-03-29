import CoreData
import Foundation
import TumblrNPF

public extension VideoContentMO
{
    convenience init?(model: VideoContent?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: VideoContent, context: NSManagedObjectContext) {
        self.init(using: context)
        self.attribution = model.attribution.flatMap { AttributionObjectMO.map(model: $0, context: context) }
        self.canAutoplayOnCellular = model.canAutoplayOnCellular.flatMap { $0 as NSNumber }
        self.embedHTML = model.embedHTML
        self.embedURL = model.embedURL

        if let height = model.embedIFrame?.height,
            let width = model.embedIFrame?.width,
            let url = model.embedIFrame?.url
        {
            self.iframeHeight = Int64(height)
            self.iframeWidth = Int64(width)
            self.iframeURL = url
        }
        let media: MediaObjectMO? = model.media.flatMap { MediaObjectMO(model: $0, context: context) }
        self.media = media

        let filmstrip: [MediaObjectMO] = (model.filmstrip ?? []).map { MediaObjectMO(model: $0, context: context) }
        self.filmstrip = NSSet(array: filmstrip)

        let poster: [MediaObjectMO] = (model.poster ?? []).map { MediaObjectMO(model: $0, context: context) }
        self.poster = NSSet(array: poster)
        self.provider = model.provider
        self.url = model.url
        self.type = model.type
    }
}
