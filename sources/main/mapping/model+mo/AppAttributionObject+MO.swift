import TumblrNPF

public extension AppAttributionObject {
    init?(mo: AppAttributionObjectMO) {
        guard let url = mo.url, let type = mo.type else { return nil }
        self.init(
            appName: mo.appName,
            displayText: mo.displayText,
            logo: mo.logo.flatMap { MediaObject(mo: $0) },
            type: type,
            url: url
        )
    }
}
