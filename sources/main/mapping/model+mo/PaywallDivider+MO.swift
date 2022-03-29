import Foundation
import TumblrNPF

public extension PaywallDivider
{
    convenience init?(mo: PaywallDividerMO) {
        guard
            let text = mo.text,
            let url = mo.url,
            let subtype = mo.subtype,
            let type = mo.type
        else {
            return nil
        }
        self.init(color: mo.color,
                  text: text,
                  isVisible: mo.isVisible?.boolValue,
                  subtype: subtype,
                  type: type,
                  url: url)
    }
}
