
import UIKit

enum DownloadService {
    case downloadImageFrom(url: URL)
}

extension DownloadService: Service {
    var baseURL: URL {
        switch self {
        case .downloadImageFrom(let url):
            return url
        }
    }
    
    var path: String {
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .requestWithAdditional(auth: nil, urlParameters: nil, bodyParameters: nil)
    }

    var version: String {
        return ""
    }

    var auth: HTTPAuth? {
        return nil
    }

    var headers: HTTPHeaders? {
        return nil
    }
    
    func errorFor(statusCode: Int) -> Error? {
        return nil
    }
}

extension UIImageView {
    func setImageFrom(url: String?) {
        guard let urlUnwrapped = url, let urlImage = URL(string: urlUnwrapped) else {
            image = nil
            return
        }
        image = nil
        let service: DownloadService = .downloadImageFrom(url: urlImage)
        NetworkManager<DownloadService>().downloadImage(service: service) { [weak self] (result) in
            switch result {
            case .success(let image):
                self?.image = image
            case .failure:
                self?.image = nil
            }
        }
    }
}
