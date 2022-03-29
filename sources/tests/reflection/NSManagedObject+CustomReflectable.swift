import CoreData
import Foundation

extension NSManagedObject: CustomReflectable
{
    public var customMirror: Mirror
    {
        let children: [(String?, Any?)] = entity.attributesByName
            .map { name, _ in (name, value(forKey: name)) }

        let relations: [(String?, Any?)] = entity.relationshipsByName
            .compactMap { name, _ in
                guard let attrRelation = value(forKey: name) else { return nil }
                return (name, attrRelation)
            }

        let allChildren: [(String?, Any?)] = (children + relations)
        return Mirror(self, children: allChildren)
    }
}
