//
//  UIView + Extensions.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 25/8/23.
//

import UIKit

extension UIView {
    
    // UI Properties
    var cornerRadius: CGFloat {
        get { layer.cornerRadius  }
        set { layer.cornerRadius = newValue }
    }
    
    var shadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    var shadowOpacity: Float {
        get { layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    var shadowOffset: CGSize {
        get { layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    var borderColor: UIColor? {
        get { layer.borderColor.flatMap { UIColor(cgColor: $0) } }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: .init(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    // Add subviewes
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    // For view animation
    func pulsate() {
        self.pulsate(sender: self)
    }
    
    func pulsate(sender: UIView) {
        let pulsate = CASpringAnimation(keyPath: "transform.scale")
        pulsate.duration = 0.5
        pulsate.repeatCount = 0
        pulsate.autoreverses = false
        pulsate.fromValue = 0.94
        pulsate.toValue = 0.99
        pulsate.autoreverses = false
        pulsate.initialVelocity = 0
        pulsate.damping = 1
        layer.add(pulsate, forKey: nil)
    }
}
