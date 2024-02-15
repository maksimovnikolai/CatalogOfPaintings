//
//  ArtistListCell.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 14.02.2024.
//

import UIKit

protocol ArtistTableViewCellDelegate: AnyObject {
    func buttonDidTap(_ cell: ArtistListCell, artist: Artist)
}

final class ArtistListCell: UITableViewCell {
    
    // Identifier
    static let identifier = "ArtistTableViewCell"
    
    // Delegate
    weak var delegate: ArtistTableViewCellDelegate?
    
    //MARK: Private Properties
    private var currentArtist: Artist!
    
    private lazy var artistImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .justified
        label.setContentCompressionResistancePriority(.init(rawValue: 999), for: .vertical)
        return label
    }()
    
    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private var biographyButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.title = "read all"
        return button
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
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
        currentArtist = artist
        artistImage.image = UIImage(named: artist.image)
        nameLabel.text = artist.name
        biographyLabel.text = artist.bio
    }
}

//MARK: - Private Methods
extension ArtistListCell {
    
    private func commonInit() {
        setupArtistImageConstraints()
        setupStackViewConstraints()
        setupBiographyButtonConstraints()
        addTarget()
    }
    
    private func addTarget() {
        biographyButton.addTarget(self, action: #selector(showBiography), for: .touchUpInside)
    }
    
    @objc
    private func showBiography() {
        delegate?.buttonDidTap(self, artist: currentArtist)
    }
}

//MARK: - Constraints
extension ArtistListCell {
    
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
    
    private func setupStackViewConstraints() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(biographyLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: artistImage.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25)
        ])
    }
    
    private func setupBiographyButtonConstraints() {
        contentView.addSubview(biographyButton)
        biographyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            biographyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            biographyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
        ])
    }
}
