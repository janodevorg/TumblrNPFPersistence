import CoreData
import CoreDataStack
import Foundation
import TumblrNPF

extension Blog: Persistable {
    public func mapPersistable(context: NSManagedObjectContext) -> BlogMO? {
        BlogMO.upsert(model: self, context: context)
    }
}
