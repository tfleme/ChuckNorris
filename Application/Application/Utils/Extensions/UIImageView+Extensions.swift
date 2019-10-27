//
//  UIImageView+Extensions.swift
//  Application
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func showLoading(style: UIActivityIndicatorView.Style = .gray) {
        
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        addSubview(activityIndicatorView)
        
        activityIndicatorView.color = .mainActivityIndicatorColor
        activityIndicatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicatorView.frame = bounds
        activityIndicatorView.startAnimating()
    }
    
    func hideLoading() {
        
        if let activityIndicatorView = subviews.first as? UIActivityIndicatorView {
            activityIndicatorView.removeFromSuperview()
        }
    }
}
