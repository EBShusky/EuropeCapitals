import XCTest

@testable import EuropeCapitals

class CapitalListViewModelTests: XCTestCase {

    func test_handleFetch_showDataSource() throws {
        // Given
        let coordinator = CapitalListCoordinatorStub()
        let repository = FilteredCapitalListRepositoryStub()
        let sut = CapitalListViewModel(coordinator: coordinator, filteredCapitalRepository: repository)
        repository.getListCallbackResult = ([CapitalMock.create(id: "1"),
                                             CapitalMock.create(id: "2")], nil)

        // When
        sut.handleEvent(event: .fetch)

        // Then
        XCTAssertEqual(sut.dataSource.value.count, 2)
    }

    func test_handleFetch_showLoader() throws {
        // Given
        let exp = expectation(description: "showLoader")
        let coordinator = CapitalListCoordinatorStub()
        let repository = FilteredCapitalListRepositoryStub()
        let sut = CapitalListViewModel(coordinator: coordinator, filteredCapitalRepository: repository)
        var binderEvents: [Bool] = []
        repository.getListCallbackResult = ([], nil)
        sut.isLoading.bind { binderEvents.append($0) }

        // When
        sut.handleEvent(event: .fetch)

        // Then
        DispatchQueue.main.async() {
            XCTAssertEqual(binderEvents, [true, false])
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func test_handleFetch_showError() throws {
        // Given
        let exp = expectation(description: "showError")
        let coordinator = CapitalListCoordinatorStub()
        let repository = FilteredCapitalListRepositoryStub()
        let sut = CapitalListViewModel(coordinator: coordinator, filteredCapitalRepository: repository)
        var binderEvents: [Bool] = []
        repository.getListCallbackResult = (nil, ApiClientError.error)
        sut.showError.bind { binderEvents.append($0) }

        // When
        sut.handleEvent(event: .fetch)

        // Then
        DispatchQueue.main.async() {
            XCTAssertEqual(binderEvents, [false, true])
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func test_handleCapitalPicked_presentDetails() throws {
        // Given
        let coordinator = CapitalListCoordinatorStub()
        let repository = FilteredCapitalListRepositoryStub()
        let sut = CapitalListViewModel(coordinator: coordinator, filteredCapitalRepository: repository)
        repository.getListCallbackResult = ([], nil)

        // When
        sut.handleEvent(event: .capitalPicked(viewData: CapitalListCellViewData(capital: CapitalMock.create(id: "1"))))

        // Then
        XCTAssertTrue(coordinator.showCapitalDetailsCalled)
    }

    func test_handleFavouritesChanged_shouldGetListWithFilter() throws {
        // Given
        let coordinator = CapitalListCoordinatorStub()
        let repository = FilteredCapitalListRepositoryStub()
        let sut = CapitalListViewModel(coordinator: coordinator, filteredCapitalRepository: repository)
        repository.getListCallbackResult = ([], nil)

        // When
        sut.handleEvent(event: .showFavouritesSelected(selected: true))

        // Then
        XCTAssertTrue(repository.getListShowOnlyFavouritesParameterInvoked)
    }
}
