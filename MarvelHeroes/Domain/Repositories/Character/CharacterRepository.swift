
import Foundation

typealias ResultCompletion<T> = (Result<T, Error>) -> Void

struct Character: Codable {
    var id: Int
    var name: String
    var description: String?
    var modified: Date?
    var resourceURI: String?
    var thumbnail: Thumbnail?
}

extension Character : Hashable, Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
}



protocol CharacterRepository {
    func fetchCharacters(by name: String?, by order: OrderList?, offset: Int, limit: Int, _ completion: @escaping ResultCompletion<Response<PaginableResult<Character>>>)
}
