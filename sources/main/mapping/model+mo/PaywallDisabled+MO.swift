import Foundation
import TumblrNPF

public extension PaywallDisabled
{
    convenience init?(mo: PaywallDisabledMO) {
        guard
            let subtype = mo.subtype,
            let title = mo.title,
            let text = mo.text,
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
