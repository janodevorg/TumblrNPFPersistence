import CoreData
import Foundation
import TumblrNPF

public extension MediaObjectMO
{
    convenience init?(model: MediaObject?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }
    
    convenience init(model: MediaObject, context: NSManagedObjectContext) {
        self.init(using: context)
        self.cropped = model.cropped.flatMap { $0 as NSNumber }
        self.hasOriginalDimensions = model.hasOriginalDimensions.flatMap { $0 as NSNumber }
        self.hd = model.hd.flatMap { $0 as NSNumber }
        self.height = model.height.flatMap { $0 as NSNumber }
        self.originalDimensionsMissing = model.originalDimensionsMissing.flatMap { $0 as NSNumber }
        self.poster = MediaObjectMO(model: model.poster?.media, context: context)
        self.type = model.type
        self.url = model.url
        self.width = model.width.flatMap { $0 as NSNumber }
    }
}
