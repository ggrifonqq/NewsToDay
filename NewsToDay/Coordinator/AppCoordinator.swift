import UIKit

class AppCoordinator: Coordinator {

    override func start() {
        showMainFlow()
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}

private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return  }
        let onbordingCoordinator = OnboardingCoordinator(type: .onboarding, navigationController: navigationController, finishDelegate: self)
        addChildCoordinator(onbordingCoordinator)
        onbordingCoordinator.start()
    }
    func showMainFlow() {
        guard let navigationController = navigationController else { return }
        
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(type: .home, navigationController: homeNavigationController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "1", image: UIImage.init(systemName: "square.and.arrow.up.circle.fill"), tag: 0)
        homeCoordinator.finishDelegate = self
        homeCoordinator.start()
        
        let bookmarksNavigationController = UINavigationController()
        let bookmarksCoordinator = BookmarksCoordinator(type: .bookmarks, navigationController: bookmarksNavigationController)
        bookmarksNavigationController.tabBarItem = UITabBarItem(title: "1", image: UIImage.init(systemName: "square.and.arrow.up.circle.fill"), tag: 1)
        bookmarksCoordinator.finishDelegate = self
        bookmarksCoordinator.start()

        let categoriesNavigationController = UINavigationController()
        let categoriesCoordinator = CategoriesCoordinator(type: .home, navigationController: categoriesNavigationController)
        categoriesNavigationController.tabBarItem = UITabBarItem(title: "1", image: UIImage.init(systemName: "square.and.arrow.up.circle.fill"), tag: 2)
        categoriesCoordinator.finishDelegate = self
        categoriesCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(type: .home, navigationController: profileNavigationController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "1", image: UIImage.init(systemName: "square.and.arrow.up.circle.fill"), tag: 3)
        profileCoordinator.finishDelegate = self
        profileCoordinator.start()
        
        addChildCoordinator(homeCoordinator)
        addChildCoordinator(bookmarksCoordinator)
        addChildCoordinator(categoriesCoordinator)
        addChildCoordinator(profileCoordinator)

        let tabBarControllers = [homeNavigationController, bookmarksNavigationController, categoriesNavigationController, profileNavigationController]
        
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        
        navigationController.pushViewController(tabBarController, animated: true)
    }
}


extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any CoordinatorProtocol) {
        removeChildCoordinator(childCoordinator)
        
        switch childCoordinator.type {
        case .onboarding:
            navigationController?.viewControllers.removeAll()
            showMainFlow()
        case .app :
            print("test")
            return
        default:
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
