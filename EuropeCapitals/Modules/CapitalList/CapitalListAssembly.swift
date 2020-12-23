import UIKit

protocol CapitalListAssemblyProtocol {
    func assemble(navigationController: UINavigationController?) -> UIViewController
}

class CapitalListAssembly: CapitalListAssemblyProtocol {

    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func assemble(navigationController: UINavigationController?) -> UIViewController {
        let coordinator = CapitalListCoordinator(resolver: resolver, navigationController: navigationController)
        let viewModel = CapitalListViewModel(coordinator: coordinator,
                                             filteredCapitalRepository: resolver.resolve(type: FilteredCapitalListRepositoryProtocol.self))
        let viewController = CapitalListViewController(viewModel: viewModel)
        return viewController
    }
}
