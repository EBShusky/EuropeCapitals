import Foundation

struct CapitalDetailsResponse: Decodable {
    let averageRating: Double
}

extension CapitalDetailsResponse {

    func mapToDomain() -> CapitalDetails {
        return CapitalDetails(averageRating: averageRating)
    }
}
