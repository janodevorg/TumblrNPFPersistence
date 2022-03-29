import CoreData
import Foundation
import TumblrNPF

public extension ContentMO
{
    static func map(model: Content?, context: NSManagedObjectContext) -> ContentMO?
    {
        guard let model = model else { return nil }
        switch model {
        case .audio(let content): return AudioContentMO(model: content, context: context)
        case .image(let content): return ImageContentMO(model: content, context: context)
        case .link(let content): return LinkContentMO(model: content, context: context)
        case .paywall(let content): return PaywallContentMO.map(model: content, context: context)
        case .text(let content): return TextContentMO(model: content, context: context)
        case .video(let content): return VideoContentMO(model: content, context: context)
        case .unknown: return nil
        }
    }
}
