//
//  AppCoordinator.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import UIKit
class AppCoordinator {
    private var navController: UINavigationController?
    private let appWindow: UIWindow?
    
    init(appWindow: UIWindow?) {
        self.appWindow = appWindow
    }
    
    func start() {
        navController = UINavigationController()
        appWindow?.rootViewController = navController
        let controller = WeatherHomeController()
        controller.delegate = self
        let vc = WeatherHomeViewController(controller)
        navController?.pushViewController(vc, animated: false)
        appWindow?.makeKeyAndVisible()
    }
    
}

extension AppCoordinator: WeatherHomeCoordinatorDelegate {
    func launchDetailVC(with viewModels: [DetailCellViewModel]) {
        let vc = DetailViewController(with: viewModels)
        navController?.pushViewController(vc, animated: true)
    }
}
