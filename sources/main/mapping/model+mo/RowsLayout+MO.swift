import TumblrNPF

public extension RowsLayout {
    init?(mo: RowsLayoutMO) {
        guard let type = mo.type else { return nil }
        let display: [RowLayout] = (mo.display?.allObjects as? [RowLayoutMO] ?? []).compactMap { RowLayout(mo: $0) }
        guard !display.isEmpty else { return nil }
        self.init(
            display: display,
            truncateAfter: mo.truncateAfter?.intValue,
            type: type
        )
    }
}
