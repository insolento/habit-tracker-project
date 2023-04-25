import UIKit

class TrackTableViewCell: UITableViewCell {
    
    private lazy var checkMark: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor(named: "PurpleColor")
        image.image = UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        return image
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setup(_ date: Date, _ complete: Bool) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "d MMM yyyy"
        if Calendar.current.isDateInToday(date) {
            dateLabel.text = "Сегодня"
        } else if Calendar.current.isDateInYesterday(date) {
            dateLabel.text = "Вчера"
        } else {
        dateLabel.text = dateFormat.string(from: date)
        }
        checkMark.isHidden = !complete
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        dataLabelSetting()
        checkmarkSetting()
    }
    
    func dataLabelSetting() {
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func checkmarkSetting() {
        contentView.addSubview(checkMark)
        NSLayoutConstraint.activate([
            checkMark.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkMark.heightAnchor.constraint(equalTo: checkMark.widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
