//
//  ArtistTableViewCell.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 14.02.2024.
//

import UIKit

final class ArtistTableViewCell: UITableViewCell {
    
    // Identifier
    static let identifier = "ArtistTableViewCell"

    //MARK: Private Properties
    private lazy var artistImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var biographyLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.6
        return label
    }()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configure Cell
    func configure(artist: Artist) {
        artistImage.image = UIImage(named: artist.image)
        nameLabel.text = artist.name
        biographyLabel.text = artist.bio
    }
}

//MARK: - Common Init
extension ArtistTableViewCell {
    
    private func commonInit() {
        setupArtistImageConstraints()
        setupNameLabelConstraints()
        setupBiographyLabelConstraints()
    }
}

//MARK: - Constraints
extension ArtistTableViewCell {
    
    private func setupArtistImageConstraints() {
        contentView.addSubview(artistImage)
        artistImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistImage.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            artistImage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            artistImage.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            artistImage.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setupNameLabelConstraints() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: artistImage.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func setupBiographyLabelConstraints() {
        contentView.addSubview(biographyLabel)
        biographyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            biographyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            biographyLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            biographyLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            biographyLabel.bottomAnchor.constraint(equalTo: artistImage.bottomAnchor),
        ])
    }
}
