//
//  ArtistViewController.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 14.02.2024.
//

import UIKit

final class ArtistViewController: UIViewController {
    
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
extension ArtistViewController {
    
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
        tableView.register(ArtistTableViewCell.self, forCellReuseIdentifier: ArtistTableViewCell.identifier)
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

//MARK: - Table View Data Source
extension ArtistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier, for: indexPath) as? ArtistTableViewCell else {
            return UITableViewCell()
        }
        
        let artist = artists[indexPath.row]
        cell.configure(artist: artist)
                
        return cell
    }
}


//MARK: - Table View Delegate
extension ArtistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
