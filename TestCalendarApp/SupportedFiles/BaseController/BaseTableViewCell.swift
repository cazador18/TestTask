//
//  BaseTableViewCell.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 25/8/23.
//

import UIKit

/* non-final */ class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    open func setupUI() {
        
    }
}
