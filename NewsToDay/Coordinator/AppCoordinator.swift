//
//  AppCoordinator.swift
//  NewsToDay
//
//  Created by baikal on 19.03.2024.
//

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
        
    }
    func showMainFlow() {
        
    }
}

