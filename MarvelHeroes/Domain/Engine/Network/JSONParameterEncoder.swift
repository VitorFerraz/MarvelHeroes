import Foundation

struct JSONParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            
            if urlRequest.value(forHTTPHeaderField: NetworkConstants.HTTPHeaderField.contentType.rawValue) == nil {
                urlRequest.setValue(NetworkConstants.ContentType.json.rawValue, forHTTPHeaderField: NetworkConstants.HTTPHeaderField.contentType.rawValue)
            }
        } catch {
            throw NSError(domain: "Bad encoder", code: NSURLErrorUnknown, userInfo: nil)
        }
    }
}
