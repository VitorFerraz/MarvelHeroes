import Foundation
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

enum CharacterService {
    case getCharacter(byName: String?, orderBy: OrderList?, offset: Int, limit: Int)
    case getCharacterDetails(id: Int)
    case getCharacterResource(uri: String)
}


extension CharacterService: Service {
    var baseURL: URL {
        guard let url = URL(string: NetworkConstants.URLs.base) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getCharacter:
            return version + "/public/characters"
        case .getCharacterDetails(let id):
            return version + "/public/characters/\(id)"
        case .getCharacterResource:
            return ""
        }
    }
    
    var version: String {
        "/v1"
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getCharacter(let name, let orderType, let offset, let limit):
            var parameters: Parameters = ["offset": offset,
                                          "limit": limit]
            if let name = name, name.isEmpty == false {
                let queryString = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                parameters["nameStartsWith"] = queryString
            }
            if let orderType = orderType {
                parameters["orderBy"] = orderType.rawValue
            }
            return .requestWithAdditional(auth: auth, urlParameters: parameters, bodyParameters: nil)
        case .getCharacterDetails,
             .getCharacterResource:
            return .requestWithAdditional(auth: auth, urlParameters: nil, bodyParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    var auth: HTTPAuth? {
        var parameters: [String: String] = [:]
        let timeStamp: String = .init(describing: Date().timeIntervalSince1970)
        let hash: String = timeStamp + "13186c55931658ceb95066d7a73fbc2cdb5d4821" + "5e1e0fe731f0a16022481d244cbf1dc2"
        parameters["apikey"] = "5e1e0fe731f0a16022481d244cbf1dc2"
        parameters["ts"] = timeStamp
        parameters["hash"] = hash.md5
        return .url(parameters)
    }
    
    func errorFor(statusCode: Int) -> Error? {
        nil
    }
    

}

extension String {
    var md5: String {
        let data = Data(utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}
