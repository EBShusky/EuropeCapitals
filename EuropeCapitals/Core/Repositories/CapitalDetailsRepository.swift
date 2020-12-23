import Foundation

protocol CapitalDetailsRepositoryProtocol {
    func getDetails(capitalId: String, callback: @escaping (CapitalDetails?, Error?) -> ())
    func getViewers(capitalId: String, callback: @escaping ([CapitalViewer]?, Error?) -> ())
}

class CapitalDetailsRepository: CapitalDetailsRepositoryProtocol {

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func getDetails(capitalId: String, callback: @escaping (CapitalDetails?, Error?) -> ()) {
        apiClient.request(url: Router.capitalDetails.rawValue,
                          method: .get,
                          parameters: [:]) { (data, error) in

            guard let data = data,
                  let capitalDetails = try? JSONDecoder().decode(CapitalDetailsResponse.self, from: data) else {
                callback(nil, ApiClientError.error)
                return
            }

            callback(capitalDetails.mapToDomain(), nil)
        }
    }

    func getViewers(capitalId: String, callback: @escaping ([CapitalViewer]?, Error?) -> ()) {
        apiClient.request(url: Router.capitalViewers.rawValue,
                          method: .get,
                          parameters: [:]) { (data, error) in

            guard let data = data,
                  let capitalViewers = try? JSONDecoder().decode([CapitalViewerResponse].self, from: data) else {
                callback(nil, ApiClientError.error)
                return
            }

            callback(capitalViewers.map { $0.mapToDomain() }, nil)
        }
    }
}
