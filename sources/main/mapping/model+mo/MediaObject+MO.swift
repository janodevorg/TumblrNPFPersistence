import TumblrNPF

public extension MediaObject {
    init?(mo: MediaObjectMO) {
        guard let url = mo.url else { return nil }
        self.init(
            cropped: mo.cropped?.boolValue,
            hasOriginalDimensions: mo.hasOriginalDimensions?.boolValue,
            hd: nil,
            height: mo.height?.intValue,
            originalDimensionsMissing: mo.originalDimensionsMissing?.boolValue,
            poster: mo.poster.flatMap { MediaObject(mo: $0) }.flatMap { MediaObjectWrap(media: $0) },
            type: mo.type,
            url: url,
            width: mo.width?.intValue
        )
    }
}
