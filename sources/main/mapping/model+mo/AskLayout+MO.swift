import TumblrNPF

public extension AskLayout {
    init?(mo: AskLayoutMO) {
        guard
            let attributionMO = mo.attribution,
            let type = mo.type
        else {
            return nil
        }
        self.init(
            attribution: AttributionObject.map(mo: attributionMO),
            blocks: mo.blocks ?? [],
            type: type
        )
    }
}
