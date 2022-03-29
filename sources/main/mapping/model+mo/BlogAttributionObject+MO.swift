import TumblrNPF

public extension BlogAttributionObject {
    init?(mo: BlogAttributionObjectMO) {
        guard
            let blog = (mo.blog.flatMap { Blog(mo: $0) }),
            let type = mo.type
        else {
            return nil
        }
        self.init(blog: blog, type: type, url: mo.url)
    }
}
