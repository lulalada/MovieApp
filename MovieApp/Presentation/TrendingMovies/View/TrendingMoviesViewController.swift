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

final class TrendingMoviesViewController: UIViewController {
    
    // MARK: Properties
    private let viewModel: any TrendingMoviesViewModel
    private var trendingMovies: [BasicMovie] = []
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: Outlets
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
                guard let self = self else { return }
                self.trendingMovies = movies
                self.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
}

// MARK: - UI setups
private extension TrendingMoviesViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
