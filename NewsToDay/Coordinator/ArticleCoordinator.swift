
import UIKit

class ArticleCoordinator: Coordinator {
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .blue
        navigatorController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("ArticleCoordinator finish")
    }
}

