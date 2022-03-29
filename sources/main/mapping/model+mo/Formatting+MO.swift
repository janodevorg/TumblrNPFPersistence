import TumblrNPF

public extension Formatting {
    init?(mo: FormattingMO) {
        guard
            let blog = mo.blog.flatMap({ Blog(mo: $0) }),
            let end = mo.end?.intValue,
            let start = mo.start?.intValue,
            let type = mo.type.flatMap({ FormatType(rawValue: $0) })
        else {
            return nil
        }
        self.init(
            blog: blog,
            end: end,
            start: start,
            type: type,
            url: mo.url,
            hex: mo.hex
        )
    }
}
