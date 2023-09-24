//
//  AppSettings.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 26/8/23.
//

import UIKit

final class AppsSetting: NSObject {
    
    static let instance = AppsSetting()
    
    func configureSettings() {
        setupNavigationBarStyle()
    }
    
    private func setupNavigationBarStyle() { }
}
