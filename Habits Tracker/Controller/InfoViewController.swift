import UIKit

class InfoViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .systemBackground
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }()

    let titleLabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 1
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        text.text = Constant.textTop
        return text
    }()

    let subtitleLabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.text = Constant.textBottom
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Информация"
        addViews()
        scrollViewConstraints()
        stackViewConstraint()
        textConstraints()

    }
    
    func scrollViewConstraints() {
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func stackViewConstraint() {
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    func textConstraints() {
        stackView.addSubview(titleLabel)
        titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 24).isActive = true

        stackView.addSubview(subtitleLabel)
        subtitleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 40).isActive = true

        subtitleLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addSubview(titleLabel)
        stackView.addSubview(subtitleLabel)
    }
}
