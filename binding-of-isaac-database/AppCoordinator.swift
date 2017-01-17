//
//  AppCoordinator.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 1/17/17.
//  Copyright © 2017 Craig Holliday. All rights reserved.
//

import Foundation

struct AppCoordinator {
    
    var navigationController: NavigationController
    
    init() {
        self.navigationController = NavigationController()
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
}
