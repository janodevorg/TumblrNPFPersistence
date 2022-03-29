import TumblrNPF

public extension PostAttributionObject {
    init?(mo: PostAttributionObjectMO) {
        guard
            let blog = (mo.blog.flatMap { Blog(mo: $0) }),
            let url = mo.url,
            let post = (mo.post.flatMap { Post(mo: $0) }),
            let type = mo.type
        else {
            return nil
        }
        self.init(blog: blog, url: url, post: post, type: type)
    }
}
