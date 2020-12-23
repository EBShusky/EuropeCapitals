import Foundation

protocol FavouriteCapitalsRepositoryProtocol {
    func addToFavourites(capitalId: String)
    func removeFromFavourites(capitalId: String)
    func isFavourite(capitalId: String) -> Bool
}

class DefaultsFavouritesCapitalsRepository: FavouriteCapitalsRepositoryProtocol {

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    func addToFavourites(capitalId: String) {
        userDefaults.set(true, forKey: capitalId)
    }

    func removeFromFavourites(capitalId: String) {
        userDefaults.removeObject(forKey: capitalId)
    }

    func isFavourite(capitalId: String) -> Bool {
        return userDefaults.bool(forKey: capitalId)
    }
}
