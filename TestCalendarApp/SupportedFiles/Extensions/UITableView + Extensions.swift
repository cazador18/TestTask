//
//  UITableView + Extensions.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 25/8/23.
//

import UIKit

extension UITableView {
    
    func registrateCell<T: UITableViewCell>(_ cellType: T.Type) {
        let className = String(describing: cellType)
        let identifier = className + "Id"
        register(cellType, forCellReuseIdentifier: identifier)
    }
    
    func registrateHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerType: T.Type) {
        let className = String(describing: headerType)
        let identifier = className + "Id"
        register(headerType, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func dequeueReuseableCell<T: UITableViewCell>(_ cellType: T.Type, _ indexPath: IndexPath) -> T? {
        let className = String(describing: cellType)
        let identifier = className + "Id"
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T
    }
    
    func dequeueReuseableHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerType: T.Type) -> T? {
        let className = String(describing: headerType)
        let identifier = className + "Id"
        return dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T
    }
}
