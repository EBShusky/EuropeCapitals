import XCTest

@testable import EuropeCapitals

class FilteredCapitalListRepositoryTests: XCTestCase {

    private var capitalListRepository: CapitalListRepositoryStub!
    private var favouriteRepository: FavouriteCapitalsRepositoryStub!
    private var sut: FilteredCapitalListRepository!

    override func setUp() {
        super.setUp()
        capitalListRepository = CapitalListRepositoryStub()
        favouriteRepository = FavouriteCapitalsRepositoryStub()
        sut = FilteredCapitalListRepository(capitalListRepository: capitalListRepository,
                                            favouriteCapitalsRepository: favouriteRepository)
    }

    func test_listWithFilters_shouldReturnFilteredList() throws {
        // Given
        let exp = expectation(description: "listWithFilters")
        capitalListRepository.getListCallbackResult = ([CapitalMock.create(id: "1"),
                                                        CapitalMock.create(id: "2"),
                                                        CapitalMock.create(id: "3")], nil)
        favouriteRepository.isFavouriteResult = { $0 == "2" }

        // When
        sut.getList(showOnlyFavourites: true) { capitals, error in
            // Then
            XCTAssertEqual(capitals?.first?.id, "2")
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func test_listWithoutFilters_shouldReturnFullList() throws {
        // Given
        let exp = expectation(description: "listWithFilters")
        capitalListRepository.getListCallbackResult = ([CapitalMock.create(id: "1"),
                                                       CapitalMock.create(id: "2"),
                                                       CapitalMock.create(id: "3")], nil)
        favouriteRepository.isFavouriteResult = { $0 == "2" }

        // When
        sut.getList(showOnlyFavourites: false) { capitals, error in
            // Then
            XCTAssertEqual(capitals?.count, 3)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func test_error_shouldReturnError() throws {
        // Given
        let exp = expectation(description: "listWithFilters")
        capitalListRepository.getListCallbackResult = (nil, ApiClientError.error)
        favouriteRepository.isFavouriteResult = { $0 == "2" }

        // When
        sut.getList(showOnlyFavourites: true) { capitals, error in
            // Then
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
