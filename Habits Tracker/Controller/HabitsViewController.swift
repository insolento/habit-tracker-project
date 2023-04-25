import UIKit

class HabitsViewController: UIViewController {
    
    let myCollectionViewHabits: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()

    @IBOutlet weak var habitsNavBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        collectionViewSetup()
        addSubviews()
        setupNavigationBar()
        whiteConstraints()
        collectionConstraint()
        
    }
    
    
    func collectionViewSetup() {
        myCollectionViewHabits.delegate = self
        myCollectionViewHabits.dataSource = self
        myCollectionViewHabits.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
        myCollectionViewHabits.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: HabitsCollectionViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func addSubviews() {
        view.addSubview(whiteView)
        view.addSubview(myCollectionViewHabits)
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .done,
            target: self,
            action: #selector(addHabit)
        )
        navigationItem.title = "Today"
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = UIColor(named: "PurpleColor")
        
        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    func whiteConstraints() {
        whiteView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        whiteView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    func collectionConstraint() {
        myCollectionViewHabits.topAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: 40).isActive = true
        myCollectionViewHabits.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myCollectionViewHabits.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        myCollectionViewHabits.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    
    @objc func addHabit() {
        let create = UINavigationController(rootViewController: CreateViewController())
        create.modalPresentationStyle = .fullScreen
        self.present(create, animated: true, completion: nil)
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            let myHabits = HabitsStore.shared.habits
            return myHabits.count
        } else  { return 1 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let clearCell = UICollectionViewCell()
        if indexPath[0] == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProgressCollectionViewCell.identifier,
                for: indexPath
            ) as? ProgressCollectionViewCell
            if let currentCell = cell {
                currentCell.layer.cornerRadius = 10
                currentCell.setup()
                return currentCell
            } else { return clearCell }
        } else {
            let myHabits = HabitsStore.shared.habits
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HabitsCollectionViewCell.identifier,
                for: indexPath
            ) as? HabitsCollectionViewCell
            if let currentCell = cell {
                currentCell.setup(myHabits[indexPath.row])
                currentCell.contentView.layer.cornerRadius = 10
                return currentCell
            } else { return clearCell }
            
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 3
        
        let totalSpacing: CGFloat = 32
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (view.frame.width - 32)/1
        if indexPath[0] == 0 {
            return CGSize(width: width, height: 60)
        } else {
            return CGSize(width: width, height: 130)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 20.0,
            left: 0,
            bottom: 0,
            right: 0
        )
    }

    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            print("Did select cell at \(indexPath)")
            let myHabits = HabitsStore.shared.habits
            let newController = TrackViewController()
            newController.setup(myHabits[indexPath.row])
            navigationController?.pushViewController(newController, animated: true)
        }
}
