//
//  AlertViewController.swift
//  Application
//
//  Created by Tiago Leme on 03/07/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit

final class AlertViewController: UIViewController {
    
    //-----------------------------------------------------------------------------
    // MARK: - Outlets
    //-----------------------------------------------------------------------------

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private var viewModel: AlertViewModel
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(with viewModel: AlertViewModel) {
        
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - View lifecycle
    //-----------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setInitialContentViewTransform()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateContentViewIdentityTransform()
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Setup
//-----------------------------------------------------------------------------

extension AlertViewController {
    
    private func setup() {
        
        titleLabel.text = viewModel.title
        messageLabel.text = viewModel.message
        
        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        
        actionButton.layer.cornerRadius = actionButton.frame.height / 2
        contentView.layer.cornerRadius = actionButton.layer.cornerRadius
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Action
//-----------------------------------------------------------------------------

extension AlertViewController {
    
    @IBAction private func actionButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.viewModel.actionButtonTapHandler?()
        }
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Animations
//-----------------------------------------------------------------------------

extension AlertViewController {
    
    private func setInitialContentViewTransform() {
        contentView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    }
    
    private func animateContentViewIdentityTransform() {
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.5,
            options: [],
            animations: {
                self.contentView.transform = .identity
            }
        )
    }
}
