import Foundation

protocol CapitalListRepositoryProtocol {
    func getList(callback: @escaping ([Capital]?, Error?) -> ())
}

class CapitalListRepository: CapitalListRepositoryProtocol {

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func getList(callback: @escaping ([Capital]?, Error?) -> ()) {
        apiClient.request(url: Router.capitlList.rawValue,
                          method: .get,
                          parameters: [:]) { (data, error) in

            guard let data = data,
                  let capitals = try? JSONDecoder().decode([CapitalResponse].self, from: data) else {
                callback(nil, ApiClientError.error)
                return
            }

            callback(capitals.map { $0.mapToDomain() }, nil)
        }
    }
}
