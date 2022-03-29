import Foundation
import TumblrNPF

public extension PaywallCTA
{
    convenience init?(mo: PaywallCTAMO) {
        guard
            let subtype = mo.subtype,
            let text = mo.text,
            let title = mo.title,
            let type = mo.type,
            let url = mo.url
        else {
            return nil
        }
        self.init(isVisible: mo.isVisible?.boolValue,
                  subtype: subtype,
                  text: text,
                  title: title,
                  type: type,
                  url: url)
    }
}
