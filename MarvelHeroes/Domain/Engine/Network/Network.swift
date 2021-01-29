import UIKit

typealias RouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> Void
struct Response<T: Codable>: Codable {
    let data: T?
}


protocol Network {
    associatedtype S: Service
    func request<T: Decodable>(service: S, result: @escaping ResultCompletion<T>)
    func downloadImage(url: URL, result: @escaping (Result<UIImage, Error>) -> Void)
}

class NetworkManager<S: Service>: Network {
    private var task: URLSessionTask?
    
    func request<T>(service: S, result: @escaping ResultCompletion<T>) where T : Decodable {
            perform(service) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        return result(.failure(error))
                    }
                    
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                        return result(.failure(NetworkError.badRequest))
                    }
                    
                    switch statusCode {
                    case 200...299:
                        guard let data = data else {
                            return result(.failure(NetworkError.noData))
                        }
                        do {
                            let decoder: JSONDecoder = .init()
                            decoder.dateDecodingStrategy = .iso8601
                            let objectDecodabled = try decoder.decode(T.self, from: data)
                            return result(.success(objectDecodabled))
                        } catch {
                            return result(.failure(NetworkError.decode))
                        }
                    default:
                        return result(.failure(NetworkError.failed))
                    }
                }
            }
    }
    
    private func perform(_ service: Service, completion: @escaping RouterCompletion) {
        let session: URLSession = .shared
        
        do {
            let request = try service.createRequest()
            task = session.dataTask(with: request, completionHandler: { (data, urlResponse, error) in
//                NetworkLogger.log(response: urlResponse, data: data)
                completion(data, urlResponse, error)
            })
        } catch let error {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    func downloadImage(url: URL, result: @escaping (Result<UIImage, Error>) -> Void) {
        
    }
    

}

enum NetworkError: String, Error {
    case authentication
    case badRequest
    case failed
    case noData
    case decode

    var description: String {
        return rawValue
    }
}
