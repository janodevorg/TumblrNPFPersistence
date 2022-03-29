import TumblrNPF

public extension RowLayout {
    init?(mo: RowLayoutMO) {
        self.init(
            blocks: mo.blocks ?? [],
            mode: mo.mode.flatMap { RowLayoutMode(type: $0) }
        )
    }
}
