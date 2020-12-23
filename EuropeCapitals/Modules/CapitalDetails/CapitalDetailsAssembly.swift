import UIKit

protocol CapitalDetailsAssemblyProtocol {
    func assemble(capital: Capital, navigationController: UINavigationController?) -> UIViewController
}

class CapitalDetailsAssembly: CapitalDetailsAssemblyProtocol {

    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func assemble(capital: Capital, navigationController: UINavigationController?) -> UIViewController {
        let coordinator = CapitalDetailsCoordinator(resolver: resolver, navigationController: navigationController)
        let viewModel = CapitalDetailsViewModel(capital: capital,
                                                coordinator: coordinator,
                                                capitalDetailsRepository: resolver.resolve(type: CapitalDetailsRepositoryProtocol.self),
                                                favouritesRepository: resolver.resolve(type: FavouriteCapitalsRepositoryProtocol.self))
        let viewController = CapitalDetailsViewController(viewModel: viewModel)
        return viewController
    }
}
