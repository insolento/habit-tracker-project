import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.text = "You will get it!"
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    
    
    private lazy var progress: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = .lightGray
        progress.tintColor = UIColor(named: "PurpleColor")
        progress.layer.cornerRadius = 3
        return progress
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        rightLabel.text = String(Int(HabitsStore.shared.todayProgress*100)) + "%"
        progress.setProgress(Float(HabitsStore.shared.todayProgress), animated: false)

        addSubviews()
        layouts()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        contentView.addSubview(progress)
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
    }

    func layouts() {
        NSLayoutConstraint.activate([
            progress.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            progress.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            progress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progress.heightAnchor.constraint(equalToConstant: 7),
            leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            leftLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            rightLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor)
            
        ])
    }
    
    func setup() {
        rightLabel.text = String(Int(HabitsStore.shared.todayProgress*100)) + "%"
        progress.setProgress(Float(HabitsStore.shared.todayProgress), animated: false)
    }

}


extension ProgressCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
