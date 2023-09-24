//
//  CalendarHeader.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 26/8/23.
//

import UIKit

protocol CalendarHeaderDelegate: AnyObject {
    
    func didSelectCalendarItem(with dates: [Date])
}

final class CalendarHeader: UITableViewHeaderFooterView {
    
    // MARK: - UI Components
    
    private let contentBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "calendarBackgroundColor")
        view.clipsToBounds = true
        view.cornerRadius = 12
        return view
    }()
   
    private var calendarView: VACalendarView?
    
    private lazy var monthView: VAMonthHeaderView = {
        let view = VAMonthHeaderView()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "LLLL yyyy"
        let appereance = VAMonthHeaderViewAppearance(
            previousButtonImage: ImageAssets.leftArrowIcon,
            nextButtonImage: ImageAssets.rightArrowIcon,
            dateFormatter: dateFormatter
        )
        view.delegate = self
        view.appearance = appereance
        return view
    }()
    
    private lazy var weeksDayView: VAWeekDaysView = {
        let view = VAWeekDaysView()
        let appereance = VAWeekDaysViewAppearance(symbolsType: .veryShort, calendar: defaultCalendar)
        view.appearance = appereance
        return view
    }()
    
    // MARK: - Properties
    
    private var defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        calendar.firstWeekday = 2
        return calendar
    }()
    
    weak var delegate: CalendarHeaderDelegate?
   
    // MARK: - Initialize
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if calendarView?.frame == .zero {
            calendarView?.frame = CGRect(
                x: .zero,
                y: weeksDayView.frame.minY + 96,
                width: contentView.frame.width - 32,
                height: 300
            )
            calendarView?.setup()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
   
    private func setupUI() {
        contentView.addSubview(contentBackgroundView)
        contentBackgroundView.addSubviews([monthView, weeksDayView])
        setConstraints()
        setupCalendarView()
    }
    
    private func setConstraints() {
        contentBackgroundView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(400)
            $0.verticalEdges.equalToSuperview()
        }
        
        monthView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-32)
            $0.leading.equalToSuperview().offset(16)
        }
        
        weeksDayView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(monthView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setupCalendarView() {
        let calendar = VACalendar(calendar: defaultCalendar)
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        calendarView?.showDaysOut = true
        calendarView?.selectionStyle = .multi
        calendarView?.monthDelegate = monthView
        calendarView?.dayViewAppearanceDelegate = self
        calendarView?.monthViewAppearanceDelegate = self
        calendarView?.calendarDelegate = self
        calendarView?.scrollDirection = .horizontal
        calendarView?.setSupplementaries([
            (Date().addingTimeInterval(-(60 * 60 * 70)), [VADaySupplementary.bottomDots([.red, .magenta])]),
            (Date().addingTimeInterval((60 * 60 * 110)), [VADaySupplementary.bottomDots([.red])]),
            (Date().addingTimeInterval((60 * 60 * 370)), [VADaySupplementary.bottomDots([.blue, .darkGray])]),
            (Date().addingTimeInterval((60 * 60 * 430)), [VADaySupplementary.bottomDots([.orange, .purple, .cyan])])
            ])
        guard let calendarView = calendarView else { return }
        contentBackgroundView.addSubview(calendarView)
    }
}

extension CalendarHeader: VAMonthHeaderViewDelegate {
    
    func didTapNextMonth() {
        UIView.animate(withDuration: 0.65) {
            self.calendarView?.nextMonth()
        }
    }
    
    func didTapPreviousMonth() {
        UIView.animate(withDuration: 0.65) {
            self.calendarView?.previousMonth()
        }
    }
}

extension CalendarHeader: VAMonthViewAppearanceDelegate {
    
    func leftInset() -> CGFloat {
        return 10.0
    }
    
    func rightInset() -> CGFloat {
        return 10.0
    }
    
    func verticalMonthTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func verticalMonthTitleColor() -> UIColor {
        return .black
    }
    
    func verticalCurrentMonthTitleColor() -> UIColor {
        return .red
    }
}

extension CalendarHeader: VADayViewAppearanceDelegate {
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
        case .selected:
            return .white
        case .unavailable:
            return .lightGray
        default:
            return .black
        }
    }
    
    func textBackgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return .red
        default:
            return .clear
        }
    }
    
    func shape() -> VADayShape {
        return .circle
    }
    
    func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return -7
        }
    }
}

extension CalendarHeader: VACalendarViewDelegate {
    
    func selectedDates(_ dates: [Date]) {
        calendarView?.startDate = dates.last ?? Date()
        delegate?.didSelectCalendarItem(with: dates)
        print(dates)
    }
}
