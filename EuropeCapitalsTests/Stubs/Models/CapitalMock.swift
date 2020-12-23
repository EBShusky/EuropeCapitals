import Foundation

@testable import EuropeCapitals

class CapitalMock {

    static func create(id: String) -> Capital {
        return Capital(id: id,
                       name: "name",
                       imageUrl: "url")
    }
}
