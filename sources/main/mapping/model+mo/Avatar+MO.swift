import TumblrNPF

public extension Avatar {
    init?(mo: AvatarMO) {
        guard let height = mo.height, let url = mo.url, let width = mo.width else {
            return nil
        }
        self.init(height: height.intValue, url: url, width: width.intValue)
    }
}
