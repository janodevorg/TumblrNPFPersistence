import CoreData
import Foundation
import TumblrNPF

public extension FormattingMO
{
    convenience init?(model: Formatting?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init?(model: Formatting, context: NSManagedObjectContext) {
        self.init(using: context)
        self.blog = BlogMO.upsert(model: model.blog, context: context)
        self.end = model.end as NSNumber
        self.font = model.font.fontName
        self.hex = model.hex
        self.start = model.start as NSNumber
        self.type = model.type.rawValue
        self.url = model.url
    }
}
