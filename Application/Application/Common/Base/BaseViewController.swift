//
//  BaseViewController.swift
//  Application
//
//  Created by Tiago Leme on 08/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private lazy var loadingView: UIView = {
        
        let loadingView = UIView(frame: view.frame)
        loadingView.backgroundColor = .mainLoadingColor
        loadingView.alpha = 0.0
        loadingView.isUserInteractionEnabled = false
        
        view.addSubview(loadingView)
        
        return loadingView
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.color = .mainActivityIndicatorColor
        activityView.hidesWhenStopped = true
        activityView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        
        view.addSubview(activityView)
        
        return activityView
    }()
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    let loading = PublishRelay<Bool>()
    let alert = PublishRelay<AlertViewModel>()
    let disposeBag = DisposeBag()
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loadingView.frame = view.frame
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Setup
//-----------------------------------------------------------------------------

extension BaseViewController {
    
    private func setup() {
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.tintColor = .mainRed
        navigationController?.navigationBar.barTintColor = .mainBarColor
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Binding
//-----------------------------------------------------------------------------

extension BaseViewController {
    
    private func bind() {
        
        loading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in self?.handle(isLoading: $0) })
            .disposed(by: disposeBag)
        alert
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in self?.presentAlert(with: $0) })
            .disposed(by: disposeBag)
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Loading
//-----------------------------------------------------------------------------

extension BaseViewController {
    
    private func handle(isLoading: Bool) {
        isLoading ? startLoading() : stopLoading()
    }
    
    private func startLoading() {
        
        activityView.startAnimating()
        UIView.animate(withDuration: 0.1) {
            self.loadingView.alpha = 0.5
        }
    }
    
    private func stopLoading() {
        
        activityView.stopAnimating()
        UIView.animate(withDuration: 0.3) {
            self.loadingView.alpha = 0.0
        }
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Loading
//-----------------------------------------------------------------------------

extension BaseViewController {
    
    private func presentAlert(with viewModel: AlertViewModel) {
        present(AlertViewController(with: viewModel), animated: false)
    }
}
