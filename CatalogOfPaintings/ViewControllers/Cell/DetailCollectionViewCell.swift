//
//  DetailCollectionViewCell.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 15.02.2024.
//

import UIKit

protocol DetailCollectionViewCellDelegate: AnyObject {
    func setupTapGesture(_ cell: DetailCollectionViewCell, gesture: UITapGestureRecognizer, to imageView: UIImageView)
}

final class DetailCollectionViewCell: UICollectionViewCell {
    
    // Identifier
    static let identifier = "DetailViewCell"
    
    weak var delegate: DetailCollectionViewCellDelegate?
    
    //MARK: Private Properties
    private var work: Work!
    
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
        self.work = work
        paintingImage.image = UIImage(named: work.image)
    }
}

//MARK: - Private Methods
extension DetailCollectionViewCell {
    
    private func commonInit() {
        setupArtistImageConstraints()
        tapImage()
    }
}

//MARK: - Constraints
extension DetailCollectionViewCell {
    
    private func setupArtistImageConstraints() {
        contentView.addSubview(paintingImage)
        paintingImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paintingImage.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            paintingImage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            paintingImage.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            paintingImage.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }
}

//MARK: - UITapGestureRecognizer
extension DetailCollectionViewCell {
    
    private func tapImage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        paintingImage.addGestureRecognizer(tapGesture)
        paintingImage.isUserInteractionEnabled = true
    }
    
    @objc
    private func imageTapped(_ sender: UITapGestureRecognizer) {
        delegate?.setupTapGesture(self, gesture: sender, to: paintingImage)
    }
}
