import Foundation

typealias ApiClientCompletionHandler = ((Data?, Error?) -> ())

protocol ApiClientProtocol {
    func request(url: String,
                 method: ApiClientMethod,
                 parameters: [String: String],
                 completionHandler: @escaping ApiClientCompletionHandler)
}
