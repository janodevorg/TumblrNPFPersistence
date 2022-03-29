import TumblrNPF

public extension ImageContent {
    init?(mo: ImageContentMO) {
        let media: [MediaObject]? = (mo.media?.allObjects as? [MediaObjectMO] ?? []).compactMap { MediaObject(mo: $0) }
        let poster: MediaObject? = mo.poster.flatMap { MediaObject(mo: $0) }
        self.init(
            altText: mo.altText,
            attribution: mo.attribution.flatMap { AttributionObject.map(mo: $0) },
            caption: mo.caption,
            colors: mo.colors,
            feedbackToken: mo.feedbackToken,
            media: media ?? [],
            poster: poster,
            type: mo.type
        )
    }
}
