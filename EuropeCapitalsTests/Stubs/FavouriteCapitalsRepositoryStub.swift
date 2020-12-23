import Foundation

@testable import EuropeCapitals

class FavouriteCapitalsRepositoryStub: FavouriteCapitalsRepositoryProtocol {

    var addToFavouritesCalled: Bool = false
    func addToFavourites(capitalId: String) {
        addToFavouritesCalled = true
    }

    var isFavouriteResult: ((String) -> (Bool))?
    func isFavourite(capitalId: String) -> Bool {
        return isFavouriteResult?(capitalId) ?? false
    }

    var removeFromFavourites: Bool = false
    func removeFromFavourites(capitalId: String) {
        removeFromFavourites = true
    }
}
