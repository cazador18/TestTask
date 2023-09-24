//
//  EventCell.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 25/8/23.
//

import UIKit

final class EventCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let contentBackgroundView: UIView = {
        let view = UIView()
        view.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "calendarBackgroundColor")
        return view
    }()
    
    private let blueLineView: UIView = {
        let view = UIView()
        view.cornerRadius = 4
        view.clipsToBounds = true
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let eventNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    // MARK: - Properties
    
    var eventModel: EventModel? {
        didSet {
            eventNameLabel.text = eventModel?.title
            timeLabel.text = eventModel?.time
        }
    }
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(contentBackgroundView)
        contentBackgroundView.addSubviews([blueLineView, eventNameLabel, timeLabel])
        setConstraints()
    }
    
    private func setConstraints() {
        contentBackgroundView.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        blueLineView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.width.equalTo(3)
            $0.leading.equalToSuperview().offset(8)
        }
        
        timeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
        }
        
        eventNameLabel.snp.makeConstraints {
            $0.leading.equalTo(blueLineView.snp.trailing).offset(8)
            $0.trailing.equalTo(timeLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
        }
    }
}
