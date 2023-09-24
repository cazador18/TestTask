//
//  CalendarController.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 15/8/23.
//

import UIKit

final class CalendarController: BaseTableController {
    
    private enum Constant {
        
        static let navigationTitle: String = "Event Calendar"
        static let addButtonTitle: String = "Add"
    }
    
    // MARK: - UI Components
    
    private lazy var rightAddButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitle(Constant.addButtonTitle, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(tappedOnRightBarItem), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private var events = [EventModel]()
    private var selectedDates = [Date]()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        title = Constant.navigationTitle
        setupNavgiationBar()
        registerSubviews()
    }
    
    private func setupNavgiationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightAddButton)
    }
    
    private func registerSubviews() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.contentInset = .init(top: 20, left: .zero, bottom: 20, right: .zero)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.registrateHeaderFooterView(CalendarHeader.self)
        tableView.registrateCell(EventCell.self)
    }
    
    // MARK: - Actions
    
    @objc private func tappedOnRightBarItem() {
        rightAddButton.pulsate()
        setupAlertController()
    }
    
    // MARK: - Setup AlertController
    
    private func setupAlertController() {
        let alertController = UIAlertController(title: "Add new event ?", message: nil, preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if !self.selectedDates.isEmpty {
                self.selectedDates.forEach { _ in
                    self.events.append(.init(title: "", time: "", date: ""))
                }
                self.tableView.reloadData()
            } else {
                print("Empty")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension CalendarController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReuseableHeaderFooterView(CalendarHeader.self) else { return nil }
        headerView.delegate = self
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReuseableCell(EventCell.self, indexPath) else { return .init(frame: .zero) }
        cell.eventModel = events[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewEventController()
        vc.newEventModelListener = { [weak self] model in
            self?.events[indexPath.row] = model
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - CalendarCellDelegate

extension CalendarController: CalendarHeaderDelegate {
    
    func didSelectCalendarItem(with dates: [Date]) {
        selectedDates = dates
    }
}
