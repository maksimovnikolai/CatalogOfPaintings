//
//  NewArtistViewController.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 17.02.2024.
//

import UIKit

final class NewArtistViewController: UIViewController {
    
    //MARK: - Private Properties
    private lazy var artistImageView = makeArtistImageView()
    private lazy var nameTF = makeTextField(phText: "Enter name")
    private lazy var bioTF = makeTextField(phText: "Biography")
    private lazy var nameLabel = makeLabel(withTitle: "Artist name:")
    private lazy var bioTitleLabel = makeLabel(withTitle: "Biography")
    private lazy var textView = makeTextView()
    private lazy var stackView = makeStackView()
    private lazy var customView = makeView()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        commonInit()
    }
}

//MARK: - Private Methods
extension NewArtistViewController {
    
    private func commonInit() {
        setupArtistImageConstraints()
        setupCustomConstraints()
        setupStackViewConstraints()
    }
}

//MARK: - Constraints
extension NewArtistViewController {
    
    private func setupArtistImageConstraints() {
        view.addSubview(artistImageView)
        let imageSize: CGFloat = UIScreen.main.bounds.size.width / 1.5
        artistImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            artistImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            artistImageView.widthAnchor.constraint(equalToConstant: imageSize),
            artistImageView.heightAnchor.constraint(equalToConstant: imageSize),
        ])
    }
    
    private func setupCustomConstraints() {
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: artistImageView.bottomAnchor, constant: 30),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupStackViewConstraints() {
        customView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - UI elements
extension NewArtistViewController {
    
    private func makeTextField(phText: String) -> UITextField {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = phText
        return tf
    }
    
    private func makeArtistImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = .init(systemName: "person.crop.circle.badge.plus")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        return imageView
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        bioTitleLabel.text = "Biography:"
        [nameLabel, nameTF, bioTitleLabel, textView].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }
    
    private func makeTextView() -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .systemGray

        textView.layer.cornerRadius = 5
        textView.font = .systemFont(ofSize: 16)
        return textView
    }
    
    private func makeView() -> UIView {
        let view = UIView()
        view.backgroundColor = .cyan
        view.layer.cornerRadius = 30
        return view
    }
    
    private func makeLabel(withTitle text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }
}
