//
//  ProfileViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 12.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
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
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.profilePost.rawValue,for: indexPath) as! PostTableViewCell
        
        let data = posts[indexPath.row]
        cell.update(author: data.author, namePicForPost: data.imageName, text: data.description, likesCount: data.likesCount, viewsCount: data.viewsCount)
        
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProfileHeaderView()
        header.backgroundColor = .systemGray6
        return header
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        200
    }
}
