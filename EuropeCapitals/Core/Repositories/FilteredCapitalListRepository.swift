import Foundation

protocol FilteredCapitalListRepositoryProtocol {
    func getList(showOnlyFavourites: Bool, callback: @escaping ([Capital]?, Error?) -> ())
}

class FilteredCapitalListRepository: FilteredCapitalListRepositoryProtocol {

    private let capitalListRepository: CapitalListRepositoryProtocol
    private let favouriteCapitalsRepository: FavouriteCapitalsRepositoryProtocol

    init(capitalListRepository: CapitalListRepositoryProtocol,
         favouriteCapitalsRepository: FavouriteCapitalsRepositoryProtocol) {
        self.capitalListRepository = capitalListRepository
        self.favouriteCapitalsRepository = favouriteCapitalsRepository
    }

    func getList(showOnlyFavourites: Bool, callback: @escaping ([Capital]?, Error?) -> ()) {
        capitalListRepository.getList { [weak self] capitals, error in
            guard let capitals = capitals,
                  let self = self else {
                callback(nil, ApiClientError.error)
                return
            }

            callback(self.filter(showOnlyFavourites: showOnlyFavourites, list: capitals), nil)
        }
    }

    private func filter(showOnlyFavourites: Bool, list: [Capital]) -> [Capital] {
        if showOnlyFavourites {
            return list.filter { self.favouriteCapitalsRepository.isFavourite(capitalId: $0.id) }
        } else {
            return list
        }
    }
}
