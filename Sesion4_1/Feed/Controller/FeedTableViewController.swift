//
//  FeedTableViewController.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 07/03/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit
import FeedKit
import KRProgressHUD

final class FeedTableViewController: UITableViewController {
    var podcast: Podcast?
    var presenter: FeedPresenter?
    var feed: Feed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = podcast?.artistName
        setupTableView()
        presenter = FeedPresenter(delegate: self)
        guard let podcast = podcast else { return }
        presenter?.getFeed(podcast.feedUrl)
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: FeedCell.self)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed?.rssFeed?.items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedCell = tableView.dequeueReusableCell(for: indexPath)
        let item = feed?.rssFeed?.items?[indexPath.row]
        cell.value = FeedData(podcast, item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let feedTableView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemViewController") as? ItemViewController else { return }
        feedTableView.feed = feed
        feedTableView.podcast = podcast
        feedTableView.currentIndex = indexPath.row
        let navController = UINavigationController(rootViewController: feedTableView)
        present(navController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FeedTableViewController: FeedDelegate {
    func startLoading() {
        KRProgressHUD.show()
    }
    
    func endLoading() {
        KRProgressHUD.dismiss()
    }
    
    func getFeed(result: Result<Feed, ParserError>) {
        switch result {
        case .success(let value):
            self.feed = value
            self.tableView.reloadData()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
