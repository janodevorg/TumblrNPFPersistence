import CoreData
import CoreDataStack
@testable import TumblrNPFPersistence
import XCTest

class MOTestCase: XCTestCase
{
    var container: PersistentContainer!
    var context: NSManagedObjectContext!

    override func setUp() {
        self.container = createContainer()
        self.context = container.viewContext
        super.setUp()
    }

    // MARK: - Private

    private func createContainer() -> PersistentContainer {
        let exp = expectation(description: "load stores")
        let container = PersistentContainer(
            name: "DataModel",
            inMemory: true,
            bundle: BundleReference.bundle
        )
        container.loadPersistentStores { desc, error in
            if let error = error {
                XCTFail("Stores didn’t load: \(error)")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
        return container
    }
}
