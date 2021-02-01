import UIKit

struct ApplicationRouter {
    static func setup(windows: UIWindow?) {
        let repository: CharacterRemoteRepository       = .init()
        let tabBarController: UITabBarController        = .init()
        tabBarController.tabBar.isTranslucent           = false
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.viewControllers                = [HomeRouter.viewController(repository: repository), FavoriteRouter.viewController(repository: FavoriteLocalRepository())]
        tabBarController.selectedIndex                  = 0
        windows?.rootViewController                     = tabBarController
        windows?.makeKeyAndVisible()
    }
}

