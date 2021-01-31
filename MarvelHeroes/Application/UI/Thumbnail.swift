import Foundation

enum ExtensionFile: String, Codable {
    case jpg    = "jpg"
    case none   = ""

    init(rawValue: String) {
        switch rawValue {
        case "jpg":
            self = .jpg
        default:
            self = .none
        }
    }
}


class Thumbnail: Codable {
    var path: String
    var `extension`: ExtensionFile
    var url: String {
        if path.isEmpty || `extension` == .none {
            return ""
        }
        return path + "." + `extension`.rawValue
    }
}
