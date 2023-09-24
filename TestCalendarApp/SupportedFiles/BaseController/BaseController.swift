//
//  BaseController.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 15/8/23.
//

import UIKit

class BaseController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        view.backgroundColor = .white
    }
}
