import UIKit

class AppCoordinator: Coordinator {

    override func start() {
        showOnboardingFlow()
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
//MARK:
private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigatorController = navigatorController else { return  }
        let onbordingCoordinator = OnboardingCoordinator(type: .onboarding, navigatorController: navigatorController, finishDelegate: self)
        addChildCoordinator(onbordingCoordinator)
        onbordingCoordinator.start()
    }
    func showMainFlow() {
        
    }
}


extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any CoordinatorProtocol) {
        removeChildCoordinator(childCoordinator)
        
        switch childCoordinator.type {
        case .app :
            return
        default:
            navigatorController?.popToRootViewController(animated: true)
        }
    }
}
