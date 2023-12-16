//
//  AudioViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 15.12.2023.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController, AudioNoteViewControllerDelegate {
    
    weak var coordinator: Coordinator?
    
    var makeNote: (() -> Void)?
    
    fileprivate let cellAudioReuseIdentifier = "AudioReuse"
    
    private var player: AVAudioPlayer?
    
    static private var audioNotes = [URL]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .lightGray
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addNoteItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddNoteItem))
        navigationItem.rightBarButtonItem = addNoteItem
        setup()
    }
    
    init(title: String){
        super.init(nibName: nil, bundle: nil)
        self.title = title
        view.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellAudioReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        for view in view.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    func addedAudionote(audioFileName: URL) {
        AudioViewController.audioNotes.append(audioFileName)
        tableView.reloadData()
    }
    
    
    @objc func didTapAddNoteItem() {
        print("Did Tap Add Note item")
        makeNote?()
    }

}

extension AudioViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AudioViewController.audioNotes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellAudioReuseIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "play.fill")
        content.text = String(AudioViewController.audioNotes[indexPath.row].lastPathComponent.dropLast(4))
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}

extension AudioViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did tap \(AudioViewController.audioNotes[indexPath.row]) button")
        let audioFilename = AudioViewController.audioNotes[indexPath.row]
        do {
            player = try AVAudioPlayer(contentsOf: audioFilename)
            player?.play()
        } catch {
            let alertController = UIAlertController(title: "Playback failed", message: "There was a problem playing your recording, please try again", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }
    }
}
