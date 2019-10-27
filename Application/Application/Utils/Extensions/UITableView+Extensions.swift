//
//  UITableView+Extensions.swift
//  Application
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit

extension UITableView {

    func register(_ classType: UITableViewCell.Type) {
        
        let className = String(describing: classType)
        let nib = UINib(nibName: className, bundle: Bundle(for: classType))
        
        register(nib, forCellReuseIdentifier: className)
    }
}
