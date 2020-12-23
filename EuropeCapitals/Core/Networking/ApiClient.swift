import Foundation

enum ApiClientError: Error {
    case error
}

class ApiClient: ApiClientProtocol {

    func request(url: String,
                 method: ApiClientMethod,
                 parameters: [String: String],
                 completionHandler: @escaping ApiClientCompletionHandler) {
        guard let url = URL(string: url) else {
            completionHandler(nil, ApiClientError.error)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(nil, ApiClientError.error)
                return
            }

            completionHandler(data, nil)
        })
        task.resume()
    }
}
