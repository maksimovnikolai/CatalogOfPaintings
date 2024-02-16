//
//  DetailZoomView.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 16.02.2024.
//

import UIKit

final class DetailZoomView: UIScrollView {
    
    //MARK: Private Properties
    private lazy var paintingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var titleLabel = makeLabelWith(text: "Name", font: .boldSystemFont(ofSize: 22), alignment: .center)
    private lazy var infoLabel = makeLabelWith(text: "Info", font: .systemFont(ofSize: 18))
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        //        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 80
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(paintingImageView)
        stackView.addArrangedSubview(infoLabel)
        return stackView
    }()
    
    private lazy var contentView = UIView()

    
    //MARK: - Init
    init(image: UIImage, title: String, info: String) {
        super.init(frame: .zero)
        self.paintingImageView.image = image
        self.titleLabel.text = title
        self.infoLabel.text = info
        
        setupContentView()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private Methods
extension DetailZoomView {
    
    private func makeLabelWith(text: String, font: UIFont, alignment: NSTextAlignment? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textAlignment = alignment ?? .left
        label.numberOfLines = 0
        return label
    }
    
    private func setupContentView() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    private func configureStackView() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
