//
//  DetailZoomView.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 16.02.2024.
//

import UIKit

final class DetailZoomView: UIScrollView {

    //MARK: Private Properties
    private lazy var paintingImageView = makeImageView()
    private lazy var titleLabel = makeLabelWith(text: "Name", font: .boldSystemFont(ofSize: 22), alignment: .center)
    private lazy var infoLabel = makeLabelWith(text: "Info", font: .systemFont(ofSize: 18))
    private lazy var stackView = makeStackView()
    private lazy var contentView = makeContentView()

    //MARK: - Init
    init(with work: Work) {
        super.init(frame: .zero)
        self.paintingImageView.image = UIImage(named: work.image)
        self.titleLabel.text = work.title
        self.infoLabel.text = work.info
        
        setupContentViewConstraints()
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
        stackView.spacing = 5
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(paintingImageView)
        stackView.addArrangedSubview(infoLabel)
        return stackView
    }

    private func makeContentView() -> UIView {
        let view = UIView()
        return view
    }
}

//MARK: - Constraints
extension DetailZoomView {
    
    private func setupContentViewConstraints() {
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

    private func setupStackViewConstraints() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
