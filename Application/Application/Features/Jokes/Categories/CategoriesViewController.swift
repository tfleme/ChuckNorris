//
//  CategoriesViewController.swift
//  Application
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CategoriesViewController: BaseViewController {
    
    //-----------------------------------------------------------------------------
    // MARK: - Outlets
    //-----------------------------------------------------------------------------
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(CategoryCell.self)
        }
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let viewModel: CategoriesViewModel
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(viewModel: CategoriesViewModel) {
        
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

extension CategoriesViewController {
    
    private func setup() {
        
        navigationItem.title = "Categories"
        setupAccessbilities()
    }
    
    private func setupAccessbilities() {
        
        tableView.accessibilityLabel = "CategoriesViewController.tableView"
        tableView.isAccessibilityElement = true
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Binding
//-----------------------------------------------------------------------------

extension CategoriesViewController {
    
    private func bind() {
        
        viewModel.isLoading.bind(to: loading).disposed(by: disposeBag)
        viewModel.alert.bind(to: alert).disposed(by: disposeBag)
        
        viewModel.categoryCellViewModels
            .bind(to: tableView.rx.items(
                cellIdentifier: CategoryCell.identifier,
                cellType: CategoryCell.self)) { row, cellViewModel, cell in
                
                cell.configure(with: cellViewModel)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
    }
}
