//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import UIKit
import Combine
import Factory
import SDWebImage

final class MovieDetailsViewController: UIViewController {
    
    // MARK: Properties
    private let viewModel: any MovieDetailsViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: Outlets
    private lazy var posterView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [posterView, titleText, descriptionText])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .leading
        return stackView
    }()
    
    // MARK: Initializer
    init(viewModel: any MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        bind(to: viewModel)
    }

}
// MARK: - Binding
private extension MovieDetailsViewController {
    func bind(to viewModel: MovieDetailsViewModel) {
        viewModel.moviePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movie in
                guard let self else { return }
                titleText.text = movie.title
                descriptionText.text = movie.description
            }
            .store(in: &subscriptions)
    }
}
// MARK: - UI setups
private extension MovieDetailsViewController {
    func setupUI() {
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        posterView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        
        titleText.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
}
