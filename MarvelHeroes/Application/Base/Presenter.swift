protocol Presenter {
    associatedtype Interactor
    associatedtype Router
    var interactor: Interactor { get }
    var router: Router { get }

    init(_ interactor: Interactor, _ router: Router)
}
