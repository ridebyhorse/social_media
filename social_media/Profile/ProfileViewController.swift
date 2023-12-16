//
//  ProfileViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import UIKit
import StorageService
import iOSIntPackage

protocol ProfileHeaderViewDelegate: AnyObject {
    func didTapAvatar()
    func didCloseAvatar()
}

protocol ProfileViewOutput {
    var onNewDataInput: (() -> Void)? { get }
}

class ProfileViewController: UIViewController, ProfileHeaderViewDelegate {
    
    weak var coordinator: Coordinator?
    
    private var viewModel: ProfileViewModel

    private var user: User?
    
    private var photos = [UIImage]()
    
    private var posts = [Post]()
    
    private var timer: Timer?
    
    private var startedTimeOnline: Date
    
    fileprivate enum CellReuseIdentifiers: String {
        case profilePost = "ProfilePostReuse"
        case profilePhoto = "ProfilePhotoReuse"
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        startedTimeOnline = .now
        super.init(nibName: nil, bundle: nil)
        
        timer = Timer(timeInterval: 5.0, target: self, selector: #selector(updateTimeInHeader), userInfo: nil, repeats: true)
        guard let timer else { return }
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        guard let timer else { return }
        timer.invalidate()
        print("Timer \(timer) invalidated")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemGray6
        
        configure()
        setupViews()

    }
    
    private func configure() {
        
        for name in viewModel.photoData {
            if let image = UIImage(named: name) {
                photos.append(image)
            }
        }
        
        posts = viewModel.posts
        if let userInput = viewModel.user {
            user = userInput
        }
        
        viewModel.onNewDataInput = {
            self.tableView.reloadData()
            print("Did update UI with new data")
        }
        
    }
    
    private func setupViews() {
        
        view.addSubview(tableView)
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.profilePost.rawValue)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.profilePhoto.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
        if let user {
            let header = ProfileHeaderView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 200)), user: user)
            header.delegate = self
            header.backgroundColor = .lightGray
            tableView.tableHeaderView = header
            tableView.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        if let header = tableView.tableHeaderView {
            NSLayoutConstraint.activate([
               
                header.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
                header.heightAnchor.constraint(equalToConstant: 200)
            ])
        }
        
        NSLayoutConstraint.activate([
           
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func updateTimeInHeader() {

        if let header = tableView.tableHeaderView {
            if let head = header as? ProfileHeaderView {
                let timePassed = Date.now.timeIntervalSince(startedTimeOnline)
                head.updateTime(time: Int(timePassed))
            }
        }
        
    }
    
    func didTapAvatar() {
        print("Did tap avatar in Header")
        for constraint in tableView.tableHeaderView!.constraints {
            guard constraint.firstAnchor == tableView.tableHeaderView!.heightAnchor else { continue }
            constraint.isActive = false
            
            break
        }
        
        tableView.tableHeaderView?.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        view.layoutIfNeeded()
        tableView.isScrollEnabled = false
        
      
    }
    
    func didCloseAvatar() {
        print("Did tap close button in Avatar close up View")
        for constraint in view.constraints {
            guard constraint.firstAnchor == tableView.tableHeaderView!.heightAnchor else { continue }
            constraint.isActive = false
            
            break
        }
        tableView.tableHeaderView?.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.layoutIfNeeded()
        tableView.isScrollEnabled = true
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return posts.count
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let photoCell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.profilePhoto.rawValue, for: indexPath) as! PhotosTableViewCell
            
            let photoData = Array(photos.dropLast(6))
            photoCell.update(photos: photoData)
            
            return photoCell
        } else {
            let postCell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.profilePost.rawValue,for: indexPath) as! PostTableViewCell
            
            let postData = posts[indexPath.row]
            let filter = ColorFilter.allCases[Int.random(in: 0..<ColorFilter.allCases.count)]
            postCell.update(author: postData.author, namePicForPost: postData.imageName, text: postData.description, likesCount: postData.likesCount, viewsCount: postData.viewsCount, filter: filter)
            
            return postCell
        }
    }
    
    
}

extension ProfileViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photosViewController = PhotosViewController(photosToPresent: photos)
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
}
