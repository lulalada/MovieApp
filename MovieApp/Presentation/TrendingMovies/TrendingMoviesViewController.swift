//
//  TrendingMoviesViewController.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 17/10/2024.
//

import UIKit
import Combine
import Factory

class TrendingMoviesViewController: UIViewController {
    
    @LazyInjected(\.trendingMoviesContainer.trendingMoviesUseCase)
    var trendingMoviesUseCase: TrendingMoviesUseCase
    
    private(set) var subscriptions: Set<AnyCancellable> = []
    
    // MARK: Outlets
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    // MARK: Lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupTableView()
        getMovies()
        // Do any additional setup after loading the view.
    }
    
    private func getMovies() {
        let request = TrendingMoviesRequest(page: 1)
        trendingMoviesUseCase
            .execute(request: request)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished: break
                case .failure:
                    print("failure")
                }
            } receiveValue: { response in
                print(response, "response frpm vc")
            }
            .store(in: &subscriptions)
    }

}

// MARK: - Private methods
private extension TrendingMoviesViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate
extension TrendingMoviesViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDelegate
extension TrendingMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
