//
//  CategoryCell.swift
//  Application
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit

final class CategoryCell: UITableViewCell {
    
    static let identifier = "CategoryCell"
    
    //-----------------------------------------------------------------------------
    // MARK: - Outlets
    //-----------------------------------------------------------------------------

    @IBOutlet weak var titleLabel: UILabel!
    
    //-----------------------------------------------------------------------------
    // MARK: - Overrides
    //-----------------------------------------------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    func configure(with viewModel: CategoryCellViewModel) {
        titleLabel.text = viewModel.title
    }
}

//-----------------------------------------------------------------------------
// MARK: Private methods - Setup
//-----------------------------------------------------------------------------

extension CategoryCell {
    
    private func setup() {
        
    }
}
