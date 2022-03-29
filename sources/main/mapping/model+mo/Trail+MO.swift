import TumblrNPF

public extension Trail
{
    init?(mo: TrailMO, skipPost: Bool = false) {
        self.init(post: skipPost ? nil : mo.post.flatMap { Post(mo: $0) },
                  blog: mo.blog.flatMap { Blog(mo: $0) },
                  content: (mo.content?.allObjects as? [ContentMO] ?? []).compactMap { Content.map(mo: $0) },
                  layout: (mo.content?.allObjects as? [LayoutMO] ?? []).compactMap { Layout.map(mo: $0) },
                  brokenBlogName: mo.brokenBlogName)
    }
}
