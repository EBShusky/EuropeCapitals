import Foundation

struct CapitalListCellViewData {
    var rawData: Capital

    let name: String
    let imageUrl: String

    init(capital: Capital) {
        self.rawData = capital
        self.name = capital.name
        self.imageUrl = capital.imageUrl
    }
}
