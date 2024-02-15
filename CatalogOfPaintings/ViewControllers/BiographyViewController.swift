//
//  BiographyViewController.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 15.02.2024.
//

import UIKit

final class BiographyViewController: UIViewController {
    
    //MARK: - Private Properties
    private var artist: Artist
    
    private let navigationBar = UINavigationBar()
    
    private var artistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: Init
    init(artist: Artist) {
        self.artist = artist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

//MARK: - Private Methods
extension BiographyViewController {
    
    private func commonInit() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        setupNavigationBarConstraints()
        setupNameLabelConstraints()
        setupImageConstraints()
        setupBiographyLabelConstraints()
        updateUI()
    }
    
    private func updateUI() {
        nameLabel.text = artist.name
        artistImageView.image = UIImage(named: artist.image)
        biographyLabel.text = artist.bio
    }
    
    private func configureNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissVC))
        
        let navigationItem = UINavigationItem(title: "Biography")
        navigationItem.leftBarButtonItem = cancelButton
        navigationBar.items = [navigationItem]
    }
    
    @objc
    private func dismissVC() {
        dismiss(animated: true)
    }
}


//MARK: - Constraints
extension BiographyViewController {
    
    private func setupNavigationBarConstraints() {
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupNameLabelConstraints() {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupImageConstraints() {
        view.addSubview(artistImageView)
        artistImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            artistImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            artistImageView.heightAnchor.constraint(equalToConstant:  (UIScreen.main.bounds.height / 2) - 60)
        ])
    }
    
    private func setupBiographyLabelConstraints() {
        view.addSubview(biographyLabel)
        biographyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            biographyLabel.topAnchor.constraint(equalTo: artistImageView.bottomAnchor, constant: 20),
            biographyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            biographyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
