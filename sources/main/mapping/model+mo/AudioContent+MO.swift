import Foundation
import TumblrNPF

public extension AudioContent {
    init?(mo: AudioContentMO) {
        let mediaObject: MediaObject? = mo.media.flatMap { MediaObject(mo: $0) }
        let mediaObjects: [MediaObject]? = (mo.poster?.allObjects as? [MediaObjectMO] ?? []).compactMap { MediaObject(mo: $0) }
        self.init(
            album: mo.album,
            artist: mo.artist,
            attribution: mo.attribution.flatMap { AttributionObject.map(mo: $0) },
            embedHTML: mo.embedHTML,
            embedURL: mo.embedURL,
            media: mediaObject,
            poster: mediaObjects,
            provider: mo.provider,
            title: mo.title,
            type: mo.type,
            url: mo.url
        )
    }
}
