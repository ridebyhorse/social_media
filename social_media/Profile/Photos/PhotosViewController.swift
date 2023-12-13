//
//  PhotosViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 23.10.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    private var imageProcessor: ImageProcessor
    
    private var photosToPresent = [UIImage]()
    
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
        imageProcessor = ImageProcessor()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"

        setupViews()
        applyFilters()
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
    
    private func applyFilters() {
        let date: Date = .now
        imageProcessor.processImagesOnThread(sourceImages: photosToPresent, filter: .colorInvert, qos: .background) { filteredPhotos in
            
            self.photosToPresent.removeAll()
            for photo in filteredPhotos {
                guard let photo else { return }
                self.photosToPresent.append(UIImage(cgImage: photo))
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                }
            }
            
            print("Filter applying took \(-1 * Int(date.timeIntervalSinceNow)) seconds")
        }
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
        return photosToPresent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifiers.photoCollection.rawValue,for: indexPath) as! PhotosCollectionViewCell
        
        cell.update(image: photosToPresent[indexPath.row])
        
        return cell
    }
    
    
}
