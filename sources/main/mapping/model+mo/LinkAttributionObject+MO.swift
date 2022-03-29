import TumblrNPF

public extension LinkAttributionObject {
    init?(mo: LinkAttributionObjectMO) {
        guard let url = mo.url, let type = mo.type else { return nil }
        self.init(type: type, url: url)
    }
}
