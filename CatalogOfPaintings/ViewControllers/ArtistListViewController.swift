//
//  ArtistListViewController.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 14.02.2024.
//

import UIKit

final class ArtistListViewController: UIViewController {
    
    //MARK: Private Properties
    private var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var artists: [Artist] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var filteredArtists: [Artist] = []
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

//MARK: - Private Methods
extension ArtistListViewController {
    
    private func commonInit() {
        configureNavBar()
        configureTableView()
        fetchArtists()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Artists"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupSearchController()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)
        tableView.register(ArtistListTableViewCell.self, forCellReuseIdentifier: ArtistListTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 170
    }
    
    private func fetchArtists() {
        do {
            artists = try Bundle.main.parseJSON(with: "artists")
        } catch {
            print("error: \(error)")
        }
    }
}

//MARK: - UISearchResultsUpdating
extension ArtistListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredArtists = artists.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}

//MARK: - Artist Table View Cell Delegate
extension ArtistListViewController: ArtistTableViewCellDelegate {
    
    func buttonDidTap(_ cell: ArtistListTableViewCell, artist: Artist) {
        let biographyVC = BiographyViewController(artist: artist)
        present(biographyVC, animated: true)
    }
}

//MARK: - Table View Data Source
extension ArtistListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredArtists.count : artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistListTableViewCell.identifier, for: indexPath) as? ArtistListTableViewCell else {
            return UITableViewCell()
        }
        
        let artist = isFiltering ? filteredArtists[indexPath.row] : artists[indexPath.row]
        cell.delegate = self
        cell.configure(artist: artist)
        return cell
    }
}

//MARK: - Table View Delegate
extension ArtistListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showArtistPaintings(at: indexPath)
    }
    
    private func showArtistPaintings(at indexPath: IndexPath) {
        let artist = isFiltering ? filteredArtists[indexPath.row] : artists[indexPath.row]
        let detailVC = DetailViewController(artist: artist)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
