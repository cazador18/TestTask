
import UIKit
import SnapKit

public protocol VAMonthHeaderViewDelegate: AnyObject {
    func didTapNextMonth()
    func didTapPreviousMonth()
}

public struct VAMonthHeaderViewAppearance {
    
    let monthFont: UIFont
    let monthTextColor: UIColor
    let monthTextWidth: CGFloat
    let previousButtonImage: UIImage
    let nextButtonImage: UIImage
    let dateFormatter: DateFormatter
    
    static public let defaultFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
    
    public init(
        monthFont: UIFont = UIFont.systemFont(ofSize: 16),
        monthTextColor: UIColor = UIColor.black,
        monthTextWidth: CGFloat = 190,
        previousButtonImage: UIImage = UIImage(),
        nextButtonImage: UIImage = UIImage(),
        dateFormatter: DateFormatter = VAMonthHeaderViewAppearance.defaultFormatter) {
        self.monthFont = monthFont
        self.monthTextColor = monthTextColor
        self.monthTextWidth = monthTextWidth
        self.previousButtonImage = previousButtonImage
        self.nextButtonImage = nextButtonImage
        self.dateFormatter = dateFormatter
    }
    
}

public class VAMonthHeaderView: UIView {
    
    public var appearance = VAMonthHeaderViewAppearance() {
        didSet {
            dateFormatter = appearance.dateFormatter
            setupView()
        }
    }
    
    public weak var delegate: VAMonthHeaderViewDelegate?
    
    private var dateFormatter = DateFormatter()
    private let monthLabel = UILabel()
    private let previousButton = UIButton()
    private let nextButton = UIButton()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonWidth: CGFloat = 50.0
        monthLabel.frame = CGRect(x: 0, y: 0, width: appearance.monthTextWidth, height: frame.height)
        monthLabel.center.x = center.x
        previousButton.frame = CGRect(x: monthLabel.frame.minX - buttonWidth, y: 0, width: buttonWidth, height: frame.height)
        nextButton.frame = CGRect(x: monthLabel.frame.maxX, y: 0, width: buttonWidth, height: frame.height)
    }
    
    private func setupView() {
        subviews.forEach { $0.removeFromSuperview() }
        
        backgroundColor = .clear
        monthLabel.font = appearance.monthFont
        monthLabel.textAlignment = .center
        monthLabel.textColor = appearance.monthTextColor
        
        previousButton.setImage(appearance.previousButtonImage, for: .normal)
        previousButton.addTarget(self, action: #selector(didTapPrevious(_:)), for: .touchUpInside)
        
        nextButton.setImage(appearance.nextButtonImage, for: .normal)
        nextButton.addTarget(self, action: #selector(didTapNext(_:)), for: .touchUpInside)
        
        addSubview(monthLabel)
        addSubview(previousButton)
        addSubview(nextButton)
        
//        setConstraints()
        layoutSubviews()
    }
    
    private func setConstraints() {
        monthLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: appearance.monthTextWidth, height: 48))
        }
        
        previousButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24, height: 48))
            $0.centerY.equalTo(monthLabel)
            $0.leading.equalToSuperview().offset(32)
        }
        
        nextButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24, height: 48))
            $0.centerY.equalTo(monthLabel)
            $0.trailing.equalToSuperview()
        }
    }
    
    @objc
    private func didTapNext(_ sender: UIButton) {
        nextButton.pulsate()
        delegate?.didTapNextMonth()
    }
    
    @objc
    private func didTapPrevious(_ sender: UIButton) {
        previousButton.pulsate()
        delegate?.didTapPreviousMonth()
    }
    
}

extension VAMonthHeaderView: VACalendarMonthDelegate {
    
    public func monthDidChange(_ currentMonth: Date) {
        monthLabel.set(text: dateFormatter.string(from: currentMonth), leftIcon: UIImage(systemName: "calendar"))
//        monthLabel.text = dateFormatter.string(from: currentMonth)
    }
}

extension UILabel {

    func set(text:String, leftIcon: UIImage? = nil, rightIcon: UIImage? = nil) {

        let leftAttachment = NSTextAttachment()
        leftAttachment.image = leftIcon
        leftAttachment.bounds = CGRect(x: 0, y: -2.5, width: 20, height: 20)
        if let leftIcon = leftIcon {
            leftAttachment.bounds = CGRect(x: 0, y: -2.5, width: leftIcon.size.width, height: leftIcon.size.height)
        }
        let leftAttachmentStr = NSAttributedString(attachment: leftAttachment)

        let myString = NSMutableAttributedString(string: "")

        let rightAttachment = NSTextAttachment()
        rightAttachment.image = rightIcon
        rightAttachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 20)
        let rightAttachmentStr = NSAttributedString(attachment: rightAttachment)


        if semanticContentAttribute == .forceRightToLeft {
            if rightIcon != nil {
                myString.append(rightAttachmentStr)
                myString.append(NSAttributedString(string: "  "))
            }
            myString.append(NSAttributedString(string: text))
            if leftIcon != nil {
                myString.append(NSAttributedString(string: "  "))
                myString.append(leftAttachmentStr)
            }
        } else {
            if leftIcon != nil {
                myString.append(leftAttachmentStr)
                myString.append(NSAttributedString(string: "  "))
            }
            myString.append(NSAttributedString(string: text))
            if rightIcon != nil {
                myString.append(NSAttributedString(string: "  "))
                myString.append(rightAttachmentStr)
            }
        }
        attributedText = myString
    }
}
