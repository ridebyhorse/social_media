//
//  ProfileViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func didTapAvatar()
    func didCloseAvatar()
}

class ProfileViewController: UIViewController, ProfileHeaderViewDelegate {
    
   private let photos: [UIImage] = {
        var photos = [UIImage]()
        for i in 1...20 {
            if let image = UIImage(named: "\(i)") {
                photos.append(image)
            }
        }
        
        return photos
    }()
    
    private var posts: [Post] = [
        
        Post(author: "Live Science",
             description: "Ask anyone what the fastest animal on Earth is, and they'll probably say the cheetah. But the focus on the speedy feline has stolen attention from other species that go much faster — some three or more times faster than the cheetah. Who are the overlooked speedsters of the animal kingdom?",
             imageName: "Cheetah",
             likesCount: 402,
             viewsCount: 12967
        ),
        
        Post(author: "BBC News",
             description: "'This isn’t a prison,' a nun in the new BBC drama The Woman in the Wall says. 'You can leave anytime you want. But where would you go? Who would have you? No one wants you. You’re a sinner.'",
             imageName: "WomanInTheWall",
             likesCount: 1146,
             viewsCount: 18712
        ),
        
        Post(author: "Magazine Design",
             description: "Editorial Design and in particular magazines always fascinated me. There are a lot of things you need to learn to be good at designing contemporary, stylish magazine spreads.",
             imageName: "MagDesign",
             likesCount: 210,
             viewsCount: 438
        ),
        
        Post(author: "The Conversation",
             description: "An enthusiastic, sellout crowd arrived at Melbourne’s Hamer Hall in September to hear an evening of music from Orchestra Victoria. The program consisted largely of Australian music and premiere performances. If the sight of over 2,500 filled seats (filled, anecdotally, by those much younger than the typical orchestra audience) did not indicate how deeply this music was loved, then the standing ovation at the end of the night would leave no-one in doubt.",
             imageName: "Gamer",
             likesCount: 1498,
             viewsCount: 9083
        )
    ]
    
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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemGray6
        
        setupViews()

    }
    
    private func setupViews() {
        
        view.addSubview(tableView)
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.profilePost.rawValue)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.profilePhoto.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
        
        let header = ProfileHeaderView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 200)))
        header.delegate = self
        header.backgroundColor = .lightGray
        tableView.tableHeaderView = header
        tableView.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        
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
            postCell.update(author: postData.author, namePicForPost: postData.imageName, text: postData.description, likesCount: postData.likesCount, viewsCount: postData.viewsCount)
            
            return postCell
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photosViewController = PhotosViewController(photosCount: photos.count, photosToPresent: photos)
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
}
