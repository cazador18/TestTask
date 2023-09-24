//
//  NewEventController.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 15/8/23.
//

import UIKit

final class NewEventController: BaseController {
    
    // MARK: - UI Components
    
    private lazy var backButton: CustomButton = {
        let button = CustomButton(frame: .init(x: .zero, y: .zero, width: 24, height: 24))
        button.touchAreaPadding = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.addTarget(self, action: #selector(didTapOnBackButton), for: .touchUpInside)
        button.setImage(UIImage(named: "leftArrowIcon"), for: .normal)
        return button
    }()
    
    private lazy var addEventButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapOnAddButton), for: .touchUpInside)
        return button
    }()
    
    private let eventTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Event Title"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let eventTextField: CustomTextField = {
        let view = CustomTextField()
        view.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "textFieldColor")
        return view
    }()
    
    private let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let dateTextField: CustomTextField = {
        let view = CustomTextField()
        view.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "textFieldColor")
        return view
    }()
    
    private let timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let timeTextField: CustomTextField = {
        let view = CustomTextField()
        view.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "textFieldColor")
        return view
    }()
    
    // MARK: - Properties
    
    var newEventModelListener: ((EventModel) -> Void)?
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        title = "New Event"
        setupAddNewEventButton()
        view.addSubviews([eventTitleLabel,
                          eventTextField,
                          dateTitleLabel,
                          dateTextField,
                          timeTitleLabel,
                          timeTextField])
        setConstraints()
    }
    
    private func setupAddNewEventButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addEventButton)
    }
    
    private func setConstraints() {
        eventTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.layoutMarginsGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        eventTextField.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(eventTitleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        dateTitleLabel.snp.makeConstraints {
            $0.top.equalTo(eventTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        timeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(eventTextField.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(-100)
        }
        
        timeTextField.snp.makeConstraints {
            $0.top.equalTo(timeTitleLabel.snp.bottom).offset(8)
            $0.size.equalTo(CGSize(width: 120, height: 48))
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        dateTextField.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(dateTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(timeTextField.snp.leading).offset(-8)
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapOnAddButton() {
        newEventModelListener?(.init(title: eventTitleLabel.text,
                                     time: timeTextField.text,
                                     date: dateTextField.text))
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapOnBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
