//
//  PhotosViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 23.10.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private var imagePublisher: ImagePublisherFacade
    
    private var photosToPresent = [UIImage]()
    private var imagesFromPublisher = [UIImage]()
    
    fileprivate enum CellReuseIdentifiers: String {
        case photoCollection = "PhotoCollectionReuse"
    }
    
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    init(photosToPresent: [UIImage]) {
        self.photosToPresent = photosToPresent
        imagePublisher = ImagePublisherFacade()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"
        imagePublisher.subscribe(self)
        print("Subscribe to Image Publisher")
        imagePublisher.addImagesWithTimer(time: 0.5, repeat: photosToPresent.count, userImages: photosToPresent)

        setupViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifiers.photoCollection.rawValue)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.safeAreaLayoutGuide.layoutFrame.size.width - 32) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    
    
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesFromPublisher.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifiers.photoCollection.rawValue,for: indexPath) as! PhotosCollectionViewCell
        
        let photoData = imagesFromPublisher[indexPath.row]
        cell.update(image: photoData)
        
        return cell
    }
    
    
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        imagesFromPublisher = images
        collectionView.reloadData()
        if imagesFromPublisher.count == photosToPresent.count {
            imagePublisher.removeSubscription(for: self)
            print("Unsubscribe from Image Publisher")
        }
    }
    
    
}
