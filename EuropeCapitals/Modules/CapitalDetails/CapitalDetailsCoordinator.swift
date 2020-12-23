import UIKit

protocol CapitalDetailsCoordinatorProtocol {
    func showCapitalViewers(viewers: [CapitalViewer])
}

class CapitalDetailsCoordinator: CapitalDetailsCoordinatorProtocol {

    private let resolver: Resolver
    private weak var navigationController: UINavigationController?

    init(resolver: Resolver,
         navigationController: UINavigationController?) {
        self.resolver = resolver
        self.navigationController = navigationController
    }

    func showCapitalViewers(viewers: [CapitalViewer]) {
        let assembly = resolver.resolve(type: CapitalViewersAssemblyProtocol.self)
        let nc = UINavigationController()
        let vc = assembly.assemble(viewers: viewers, navigationController: nc)
        nc.viewControllers = [vc]

        navigationController?.present(nc, animated: true, completion: nil)
    }
}
