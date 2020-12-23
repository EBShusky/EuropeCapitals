import UIKit

protocol CapitalListCoordinatorProtocol {
    func showCapitalDetails(capital: Capital)
}

class CapitalListCoordinator: CapitalListCoordinatorProtocol {

    private let resolver: Resolver
    private weak var navigationController: UINavigationController?

    init(resolver: Resolver,
         navigationController: UINavigationController?) {
        self.resolver = resolver
        self.navigationController = navigationController
    }

    func showCapitalDetails(capital: Capital) {
        let assembly = resolver.resolve(type: CapitalDetailsAssemblyProtocol.self)
        let vc = assembly.assemble(capital: capital, navigationController: navigationController)
        navigationController?.pushViewController(vc, animated: true)
    }
}
