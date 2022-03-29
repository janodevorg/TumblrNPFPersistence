import TumblrNPF

public extension CondensedLayout {
    init?(mo: CondensedLayoutMO) {
        guard let type = mo.type else { return nil }
        self.init(
            blocks: mo.blocks,
            truncateAfter: mo.truncateAfter?.intValue,
            type: type
        )
    }
}
