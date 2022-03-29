import CoreData
@testable import TumblrNPF
@testable import TumblrNPFPersistence
import XCTest

final class LinkBlockMOTests: MOTestCase
{
    func testLink1() throws {
        let postMO = try createPostMO(filename: "linkBlock1.json")
        XCTAssertEqual(postMO?.id, "1234567891234567")
        let linkContent = postMO?.content?.allObjects.first as? LinkContentMO

        XCTAssertEqual(linkContent?.author, "Thomas Kaplan and Robert Pear")
        XCTAssertEqual(linkContent?.desc, "Senate leaders are writing legislation to repeal and replace the Affordable Care Act without a single hearing on the bill and without an open drafting session.") // swiftlint:disable:this line_length
        XCTAssertEqual(linkContent?.title, "Secrecy Surrounding Senate Health Bill Raises Alarms in Both Parties")
        XCTAssertEqual(linkContent?.type, "link")
        XCTAssertEqual(linkContent?.url, URL(string: "https://www.nytimes.com/2017/06/15/us/politics/secrecy-surrounding-senate-health-bill-raises-alarms-in-both-parties.html")!) // swiftlint:disable:this force_unwrapping

        let poster = linkContent?.poster?.allObjects.first as? MediaObjectMO
        XCTAssertEqual(poster?.height, 549)
        XCTAssertEqual(poster?.type, "image/jpeg")
        XCTAssertEqual(poster?.width, 1_050)
    }

    func testLink2() throws {
        let postMO = try createPostMO(filename: "linkBlock2.json")
        XCTAssertEqual(postMO?.id, "1234567891234567")
        let linkContent = postMO?.content?.allObjects.first as? LinkContentMO

        XCTAssertEqual(linkContent?.author, "Thomas Kaplan and Robert Pear")
        XCTAssertEqual(linkContent?.desc, "Senate leaders are writing legislation to repeal and replace the Affordable Care Act without a single hearing on the bill and without an open drafting session.") // swiftlint:disable:this line_length
        XCTAssertEqual(linkContent?.displayURL, URL(string: "https://www.nytimes.com/2017/06/15/us/politics/secrecy-surrounding-senate-health-bill-raises-alarms-in-both-parties.html")!) // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(linkContent?.siteName, "nytimes.com")
        XCTAssertEqual(linkContent?.title, "Secrecy Surrounding Senate Health Bill Raises Alarms in Both Parties")
        XCTAssertEqual(linkContent?.type, "link")
        XCTAssertEqual(linkContent?.url, URL(string: "https://href.li/?stuff-here")!) // swiftlint:disable:this force_unwrapping

        let poster = linkContent?.poster?.allObjects.first as? MediaObjectMO
        XCTAssertEqual(poster?.height, 549)
        XCTAssertEqual(poster?.type, "image/jpeg")
        XCTAssertEqual(poster?.url, URL(string: "https://static01.nyt.com/images/2017/06/15/us/politics/15dchealth-2/15dchealth-2-facebookJumbo.jpg")!)  // swiftlint:disable:this force_unwrapping
        XCTAssertEqual(poster?.width, 1_050)
    }

    // MARK: - Private

    private func createPostMO(filename: String) throws -> PostMO? {
        let jsonData = try BundleFile(filename: filename).data
        guard let model = try? JSONDecoder().decode(Post.self, from: jsonData) else {
            XCTFail("Failed to create Post")
            return nil
        }
        return PostMO.upsert(model: model, context: context)
    }
}
