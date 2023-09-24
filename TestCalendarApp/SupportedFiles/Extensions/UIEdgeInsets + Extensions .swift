//
//  UIEdgeInsets + Extensions .swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 26/8/23.
//

import UIKit

extension UIEdgeInsets {
    
    var horizontal: CGFloat {
        left + right
    }

    var vertical: CGFloat {
        top + bottom
    }
    
    func inverted() -> UIEdgeInsets {
        return .init(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}
