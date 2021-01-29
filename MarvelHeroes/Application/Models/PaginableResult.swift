struct PaginableResult<T: Codable>: Codable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [T]

    init(offset: Int, limit: Int, total: Int, count: Int, results: [T]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
}
