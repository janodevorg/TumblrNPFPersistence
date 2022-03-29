import Foundation
import XCTest

struct NonOptionalString: MirrorDescripting {
    let s: String
}
struct OptionalString: MirrorDescripting {
    let s: String?
}

final class EqualCheckTests: XCTestCase
{
    func testStringEquality() {
        Equality(NonOptionalString(s: "1"), NonOptionalString(s: "1")).assert()
        Equality(NonOptionalString(s: "1"), NonOptionalString(s: "2")).assertFailure()
        Equality(OptionalString(s: "1"), OptionalString(s: "1")).assert()
        Equality(OptionalString(s: "1"), OptionalString(s: "2")).assertFailure()
        Equality(NonOptionalString(s: "1"), OptionalString(s: "1")).assert()
        Equality(NonOptionalString(s: "1"), OptionalString(s: "2")).assertFailure()
    }
}
