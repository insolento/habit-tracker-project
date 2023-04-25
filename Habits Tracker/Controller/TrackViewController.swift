import UIKit

class TrackViewController: UIViewController {
    
    var habitMy: Habit?
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.register(TrackTableViewCell.self, forCellReuseIdentifier: "TrackCellReuse")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Править",
            style: .plain,
            target: self,
            action: #selector(rightBarButton)
        )
        
        view.addSubview(tableView)
        
        layout()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setup(_ habit: Habit) {
        habitMy = habit
        self.navigationItem.title = habit.name
    }
    
    @objc func rightBarButton() {
        let newController = CreateViewController()
        newController.hidden = false
        if let openHabit = habitMy {
            newController.setup(habit: openHabit)
        }
        navigationController?.pushViewController(newController, animated: true)
    }
}

extension TrackViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let clearCell = UITableViewCell()
        guard let cell: TrackTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TrackCellReuse", for: indexPath) as? TrackTableViewCell else {
            return clearCell
        }
        let date = HabitsStore.shared.dates.reversed()[indexPath.row]
        if let habit = habitMy {
            cell.setup(date, HabitsStore.shared.habit(habit, isTrackedIn: date))
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension TrackViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
