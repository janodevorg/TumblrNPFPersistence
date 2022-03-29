import TumblrNPF

public extension Content {

    static func map(mo: ContentMO) -> Content? {
        switch mo {
        case let audio as AudioContentMO: return AudioContent(mo: audio).flatMap { .audio($0) }
        case let image as ImageContentMO: return ImageContent(mo: image).flatMap { .image($0) }
        case let link as LinkContentMO: return LinkContent(mo: link).flatMap { .link($0) }
        case let paywall as PaywallContentMO: return PaywallContent.map(mo: paywall).flatMap { .paywall($0) }
        case let text as TextContentMO: return TextContent(mo: text).flatMap { .text($0) }
        case let video as VideoContentMO: return VideoContent(mo: video).flatMap { .video($0) }
        default: return nil
        }
    }
}
