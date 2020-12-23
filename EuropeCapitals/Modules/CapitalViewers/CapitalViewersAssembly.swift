import UIKit

protocol CapitalViewersAssemblyProtocol {
    func assemble(viewers: [CapitalViewer], navigationController: UINavigationController?) -> UIViewController
}

class CapitalViewersAssembly: CapitalViewersAssemblyProtocol {

    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func assemble(viewers: [CapitalViewer], navigationController: UINavigationController?) -> UIViewController {
        let viewModel = CapitalViewersViewModel(viewers: viewers)
        let viewController = CapitalViewersViewController(viewModel: viewModel)
        return viewController
    }
}
