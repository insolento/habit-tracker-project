import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    var habitIn: Habit?
    
    var buttonTapped: Bool = false
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .blue
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var middleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray2
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.backgroundColor = .clear
        return label
    }()
    
    let completedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("✓", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 38).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        button.layer.borderWidth = 2
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        addSubviews()
        layouts()
    }
    
    func addSubviews() {
        contentView.addSubview(topLabel)
        contentView.addSubview(middleLabel)
        contentView.addSubview(bottomLabel)
        contentView.addSubview(completedButton)
    }
    
    func layouts() {
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            topLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            topLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            middleLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            middleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            middleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bottomLabel.topAnchor.constraint(equalTo: middleLabel.bottomAnchor, constant: 30),
            bottomLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            bottomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            completedButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ habit: Habit) {
        topLabel.text = habit.name
        middleLabel.text = habit.dateString
        completedButton.layer.borderColor = habit.color.cgColor
        buttonTapped = habit.isAlreadyTakenToday
        
        if buttonTapped == true {
            completedButton.backgroundColor = habit.color
        } else { completedButton.backgroundColor = .clear }
        habitIn = habit
        
        var numberOfCompliting = 0
        
        for date in HabitsStore.shared.dates {
            if HabitsStore.shared.habit(habit, isTrackedIn: date) {
                numberOfCompliting += 1
            }
        }
        if habit.isAlreadyTakenToday {
            numberOfCompliting += 1
        }
        
        bottomLabel.text = "Counter: \(numberOfCompliting)"
    }
    
    @objc func tapped() {
        if buttonTapped {
            buttonTapped = false
            //completedButton.backgroundColor = .clear
            collectionReloadData()
        } else {
            buttonTapped = true
            completedButton.backgroundColor = UIColor(cgColor: completedButton.layer.borderColor ?? CGColor(gray: 0, alpha: 0))
            if let trueHabit = habitIn {
                HabitsStore.shared.track(trueHabit)
            }
            collectionReloadData()
        }
    }
    
}

extension HabitsCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}


