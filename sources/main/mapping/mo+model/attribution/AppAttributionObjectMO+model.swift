import CoreData
import Foundation
import TumblrNPF

public extension AppAttributionObjectMO
{
    convenience init?(model: AppAttributionObject?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: AppAttributionObject, context: NSManagedObjectContext) {
        self.init(using: context)
        self.appName = model.appName
        self.displayText = model.displayText
        self.logo = MediaObjectMO(model: model.logo, context: context)
        self.type = model.type
        self.url = model.url
    }
}
