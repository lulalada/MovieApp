//
//  TrendingMoviesViewController.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 17/10/2024.
//

import UIKit
import Factory
import Combine
import SnapKit

// MARK: - TrendingMoviesViewController
final class TrendingMoviesViewController: UIViewController {
    
    // MARK: Properties
    private let viewModel: any TrendingMoviesViewModel
    private var trendingMovies: [BasicMovie] = []
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: Outlets
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var searchField = SearchTextField()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [titleLabel, searchField])
        stackView.axis = .vertical
        stackView.spacing = Consts.Layouts.spacing
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return view
    }()
    
    
    // MARK: Initializer
    init(viewModel: any TrendingMoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupUI()
        bind()
        getMovies()
    }
    
    private func getMovies() {
        viewModel.getTrendingMovies()
    }
}

// MARK: - Binding
private extension TrendingMoviesViewController {
    func bind() {
        viewModel.moviesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else { return }
                
                titleLabel.text = movies.isEmpty ? Consts.Strings.noResultsTitle : Consts.Strings.title
                trendingMovies = movies
                tableView.reloadData()
            }
            .store(in: &subscriptions)
        
        searchField.onSearch = { [weak self] searchText in
            guard let self else { return }
            if searchText.isEmpty {
                viewModel.getTrendingMovies()
            } else {
                viewModel.getMoviesByTitle(searchText)
            }
        }
    }
}

// MARK: - UI setups
private extension TrendingMoviesViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupUI() {
        view.addSubview(vStackView)
        view.addSubview(tableView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(Consts.Layouts.horizontalInsent)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(vStackView.snp.bottom).offset(Consts.Layouts.horizontalInsent)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        searchField.snp.makeConstraints { make in
            make.height.equalTo(Consts.Layouts.searchFieldHeight)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TrendingMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trendingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.setContent(title: trendingMovies[indexPath.row].title, year: trendingMovies[indexPath.row].year)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showMovieDetails(by: trendingMovies[indexPath.row].imdbID)
    }
}

// MARK: - Consts
private extension TrendingMoviesViewController {
    enum Consts {
        enum Strings {
            static let title = "Trending Movies"
            static let noResultsTitle = "No Results 😔"
        }
        
        enum Layouts {
            static let horizontalInsent: CGFloat = 20
            static let searchFieldHeight: CGFloat = 50
            static let spacing: CGFloat = 20
        }
    }
}
