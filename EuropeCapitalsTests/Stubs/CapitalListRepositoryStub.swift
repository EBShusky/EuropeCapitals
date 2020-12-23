import Foundation

@testable import EuropeCapitals

class CapitalListRepositoryStub: CapitalListRepositoryProtocol {

    var getListCallbackResult: ([Capital]?, Error?) = (nil, nil)
    func getList(callback: @escaping ([Capital]?, Error?) -> ()) {
        callback(getListCallbackResult.0, getListCallbackResult.1)
    }
}
