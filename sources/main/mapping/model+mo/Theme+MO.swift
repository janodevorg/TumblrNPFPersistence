import CodableHelpers
import TumblrNPF

public extension Theme {
    init?(mo: ThemeMO) {
        guard let avatarShape = mo.avatarShape,
              let backgroundColor = mo.backgroundColor,
              let bodyFont = mo.bodyFont,
              let headerBounds = mo.headerBounds,
              let headerImage = mo.headerImage,
              let headerImageFocused = mo.headerImageFocused,
              let headerImagePoster = mo.headerImagePoster,
              let headerImageScaled = mo.headerImageScaled,
              let linkColor = mo.linkColor,
              let titleColor = mo.titleColor,
              let titleFont = mo.titleFont,
              let titleFontWeight = mo.titleFontWeight
        else {
            return nil
        }
        self.init(
            avatarShape: avatarShape,
            backgroundColor: backgroundColor,
            bodyFont: bodyFont,
            headerBounds: CodableIntOrString.string(headerBounds),
            headerFullHeight: mo.headerFullHeight?.intValue,
            headerFullWidth: mo.headerFullWidth?.intValue,
            headerImage: headerImage,
            headerImageFocused: headerImageFocused,
            headerImagePoster: headerImagePoster,
            headerImageScaled: headerImageScaled,
            headerStretch: mo.headerStretch,
            linkColor: linkColor,
            showAvatar: mo.showAvatar,
            showDescription: mo.showDescription,
            showHeaderImage: mo.showHeaderImage,
            showTitle: mo.showTitle,
            titleColor: titleColor,
            titleFont: titleFont,
            titleFontWeight: titleFontWeight
        )
    }
}
