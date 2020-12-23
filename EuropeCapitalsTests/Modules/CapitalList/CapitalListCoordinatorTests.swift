import XCTest

@testable import EuropeCapitals

class CapitalListCoordinatorTests: XCTestCase {

    func test_presentingDetails_showDetailsViewControllerInNavStack() throws {
        // Given
        let navigationController = UINavigationController()
        let sut = CapitalListCoordinator(resolver: Resolver(),
                                         navigationController: navigationController)

        // When
        sut.showCapitalDetails(capital: CapitalMock.create(id: "1"))

        // Then
        XCTAssertTrue(navigationController.viewControllers.last is CapitalDetailsViewController)
    }

}
