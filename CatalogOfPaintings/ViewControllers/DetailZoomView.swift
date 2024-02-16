//
//  DetailZoomView.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 16.02.2024.
//

import UIKit

final class DetailZoomView: UIView {
    
    //MARK: Private Properties
    private lazy var paintingImageView = makeImageView()
    private lazy var titleLabel = makeLabelWith(text: "Name", font: .boldSystemFont(ofSize: 22), alignment: .center)
    private lazy var infoLabel = makeLabelWith(text: "Info", font: .systemFont(ofSize: 18))
    private lazy var stackView = makeStackView()
    
    //MARK: - Init
    init(image: UIImage, title: String, info: String) {
        super.init(frame: .zero)
        self.paintingImageView.image = image
        self.titleLabel.text = title
        self.infoLabel.text = info
        setupStackViewConstraints()
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
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(paintingImageView)
        stackView.addArrangedSubview(infoLabel)
        return stackView
    }
}

//MARK: - Constraints
extension DetailZoomView {
    
    private func setupStackViewConstraints() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        ])
    }
}
