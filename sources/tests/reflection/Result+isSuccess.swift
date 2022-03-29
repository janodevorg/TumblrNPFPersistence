import Foundation

extension Result {
    var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }
}
