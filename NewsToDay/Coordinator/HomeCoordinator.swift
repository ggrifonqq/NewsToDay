
import UIKit

class HomeCoordinator: Coordinator {
    override func start() {
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("OnboardingCoordinator finish")
    }
}

