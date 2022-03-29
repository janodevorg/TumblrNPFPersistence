import CoreData
import Foundation
import TumblrNPF

public extension AvatarMO
{
    convenience init?(model: Avatar?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: Avatar, context: NSManagedObjectContext) {
        self.init(using: context)
        self.height = model.height as NSNumber
        self.url = model.url
        self.width = model.width as NSNumber
    }
}
