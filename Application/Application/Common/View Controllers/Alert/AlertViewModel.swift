//
//  AlertViewModel.swift
//  Application
//
//  Created by Tiago Leme on 03/07/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation
import Domain

struct AlertViewModel {
    
    let title: String
    let message: String
    let actionButtonTitle: String
    let actionButtonTapHandler: (() -> Void)?
    
    init(title: String,
         message: String,
         actionButtonTitle: String = "OK",
         actionButtonTapHandler: (() -> Void)? = nil) {
 
        self.title = title
        self.message = message
        self.actionButtonTitle = actionButtonTitle
        self.actionButtonTapHandler = actionButtonTapHandler
    }
    
    init(viewModelError: ViewModelError,
         actionButtonTitle: String = "OK",
         actionButtonTapHandler: (() -> Void)? = nil) {
        
        self.title = viewModelError.title
        self.message = viewModelError.message
        self.actionButtonTitle = actionButtonTitle
        self.actionButtonTapHandler = actionButtonTapHandler
    }
}
