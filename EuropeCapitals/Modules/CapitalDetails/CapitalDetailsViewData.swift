import Foundation

struct CapitalDetailsViewData {

    let capitalName: String
    let capitalImageUrl: String
    let capitalRating: String
    let capitalViewers: String

    init() {
        capitalName = ""
        capitalImageUrl = ""
        capitalRating = ""
        capitalViewers = ""
    }
}

extension CapitalDetailsViewData {

    init(capital: Capital, capitalDetails: CapitalDetails, capitalViewers: [CapitalViewer]) {
        self.capitalName = capital.name
        self.capitalImageUrl = capital.imageUrl
        self.capitalRating = "\(capitalDetails.averageRating)"
        self.capitalViewers = "\(capitalViewers.count)"
    }
}
