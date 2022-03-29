import TumblrNPF

public extension AttributionObject
{
    static func map(mo: AttributionObjectMO) -> AttributionObject? {
        switch mo {
        case let app as AppAttributionObjectMO: return AppAttributionObject(mo: app).flatMap { .app($0) }
        case let blog as BlogAttributionObjectMO: return BlogAttributionObject(mo: blog).flatMap { .blog($0) }
        case let link as LinkAttributionObjectMO: return LinkAttributionObject(mo: link).flatMap { .link($0) }
        case let post as PostAttributionObjectMO: return PostAttributionObject(mo: post).flatMap { .post($0) }
        default: return nil
        }
    }
}
