//
//  UINavigationController+Extensions.swift
//  Application

//
//  Created by Tiago Leme on 08/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit

extension UINavigationController {

    func pushCoordinator(_ coordinator: BaseCoordinator, animated: Bool = true) {
        pushViewController(coordinator.firstViewController, animated: animated)
    }
}
