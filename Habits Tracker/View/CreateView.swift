import UIKit

class CreateView: UIView {
    
    var habitMy: Habit? = nil
    
    var date: Date?
    
    private lazy var selectedDate: String = ""
    
    let colorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    let nameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.heightAnchor.constraint(equalToConstant: 22).isActive = true
        field.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        field.backgroundColor = .clear
        field.font = UIFont.systemFont(ofSize: 17)
        field.autocapitalizationType = .sentences
        //field.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        return field
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 22).isActive = true
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black
        label.text = "НАЗВАНИЕ"
        return label
    }()
    
    let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 22).isActive = true
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black
        label.text = "ЦВЕТ"
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 22).isActive = true
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black
        label.text = "ВРЕМЯ"
        return label
    }()
    
    private lazy var everydayLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 22).isActive = true
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        label.text = "Каждый день в "
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.preferredDatePickerStyle = .wheels
        date.datePickerMode = .time
        date.translatesAutoresizingMaskIntoConstraints = false
        date.timeZone = NSTimeZone.system
        date.backgroundColor = .systemGray6
        date.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return date
    }()
    
    let colorPicker: UIColorPickerViewController = {
        let color = UIColorPickerViewController()
        color.selectedColor = .cyan
        return color
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layouts()
        colorButton.backgroundColor = colorPicker.selectedColor
    }
    
    
    func addSubviews() {
        self.addSubview(nameField)
        self.addSubview(nameLabel)
        self.addSubview(colorLabel)
        self.addSubview(timeLabel)
        self.addSubview(datePicker)
        self.addSubview(everydayLable)
        self.addSubview(colorButton)
    }
    
    func layouts() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            colorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 8),
            colorButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            everydayLable.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            everydayLable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            everydayLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            datePicker.topAnchor.constraint(equalTo: everydayLable.topAnchor, constant: 16),
            datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        let dateFormatter: DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "hh:mm a"
        
        date = sender.date
        
        selectedDate = dateFormatter.string(from: sender.date)
            
        everydayLable.text = "Каждый день в " + selectedDate
            
        print("Selected value \(selectedDate)")
    }
    
    func setupDate(date: String) {
        everydayLable.text = date
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
