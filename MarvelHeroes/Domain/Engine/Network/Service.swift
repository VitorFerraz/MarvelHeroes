import Foundation

protocol Service {
    var baseURL:    URL { get }
    var path:       String { get }
    var version:    String { get }
    var httpMethod: HTTPMethod { get }
    var task:       HTTPTask { get }
    var headers:    HTTPHeaders? { get }
    var auth:       HTTPAuth? { get }
    func errorFor(statusCode: Int) -> Error?
}

extension Service {
    func createRequest() throws -> URLRequest {
        try buildRequestFrom(self)
    }
    
    func buildRequestFrom(_ service: Service) throws -> URLRequest {
        var fullUrl: URL = service.baseURL
        
        if !service.path.isEmpty {
            fullUrl = service.baseURL.appendingPathComponent(service.path)
        }
        
        var request: URLRequest = URLRequest(url: fullUrl,
                                             cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                             timeoutInterval: 10)
        request.httpMethod = service.httpMethod.rawValue
        
        do {
            switch service.task {
            case .requestWithAdditional(let auth,
                                        let urlParameters,
                                        let bodyParameters):

                try configureWith(urlParameters: urlParameters,
                                  bodyParameters: bodyParameters,
                                  request: &request)
                switch auth {
                case .url(let parameters)?:
                    setAdditionalAuth(parameters, request: &request)
                case .header(let parameters)?:
                    setAdditionalHeaders(parameters, request: &request)
                case .none:
                    break
                }
            }
            return request
        } catch let error {
            throw error
        }
    }
    
    func configureWith(urlParameters: Parameters?, bodyParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let parameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: parameters)
            }
            
            if let parameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: parameters)
            }
        } catch let error {
            throw error
        }
    }
    
    func setAdditionalHeaders(_ headers: HTTPHeaders?, request: inout URLRequest) {
        guard let headers: HTTPHeaders = headers else {
            return
        }
        
        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    func setAdditionalAuth(_ parameters: Parameters, request: inout URLRequest) {
        guard let url = request.url else { return }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)

        if urlComponents?.queryItems == nil {
           urlComponents?.queryItems = []
        }

        let queryItems = parameters.compactMap {
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }

        urlComponents?.queryItems?.append(contentsOf: queryItems)
        request.url = urlComponents?.url
    }
}

enum HTTPAuth {
    case header(HTTPHeaders)
    case url(Parameters)
}

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case path   = "PATH"
    case delete = "DELETE"
}

typealias Parameters  = [String:Any]
typealias HTTPHeaders = [String:String]

enum HTTPTask {
    case requestWithAdditional(auth: HTTPAuth?, urlParameters: Parameters?, bodyParameters: Parameters?)
}
