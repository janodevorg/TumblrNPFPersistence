import CoreData
import Foundation
import TumblrNPF

public extension TextContentMO
{
    convenience init?(model: TextContent?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: TextContent, context: NSManagedObjectContext) {
        self.init(using: context)
        self.indentLevel = model.indentLevel.flatMap { $0 as NSNumber }
        let formattingMO = (model.formatting.flatMap { $0 })?.compactMap { FormattingMO(model: $0, context: context) }
        self.formatting = formattingMO.flatMap { NSSet(array: $0) }
        if model.subtype != .unknown {
            self.subtype = model.subtype?.rawValue
        }
        self.text = model.text
        self.type = model.type
    }
}
