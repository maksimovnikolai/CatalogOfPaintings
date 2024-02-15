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
    
    private var artists: [Artist] = [] {
        didSet {
            tableView.reloadData()
        }
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
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(ArtistListCell.self, forCellReuseIdentifier: ArtistListCell.identifier)
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

//MARK: - Artist Table View Cell Delegate
extension ArtistListViewController: ArtistTableViewCellDelegate {
    
    func buttonDidTap(_ cell: ArtistListCell, artist: Artist) {
        let biographyVC = BiographyViewController(artist: artist)
        present(biographyVC, animated: true)
    }
}

//MARK: - Table View Data Source
extension ArtistListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistListCell.identifier, for: indexPath) as? ArtistListCell else {
            return UITableViewCell()
        }
        
        let artist = artists[indexPath.row]
        cell.delegate = self
        cell.configure(artist: artist)
        return cell
    }
}

//MARK: - Table View Delegate
extension ArtistListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
