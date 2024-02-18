//
//  DetailViewController.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 15.02.2024.
//

import UIKit


final class DetailViewController: UIViewController {
    
    typealias Datasource = UICollectionViewDiffableDataSource<Section, Work>
    
    //MARK: Private Properties
    private var artist: Artist
    private var dataSource: Datasource! = nil
    private var collectionView: UICollectionView!
    
    enum Section {
        case printings
    }
    
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
extension DetailViewController {
    
    private func commonInit() {
        view.backgroundColor = .systemBackground
        title = "Paintings"
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        view.addSubview(collectionView)
    }
}

//MARK: - Layout & Data Source
extension DetailViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/2),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Work>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(work: item)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Work>()
        snapshot.appendSections([.printings])
        snapshot.appendItems(artist.works)
        dataSource.apply(snapshot)
    }
}

//MARK: - UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        let work = snapshot.itemIdentifiers[indexPath.item]
        let newView = DetailZoomView(with: work)
        setupGesture(to: newView)
    }
    
    private func setupGesture(to zoomView: UIView) {
        zoomView.frame = UIScreen.main.bounds
        zoomView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullScreenRecognizer))
        zoomView.addGestureRecognizer(tap)
        view.addSubview(zoomView)
        collectionView.isHidden = true
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc
    private func dismissFullScreenRecognizer(_ sender: UITapGestureRecognizer) {
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        collectionView.isHidden = false
        sender.view?.removeFromSuperview()
    }
}
