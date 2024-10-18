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

// MARK: - MovieDetailsViewController
final class MovieDetailsViewController: UIViewController {
    
    // MARK: Properties
    private let viewModel: any MovieDetailsViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: Outlets
    private lazy var posterView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Consts.String.imageName)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var blockView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.applyShadow()
        view.layer.cornerRadius = Consts.Layouts.cornerRadius
        return view
    }()
    
    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var releaseDateText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [titleText, releaseDateText])
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [hStackView, descriptionText])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .top
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
                releaseDateText.text = movie.releaseDate
            }
            .store(in: &subscriptions)
    }
}

// MARK: - UI setups
private extension MovieDetailsViewController {
    func setupUI() {
        view.addSubview(posterView)
        posterView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(440)
        }
        
        view.addSubview(blockView)
        blockView.snp.makeConstraints { make in
            make.top.equalTo(posterView.snp.bottom).offset(-40)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        blockView.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        releaseDateText.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        hStackView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}

// MARK: - Consts
private extension MovieDetailsViewController {
    enum Consts {
        enum String {
            static let imageName = "poster"
        }
        
        enum Layouts {
            static let horizontalInsent: CGFloat = 20
            static let verticalInsent: CGFloat = 10
            static let blockHeight: CGFloat = 70
            static let starSize: CGFloat = 20
            static let cornerRadius: CGFloat = 15
            static let stackInsent: CGFloat = 14
        }
    }
}
