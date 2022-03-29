import CoreData
@testable import TumblrNPF
@testable import TumblrNPFPersistence
import XCTest

final class BlogMOTests: MOTestCase
{
    func testBlog() throws { // swiftlint:disable:this function_body_length
        guard let blogMO = try createBlogMO(filename: "blog.json") else {
            XCTFail("Couldnt decode BlogMO")
            return
        }

        XCTAssertEqual(blogMO.avatar?.count, 4)
        let avatar = blogMO.avatar?.first(where: {
            ($0 as? AvatarMO)?.height?.intValue == 512
        }) as? AvatarMO
        XCTAssertEqual(avatar?.height?.intValue, 512)
        XCTAssertEqual(avatar?.width?.intValue, 512)
        XCTAssertEqual(avatar?.url?.absoluteString, "https://64.media.tumblr.com/avatar_e2c557270224_512.pnj")

        XCTAssertEqual(blogMO.canBeFollowed?.boolValue, true )
        XCTAssertEqual(blogMO.followed?.boolValue, false)
        XCTAssertEqual(blogMO.name, "amazing-jquery-plugins")
        XCTAssertEqual(blogMO.posts?.count, 3)
        XCTAssertEqual(blogMO.title, "Amazing jQuery Plugins")
        XCTAssertEqual(blogMO.url, URL(string: "https://amazing-jquery-plugins.tumblr.com/"))

        guard let themeMO = blogMO.theme else {
            XCTFail("Couldnt decode themeMO")
            return
        }
        XCTAssertEqual(themeMO.avatarShape, "square")
        XCTAssertEqual(themeMO.backgroundColor, "#FFFFFF")
        XCTAssertEqual(themeMO.bodyFont, "Helvetica Neue")
        XCTAssertEqual(themeMO.headerBounds, "")
        XCTAssertEqual(themeMO.headerImage, "https://assets.tumblr.com/images/default_header/optica_pattern_04.png?_v=7c4e5e82cf797042596e2e64af1c383f")
        XCTAssertEqual(themeMO.headerImageFocused, "https://assets.tumblr.com/images/default_header/optica_pattern_04_focused_v3.png?_v=7c4e5e82cf797042596e2e64af1c383f")
        XCTAssertEqual(themeMO.headerImagePoster, "")
        XCTAssertEqual(themeMO.headerImageScaled, "https://assets.tumblr.com/images/default_header/optica_pattern_04_focused_v3.png?_v=7c4e5e82cf797042596e2e64af1c383f")
        XCTAssertEqual(themeMO.headerStretch, true)
        XCTAssertEqual(themeMO.linkColor, "#00B8FF")
        XCTAssertEqual(themeMO.showAvatar, true)
        XCTAssertEqual(themeMO.showDescription, true)
        XCTAssertEqual(themeMO.showHeaderImage, true)
        XCTAssertEqual(themeMO.showTitle, true)
        XCTAssertEqual(themeMO.titleColor, "#000000")
        XCTAssertEqual(themeMO.titleFont, "Gibson")
        XCTAssertEqual(themeMO.titleFontWeight, "bold")

        XCTAssertEqual(blogMO.canBeFollowed, true)
        XCTAssertEqual(blogMO.followed, false)
        XCTAssertEqual(blogMO.name, "amazing-jquery-plugins")
        XCTAssertEqual(blogMO.title, "Amazing jQuery Plugins")

        XCTAssertEqual(blogMO.theme?.avatarShape, "square")
        XCTAssertEqual(blogMO.theme?.backgroundColor, "#FFFFFF")
        XCTAssertEqual(blogMO.theme?.bodyFont, "Helvetica Neue")
        XCTAssertEqual(blogMO.theme?.headerBounds, "")
        XCTAssertEqual(blogMO.theme?.headerImage, "https://assets.tumblr.com/images/default_header/optica_pattern_04.png?_v=7c4e5e82cf797042596e2e64af1c383f")
        XCTAssertEqual(blogMO.theme?.headerImageFocused, "https://assets.tumblr.com/images/default_header/optica_pattern_04_focused_v3.png?_v=7c4e5e82cf797042596e2e64af1c383f")
        XCTAssertEqual(blogMO.theme?.headerImagePoster, "")
        XCTAssertEqual(blogMO.theme?.headerImageScaled, "https://assets.tumblr.com/images/default_header/optica_pattern_04_focused_v3.png?_v=7c4e5e82cf797042596e2e64af1c383f")
        XCTAssertEqual(blogMO.theme?.headerStretch, true)
        XCTAssertEqual(blogMO.theme?.linkColor, "#00B8FF")
        XCTAssertEqual(blogMO.theme?.showAvatar, true)
        XCTAssertEqual(blogMO.theme?.showDescription, true)
        XCTAssertEqual(blogMO.theme?.showHeaderImage, true)
        XCTAssertEqual(blogMO.theme?.showTitle, true)
        XCTAssertEqual(blogMO.theme?.titleColor, "#000000")
        XCTAssertEqual(blogMO.theme?.titleFont, "Gibson")
        XCTAssertEqual(blogMO.theme?.titleFontWeight, "bold")

        XCTAssertEqual(blogMO.url, URL(string: "https://amazing-jquery-plugins.tumblr.com/"))

        guard let post = blogMO.posts?.first(where: { ($0 as? PostMO)?.id == "671507719170244608" }) as? PostMO else {
            XCTFail("Couldn’t find PostMO")
            return
        }
        let postBlogAvatar = post.blog?.avatar?.first(where: {
            ($0 as? AvatarMO)?.height?.intValue == 512
        }) as? AvatarMO
        XCTAssertEqual(postBlogAvatar?.height?.intValue, 512)
        XCTAssertEqual(postBlogAvatar?.width?.intValue, 512)
        XCTAssertEqual(postBlogAvatar?.url?.absoluteString, "https://64.media.tumblr.com/avatar_e2c557270224_512.pnj")
        XCTAssertEqual(post.blog?.canBeFollowed, true)
        XCTAssertEqual(post.blog?.followed, false)
        XCTAssertEqual(post.blog?.name, "amazing-jquery-plugins")
        XCTAssertEqual(post.blog?.title, "Amazing jQuery Plugins")
        XCTAssertEqual(post.blog?.theme?.avatarShape, "square")
        XCTAssertEqual(post.blog?.url, URL(string: "https://amazing-jquery-plugins.tumblr.com/"))

        XCTAssertEqual(post.blogName, "amazing-jquery-plugins")
        XCTAssertEqual(post.canDelete, false)
        XCTAssertEqual(post.canEdit, false)
        XCTAssertEqual(post.canLike, true)
        XCTAssertEqual(post.canReblog, true)
        XCTAssertEqual(post.canReply, true)
        XCTAssertEqual(post.canSendInMessage, true)
        XCTAssertEqual(post.classification, "clean")
        XCTAssertEqual(post.date, "2021-12-25 02:34:25 GMT")
        XCTAssertEqual(post.displayAvatar, true)
        XCTAssertEqual(post.embedURL, URL(string: "https://amazing-jquery-plugins.tumblr.com/post/671507719170244608/embed"))
        XCTAssertEqual(post.followed, false)
        XCTAssertEqual(post.id, "671507719170244608")
        XCTAssertEqual(post.idString, "671507719170244608")
        XCTAssertEqual(post.interactabilityReblog, "everyone")
        XCTAssertEqual(post.isNSFW, false)
        XCTAssertEqual(post.layout, [])
        XCTAssertEqual(post.likeCount, 2)
        XCTAssertEqual(post.noteCount, 3)
        XCTAssertEqual(post.nsfwScore, 0)
        XCTAssertEqual(post.objectType, "post")
        XCTAssertEqual(post.originalType, "link")
        XCTAssertEqual(post.postURL, URL(string: "https://amazing-jquery-plugins.tumblr.com/post/671507719170244608/10-best-color-manipulation-javascript-libraries"))
        XCTAssertEqual(post.reblogCount, 1)
        XCTAssertEqual(post.reblogKey, "NEpuJaNN")
        XCTAssertNil(post.recommendedColor)
        XCTAssertNil(post.recommendedSource)
        XCTAssertEqual(post.replyCount, 0)
        XCTAssertEqual(post.shortURL, URL(string: "https://tmblr.co/ZPzlitbHhBPv4q00"))
        XCTAssertEqual(post.shouldOpenInLegacy, true)
        XCTAssertEqual(post.slug, "10-best-color-manipulation-javascript-libraries")
        XCTAssertEqual(post.state, "published")
        XCTAssertEqual(post.summary, "10 Best Color Manipulation JavaScript Libraries | jQuery Script")
        XCTAssertEqual(post.tags, ["jquery", "jquery plugin", "color"])
        XCTAssertEqual(post.timestamp, 1_640_399_665)
        XCTAssertEqual(post.trail, [])
        XCTAssertEqual(post.type, "blocks")
    }

    // MARK: - Private

    private func createBlogMO(filename: String) throws -> BlogMO? {
        let jsonData = try BundleFile(filename: filename).data
        guard let blog = try? JSONDecoder().decode(Blog.self, from: jsonData) else {
            XCTFail("Failed to create blog object.")
            return nil
        }
        return BlogMO.upsert(model: blog, context: context)
    }
}
