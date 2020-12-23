import Foundation

struct CapitalResponse: Decodable {
    let id: String
    let name: String
    let imageUrl: String
}

extension CapitalResponse {

    func mapToDomain() -> Capital {
        return Capital(id: id,
                       name: name,
                       imageUrl: imageUrl)
    }
}
