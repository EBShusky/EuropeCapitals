import XCTest

@testable import EuropeCapitals

class FavouriteCapitalsRepositoryTests: XCTestCase {

    private var userDefaults: UserDefaults!

    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults(suiteName: #file)!
        userDefaults.removePersistentDomain(forName: #file)
    }

    override func tearDown() {
        super.tearDown()
        userDefaults.removePersistentDomain(forName: #file)
    }

    func test_addFavourite_shouldStoreValueInDefaults() throws {
        // Given
        let sut = DefaultsFavouritesCapitalsRepository(userDefaults: userDefaults)
        let capitalIdValue = "capitalID"

        // When
        sut.addToFavourites(capitalId: capitalIdValue)

        // Then
        XCTAssertTrue(sut.isFavourite(capitalId: capitalIdValue))
    }

    func test_checkUnfavouritedCapitalId_shouldReturnFalse() throws {
        // Given
        let sut = DefaultsFavouritesCapitalsRepository(userDefaults: userDefaults)
        let capitalIdValue = "capitalID"

        // When & Then
        XCTAssertFalse(sut.isFavourite(capitalId: capitalIdValue))
    }

    func test_removeFavourite_shouldRemoveValueFromDefaults() throws {
        // Given
        let sut = DefaultsFavouritesCapitalsRepository(userDefaults: userDefaults)
        let capitalIdValue = "capitalID"
        sut.addToFavourites(capitalId: capitalIdValue)

        // When
        sut.removeFromFavourites(capitalId: capitalIdValue)

        // Then
        XCTAssertFalse(sut.isFavourite(capitalId: capitalIdValue))
    }
}
