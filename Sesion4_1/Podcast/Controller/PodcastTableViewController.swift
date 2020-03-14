//
//  PodcastTableViewController.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 28/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit
import KRProgressHUD

final class PodcastTableViewController: UITableViewController, UISearchBarDelegate {

    private var podcasts: [Podcast]? = nil
    let searchBarController = UISearchController(searchResultsController: nil)
    var presenter: TrackPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        title = "Podcast"
        presenter = TrackPresenter(delegate: self)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBarController.searchBar.delegate = self
        searchBarController.searchBar.tintColor = UIColor.white
        searchBarController.searchBar.barTintColor = UIColor.white
        presenter?.getPodcasts(query: "Apple")
    }

    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: PodcastCell.self)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PodcastCell = tableView.dequeueReusableCell(for: indexPath)
        cell.podcast = podcasts?[indexPath.row]
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let podcast = podcasts?[indexPath.row]
        guard let feedTableView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedTableViewController") as? FeedTableViewController else { return }
        feedTableView.podcast = podcast
        navigationController?.pushViewController(feedTableView, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.getPodcasts(query: searchText)
    }
}

extension PodcastTableViewController: TrackDelegate {
    func startLoading() {
        KRProgressHUD.show()
    }
    
    func endLoading() {
        KRProgressHUD.dismiss()
    }
    
    func getPodcasts(result: Result<PodcastSearch?, APIError>) {
        switch result {
        case .success(let value):
            self.podcasts = value?.results
            self.tableView.reloadData()
        case .failure(let error):
            print(error.customDescription)
        }
    }
}
