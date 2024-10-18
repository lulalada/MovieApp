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
    private lazy var searchField = SearchTextField()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        view.addSubview(searchField)
        view.addSubview(tableView)
        
        searchField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TrendingMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trendingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = trendingMovies[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showMovieDetails(by: trendingMovies[indexPath.row].imdbID)
    }
}
