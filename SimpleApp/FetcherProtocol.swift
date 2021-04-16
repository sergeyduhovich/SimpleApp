import Foundation

protocol FetcherProtocol {
    func loadItems(
        offset: Int,
        limit: Int,
        completion: @escaping (Result<[Song], ManagerError>) -> Void
    )
}
