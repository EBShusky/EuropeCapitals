import Foundation

@testable import EuropeCapitals

class FilteredCapitalListRepositoryStub: FilteredCapitalListRepositoryProtocol {

    var getListShowOnlyFavouritesParameterInvoked: Bool = false
    var getListCallbackResult: ([Capital]?, Error?) = (nil, nil)
    func getList(showOnlyFavourites: Bool, callback: @escaping ([Capital]?, Error?) -> ()) {
        getListShowOnlyFavouritesParameterInvoked = showOnlyFavourites
        callback(getListCallbackResult.0, getListCallbackResult.1)
    }
}
