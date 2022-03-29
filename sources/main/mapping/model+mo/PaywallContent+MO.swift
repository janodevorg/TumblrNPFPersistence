import TumblrNPF

public extension PaywallContent
{
    static func map(mo: PaywallContentMO) -> PaywallContent? {
        switch mo {
        case let cta as PaywallCTAMO: return PaywallCTA(mo: cta).flatMap { .cta($0) }
        case let disabled as PaywallDisabledMO: return PaywallDisabled(mo: disabled).flatMap { .disabled($0) }
        case let divider as PaywallDividerMO: return PaywallDivider(mo: divider).flatMap { .divider($0) }
        default: return nil
        }
    }
}
