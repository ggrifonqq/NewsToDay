import UIKit

enum CoordinatorType {
    case app
    case onboarding
    case home
    case order
    case list
    case profile
}

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorType { get }
    var navigatorController: UINavigationController? { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start()
    func finish()
}

extension CoordinatorProtocol {
    
    func addChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators.append(childCoordinator)
    }
    func removeChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter{ $0 !==  childCoordinator}
    }

}

protocol CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol)
}

protocol TabBarCoordinator: AnyObject, CoordinatorProtocol {
    var tabBarController: UITabBarController? { get set }
}

class Coordinator : CoordinatorProtocol {
    var childCoordinators: [any CoordinatorProtocol]
    
    var type: CoordinatorType
    
    var navigatorController: UINavigationController?
    
    var finishDelegate: (any CoordinatorFinishDelegate)?
    
    init(childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol](), type: CoordinatorType, navigatorController: UINavigationController, finishDelegate: (any CoordinatorFinishDelegate)? = nil) {
        self.childCoordinators = childCoordinators
        self.type = type
        self.navigatorController = navigatorController
        self.finishDelegate = finishDelegate
    }
    
    deinit {
        print("Coordinator dinit \(type)")
        childCoordinators.forEach { $0.finishDelegate = nil }
        childCoordinators.removeAll()
    }
    
    
    func start() {
        print("Coordinator start")
    }
    
    func finish() {
        print("Coordinator finish")
    }
    
    
}
