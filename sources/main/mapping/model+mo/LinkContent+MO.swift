import TumblrNPF

public extension LinkContent {
    init?(mo: LinkContentMO) {
        guard let type = mo.type, let url = mo.url else { return nil }
        let poster: [MediaObject]? = (mo.poster?.allObjects as? [MediaObjectMO] ?? []).compactMap { MediaObject(mo: $0) }
        self.init(
            author: mo.author,
            description: mo.desc,
            displayURL: mo.displayURL,
            poster: poster,
            siteName: mo.siteName,
            title: mo.title,
            type: type,
            url: url
        )
    }
}
