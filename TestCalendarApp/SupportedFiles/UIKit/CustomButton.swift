//
//  CustomButton.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 26/8/23.
//

import UIKit

/* non-final */ class CustomButton: UIButton {
    
    // MARK: - Properties
    
    public var touchAreaPadding: UIEdgeInsets?
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriden methods
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let insets = touchAreaPadding else { return super.point(inside: point, with: event) }
        
        let rect = bounds.inset(by: insets.inverted())
        return rect.contains(point)
    }
}
