//
//  JokeViewController.swift
//  Application
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class JokeViewController: BaseViewController {
    
    //-----------------------------------------------------------------------------
    // MARK: - Outlets
    //-----------------------------------------------------------------------------
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let viewModel: JokeViewModel
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(viewModel: JokeViewModel) {
        
        self.viewModel = viewModel
        
        super.init()
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
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear.accept(())
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Setup
//-----------------------------------------------------------------------------

extension JokeViewController {
    
    private func setup() {
        
        setupActionButton()
        setupActivityButton()
    }
    
    private func setupActionButton() {
           
        actionButton.backgroundColor = .mainRed
        actionButton.layer.cornerRadius = actionButton.frame.height / 2
    }
    
    private func setupActivityButton() {
        
        let activityButton = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: nil)
        navigationItem.rightBarButtonItem = activityButton
    }
}

////-----------------------------------------------------------------------------
//// MARK: - Private methods - Actions
////-----------------------------------------------------------------------------
//
//extension JokeViewController {
//    
//    @objc private func activityButtonTap() {
//        viewModel.actionButtonTap
//    }
//}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Binding
//-----------------------------------------------------------------------------

extension JokeViewController {
    
    private func bind() {
        
        bindAlert()
        bindLoading()
        bindElements()
    }
    
    private func bindAlert() {
        viewModel.alert.bind(to: alert).disposed(by: disposeBag)
    }
    
    private func bindLoading() {
        
        viewModel.isLoading.bind(to: loading).disposed(by: disposeBag)
        
        viewModel.isImageLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.imageView.showLoading() : self?.imageView.hideLoading()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindElements() {
        
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        viewModel.description.bind(to: descriptionLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.imageData
            .observeOn(MainScheduler.instance)
            .filter { $0 != nil }
            .map { UIImage(data: $0!) }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        viewModel.isActivityButtonEnabled
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] isEnabled in
                self?.navigationItem.rightBarButtonItem?.isEnabled = isEnabled
            })
            .disposed(by: disposeBag)
        
        actionButton.rx.tap
            .throttle(.milliseconds(1200), scheduler: MainScheduler.instance)
            .bind(to: viewModel.actionButtonTap)
            .disposed(by: disposeBag)
        navigationItem.rightBarButtonItem?.rx.tap
            .bind(to: viewModel.activityButtonTap)
            .disposed(by: disposeBag)
    }
}
