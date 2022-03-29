import CoreData
import TumblrNPF
import TumblrNPFPersistence
import XCTest

final class AvatarTests: MOTestCase
{
    let model = Avatar(height: 1, url: URL(string: "https://avatar.com/avatar.gif")!, width: 2)

    // auto test of MO created from a model
    func testAutoCompare() {
        let mo = AvatarMO(model: model, context: context)
        Equality(mo, model).assert()
    }
}
