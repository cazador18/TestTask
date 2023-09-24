//
//  CustomTextField.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 26/8/23.
//

import UIKit

/* non-final */class CustomTextField: UITextField {
    
    // MARK: - Properties
    
    public var textInsets = UIEdgeInsets(top: .zero, left: 12, bottom: .zero, right: 12) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriden methods
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds .inset(by: textInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }
}
