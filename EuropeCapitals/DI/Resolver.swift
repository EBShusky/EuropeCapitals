import Foundation

class Resolver {

    func resolve<T>(type: T.Type) -> T {
        if type == CapitalListAssemblyProtocol.self {
            return CapitalListAssembly(resolver: self) as! T
        }

        if type == CapitalDetailsAssemblyProtocol.self {
            return CapitalDetailsAssembly(resolver: self) as! T
        }

        if type == CapitalViewersAssemblyProtocol.self {
            return CapitalViewersAssembly(resolver: self) as! T
        }

        if type == CapitalListRepositoryProtocol.self {
            return CapitalListRepository(apiClient: self.resolve(type: ApiClientProtocol.self)) as! T
        }

        if type == CapitalDetailsRepositoryProtocol.self {
            return CapitalDetailsRepository(apiClient: self.resolve(type: ApiClientProtocol.self)) as! T
        }

        if type == FilteredCapitalListRepositoryProtocol.self {
            return FilteredCapitalListRepository(capitalListRepository: self.resolve(type: CapitalListRepositoryProtocol.self),
                                                 favouriteCapitalsRepository: self.resolve(type: FavouriteCapitalsRepositoryProtocol.self)) as! T
        }

        if type == FavouriteCapitalsRepositoryProtocol.self {
            let defaults = UserDefaults.init(suiteName: "CapitalsFavourite")!
            return DefaultsFavouritesCapitalsRepository(userDefaults: defaults) as! T
        }

        if type == ApiClientProtocol.self {
            return ApiClient() as! T
        }

        fatalError("Unregistered type: \(type)")
    }
}
