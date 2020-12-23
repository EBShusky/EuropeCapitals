import Foundation

@testable import EuropeCapitals

class CapitalListCoordinatorStub: CapitalListCoordinatorProtocol {

    var showCapitalDetailsCalled: Bool = false
    func showCapitalDetails(capital: Capital) {
        showCapitalDetailsCalled = true
    }
}
