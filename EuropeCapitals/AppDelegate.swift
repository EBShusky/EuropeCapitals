import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var mainWindow: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        mainWindow = UIWindow(frame: UIScreen.main.bounds)
        mainWindow?.rootViewController = createStartModule()
        mainWindow?.makeKeyAndVisible()
        return true
    }

    func createStartModule() -> UIViewController {
        let resolver = Resolver()

        let assembly = resolver.resolve(type: CapitalListAssemblyProtocol.self)
        let navigationController = UINavigationController()
        let viewController = assembly.assemble(navigationController: navigationController)
        navigationController.viewControllers = [viewController]
        return navigationController
    }
}
