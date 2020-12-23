import Foundation

struct CapitalViewerResponse: Decodable {
    let name: String
}

extension CapitalViewerResponse {

    func mapToDomain() -> CapitalViewer {
        return CapitalViewer(name: name)
    }
}
