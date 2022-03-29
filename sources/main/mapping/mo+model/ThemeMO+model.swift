import CoreData
import Foundation
import TumblrNPF

public extension ThemeMO
{
    convenience init?(model: Theme?, context: NSManagedObjectContext) {
        guard let model = model else { return nil }
        self.init(model: model, context: context)
    }

    convenience init(model: Theme, context: NSManagedObjectContext) {
        self.init(using: context)
        self.avatarShape = model.avatarShape
        self.backgroundColor = model.backgroundColor
        self.bodyFont = model.bodyFont

        switch model.headerBounds {
        case .int(let int): self.headerBounds = "\(int)"
        case .string(let string): self.headerBounds = string
        }

        self.headerFullHeight = model.headerFullHeight.flatMap { $0 as NSNumber }
        self.headerFullWidth = model.headerFullWidth.flatMap { $0 as NSNumber }
        self.headerImage = model.headerImage
        self.headerImageFocused = model.headerImageFocused
        self.headerImagePoster = model.headerImagePoster
        self.headerImageScaled = model.headerImageScaled
        self.headerStretch = model.headerStretch
        self.linkColor = model.linkColor
        self.showAvatar = model.showAvatar
        self.showDescription = model.showDescription
        self.showHeaderImage = model.showHeaderImage
        self.showTitle = model.showTitle
        self.titleColor = model.titleColor
        self.titleFont = model.titleFont
        self.titleFontWeight = model.titleFontWeight
    }
}
