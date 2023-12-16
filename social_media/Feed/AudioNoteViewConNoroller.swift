//
//  AudioNoteViewController.swift
//  social_media
//
//  Created by Мария Нестерова on 15.12.2023.
//

import UIKit
import AVFoundation

protocol AudioNoteViewControllerDelegate {
    func addedAudionote(audioFileName: URL)
}

class AudioNoteViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    private static var recordings = [URL]()
    
    var delegate: AudioNoteViewControllerDelegate?
    
    var onComplete: (() -> Void)?
    
    private lazy var recordingSession: AVAudioSession = {
        let recordingSession = AVAudioSession.sharedInstance()
        
        return recordingSession
    }()
    
    private var recorder: AVAudioRecorder?
    
    private var player: AVAudioPlayer?
    
    private lazy var recordLabel: UILabel = {
        let recordLabel = UILabel()
        recordLabel.text = "New audionote:"
        recordLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        
        return recordLabel
    }()
    
    private lazy var playButton: UIButton = {
        let playButton = UIButton()
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.contentVerticalAlignment = .fill
        playButton.contentHorizontalAlignment = .fill
        playButton.tintColor = .white
        playButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        playButton.isHidden = true
        
        return playButton
    }()
    
    private lazy var saveButton: CustomButton = {
        let saveButton = CustomButton(title: "Save and close", color: .white, titleColor: .darkGray)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        saveButton.isHidden = true
        
        return saveButton
    }()
    
    private lazy var recordBackground: UIView = {
        let recordBackground = UIView()
        recordBackground.backgroundColor = .red
        recordBackground.isHidden = true
        
        return recordBackground
    }()
    
    private lazy var recordButton: UIButton = {
        let recordButton = UIButton()
        recordButton.setImage(UIImage(systemName: "record.circle.fill"), for: .normal)
        recordButton.contentVerticalAlignment = .fill
        recordButton.contentHorizontalAlignment = .fill
        recordButton.tintColor = .white
        recordButton.addTarget(self, action: #selector(didTapRecordButton), for: .touchUpInside)
        
        return recordButton
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .darkGray
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.setup()
                    } else {
                        self.showFailAlert()
                    }
                }
            }
        } catch {
            self.showFailAlert()
        }
    }
    
    private func setup() {
        view.addSubview(recordLabel)
        view.addSubview(playButton)
        view.addSubview(saveButton)
        view.addSubview(recordBackground)
        view.addSubview(recordButton)
        
        for view in view.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            recordLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            recordLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playButton.centerXAnchor.constraint(equalTo: recordLabel.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.widthAnchor.constraint(equalTo: playButton.heightAnchor, multiplier: 0.8),
            playButton.topAnchor.constraint(equalTo: recordLabel.bottomAnchor, constant: 32),
            recordButton.heightAnchor.constraint(equalToConstant: 100),
            recordButton.widthAnchor.constraint(equalTo: recordButton.heightAnchor),
            recordButton.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
            recordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            recordBackground.centerXAnchor.constraint(equalTo: recordButton.centerXAnchor),
            recordBackground.centerYAnchor.constraint(equalTo: recordButton.centerYAnchor),
            recordBackground.heightAnchor.constraint(equalTo: recordButton.heightAnchor, multiplier: 0.5),
            recordBackground.widthAnchor.constraint(equalTo: recordButton.widthAnchor, multiplier: 0.5),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            saveButton.centerXAnchor.constraint(equalTo: recordButton.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: recordButton.topAnchor, constant: -32)
        ])
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }

    private func getRecordingURL() -> URL {
        let fileName = getDocumentsDirectory().appendingPathComponent("recording\(AudioNoteViewController.recordings.count).m4a")
        AudioNoteViewController.recordings.append(fileName)
        return fileName
    }
    
    private func showFailAlert() {
        let alertController = UIAlertController(title: "Something went wrong", message: "Please, check you microphone permission and try again", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.onComplete?()
        })
        present(alertController, animated: true)
    }
    
    private func startRecording() {
        
        playButton.isHidden = true
        saveButton.isHidden = true
        recordBackground.isHidden = false
        recordButton.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)

        let audioURL = getRecordingURL()
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            recorder = try AVAudioRecorder(url: audioURL, settings: settings)
            recorder?.delegate = self
            recorder?.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    private func finishRecording(success: Bool) {
        
        recordBackground.isHidden = true
        
        
        recorder?.stop()
        recorder = nil

        if success {
            recordButton.setImage(UIImage(systemName: "repeat.circle.fill"), for: .normal)
            playButton.isHidden = false
            saveButton.isHidden = false
        } else {
            recordButton.setImage(UIImage(systemName: "record.circle.fill"), for: .normal)
            let alertController = UIAlertController(title: "Record failed", message: "There was a problem with recording. Please, try again", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }
    }
    
    @objc private func didTapSaveButton(_ sender: UIButton) {
        print("Did tap Save button")
        guard let fileName = AudioNoteViewController.recordings.last else { return }
        delegate?.addedAudionote(audioFileName: fileName)
        onComplete?()
    }
    
    @objc private func didTapPlayButton(_ sender: CustomButton) {
        print("Did tap Play button")
        guard let audioURL = AudioNoteViewController.recordings.last else { return }
            do {
                player = try AVAudioPlayer(contentsOf: audioURL)
                player?.play()
            } catch {
                let alertController = UIAlertController(title: "Playback failed", message: "There was a problem with playing your recording. Please, try again", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                present(alertController, animated: true)
            }
    }
    
    @objc private func didTapRecordButton(_ sender: UIButton) {
        print("Did tap Record button")
        if recorder == nil {
                startRecording()
            } else {
                finishRecording(success: true)
            }
    }
}

extension AudioNoteViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
