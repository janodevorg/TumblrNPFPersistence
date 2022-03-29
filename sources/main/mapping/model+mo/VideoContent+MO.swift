import TumblrNPF

public extension VideoContent
{
    init?(mo: VideoContentMO)
    {
        guard let type = mo.type else { return nil }
        let media: MediaObject? = mo.media.flatMap { MediaObject(mo: $0) }
        let poster: [MediaObject]? = (mo.poster?.allObjects as? [MediaObjectMO] ?? []).compactMap { MediaObject(mo: $0) }
        let filmstrip: [MediaObject]? = (mo.filmstrip?.allObjects as? [MediaObjectMO] ?? []).compactMap { MediaObject(mo: $0) }

        var embedIFrame: EmbedVideoIframe?
        if let height = mo.height?.intValue, let url = mo.url, let width = mo.width?.intValue {
            embedIFrame = EmbedVideoIframe(height: height, url: url, width: width)
        }

        self.init(attribution: mo.attribution.flatMap { AttributionObject.map(mo: $0) },
                  canAutoplayOnCellular: mo.canAutoplayOnCellular?.boolValue,
                  embedHTML: mo.embedHTML,
                  embedIFrame: embedIFrame,
                  embedURL: mo.embedURL,
                  filmstrip: filmstrip,
                  media: media,
                  provider: mo.provider,
                  poster: poster,
                  type: type,
                  url: mo.url)
    }
}
