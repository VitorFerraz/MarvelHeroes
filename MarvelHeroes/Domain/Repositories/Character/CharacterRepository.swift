
import Foundation

typealias ResultCompletion<T> = (Result<T, Error>) -> Void

struct Character: Codable {
    var id: Int
    var name: String
    var characterDescription: String?
    var modified: Date?
    var resourceURI: String?
}


protocol CharacterRepository {
    func fetchCharacters(by name: String?, by order: OrderList?, offset: Int, limit: Int, _ completion: @escaping ResultCompletion<Response<PaginableResult<Character>>>)
}
