import Foundation

extension String {
	var localized: String {
		return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
	}
}

let LS_ROOT_TITLE = "ROOT_TITLE".localized
