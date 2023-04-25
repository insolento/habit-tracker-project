import UIKit

func collectionReloadData() {
    let habitsViewController = HabitsViewController()
    habitsViewController.myCollectionViewHabits.reloadData()
}

class CreateViewController: UIViewController {
    
    var habitMy: Habit?
    
    var hidden: Bool = true
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete habit", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        return button
    }()
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var createLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        button.setTitleColor(UIColor(named: "PurpleColor"), for: .normal)
        button.addTarget(self, action: #selector(dismissing), for: .touchUpInside)
        button.titleLabel?.textAlignment = .left
        button.isHidden = true
        return button
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        button.setTitleColor(UIColor(named: "PurpleColor"), for: .normal)
        button.addTarget(self, action: #selector(creating), for: .touchUpInside)
        button.titleLabel?.textAlignment = .right
        button.isHidden = true
        return button
    }()
    
    private lazy var createView = CreateView()
    
    private lazy var tap = UITapGestureRecognizer(
        target: self,
        action: #selector(dismissKeyboard)
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        whiteConstraints()
        buttonsContraint()
        barButtonsSetup()
        
        createView.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.title = "Create"
        
        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        
        createView.colorButton.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        view.backgroundColor = .systemGray6
        view.addGestureRecognizer(tap)
        
        
        deleteButton.isHidden = hidden
        
        createView.colorPicker.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } 
    }
    
    func setup(habit: Habit) {
        habitMy = habit
        createView.nameField.text = habit.name
        createView.date = habit.date
        createView.colorButton.tintColor = habit.color
        createView.colorPicker.selectedColor = habit.color
        createView.setupDate(date: habit.dateString)
    }
    
    func barButtonsSetup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(creating))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "PurpleColor")
        if hidden {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissing))
            navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "PurpleColor")
        }
    }
    
    func addSubviews() {
        view.addSubview(whiteView)
        view.addSubview(closeButton)
        view.addSubview(createButton)
        view.addSubview(createLabel)
        view.addSubview(createView)
        view.addSubview(deleteButton)
    }
    
    func buttonsContraint() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -80),
            closeButton.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
            createButton.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            createLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            createLabel.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor),
            createLabel.trailingAnchor.constraint(equalTo: createButton.leadingAnchor),
            createLabel.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            createView.topAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: 18),
            createView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            createView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            createView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
    }
    
    func whiteConstraints() {
        whiteView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        whiteView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    
    @objc func dismissing() {
        collectionReloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func creating() {
        if hidden {
            let store = HabitsStore.shared
            collectionReloadData()
            if let selectedDate = createView.date {
                let habit = Habit(name: createView.nameField.text ?? "", date: selectedDate, color: createView.colorPicker.selectedColor)
                store.habits.append(habit)
                self.dismiss(animated: true, completion: nil)
            } else { print("Select date!") }
        } else {
            if let habit = habitMy {
                habit.name = createView.nameField.text ?? ""
                habit.date = createView.date ?? Date.now
                habit.color = createView.colorPicker.selectedColor
                collectionReloadData()
                HabitsStore.shared.save()
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func changeColor() {
        present(createView.colorPicker, animated: true, completion: nil)
        createView.colorButton.backgroundColor = createView.colorPicker.selectedColor
    }
    
    @objc func deleteHabit() {
        if let trueHaBit = habitMy {
            HabitsStore.shared.habits = HabitsStore.shared.habits.filter({ $0 != trueHaBit })
        }
        collectionReloadData()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}


extension CreateViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        createView.colorButton.backgroundColor = viewController.selectedColor
        
    }
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        createView.colorButton.backgroundColor = viewController.selectedColor
    }
}
