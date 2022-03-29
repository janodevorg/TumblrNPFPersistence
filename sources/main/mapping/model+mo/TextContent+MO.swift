import TumblrNPF

public extension TextContent {
    init?(mo: TextContentMO) {
        guard let text = mo.text, let type = mo.type else { return nil }
        let formatting: [Formatting]? = (mo.formatting?.allObjects as? [FormattingMO] ?? []).compactMap { Formatting(mo: $0) }

        self.init(formatting: formatting,
                  indentLevel: mo.indentLevel?.intValue,
                  subtype: mo.subtype.flatMap { TextBlockSubtype(rawValue: $0) },
                  text: text,
                  type: type)
    }
}
