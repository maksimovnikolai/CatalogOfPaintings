//
//  DetailCollectionViewCell.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 15.02.2024.
//

import UIKit

final class DetailCollectionViewCell: UICollectionViewCell {
    
    // Identifier
    static let identifier = "DetailViewCell"
    
    //MARK: Private Properties
    private lazy var paintingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configure Cell
    func configure(work: Work) {
        paintingImage.image = UIImage(named: work.image)
    }
}

//MARK: - Private Methods
extension DetailCollectionViewCell {
    
    private func commonInit() {
        setupArtistImageConstraints()
    }
}

//MARK: - Constraints
extension DetailCollectionViewCell {
    
    private func setupArtistImageConstraints() {
        addSubview(paintingImage)
        paintingImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paintingImage.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            paintingImage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            paintingImage.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            paintingImage.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
