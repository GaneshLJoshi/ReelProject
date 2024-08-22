//
//  MyCellCollectionViewCell.swift
//  ReelProject
//
//  Created by Ganesh Joshi on 03/08/24.
//

import UIKit
import AVKit

class MyCell: UICollectionViewCell {
    var imageView: UIImageView!
    var loadingIndicator: UIActivityIndicatorView!
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var videoURL: URL?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // Setup imageView
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        // Setup loadingIndicator
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingIndicator)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func loadThumbnail(from url: String) {
        loadingIndicator.startAnimating()
        
        ImageLoader.shared.loadImage(from: url) { [weak self] result in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                switch result {
                case .success(let image):
                    UIView.transition(with: self?.imageView ?? UIImageView(),
                                      duration: 0.3,
                                      options: .transitionCrossDissolve,
                                      animations: { self?.imageView.image = image },
                                      completion: nil)
                case .failure(let error):
                    print("Failed to load image: \(error)")
                    // Optionally, handle error (e.g., show a placeholder image)
                }
            }
        }
    }
    
    func configure(with reelItem: ReelItem) {
        // Hide image view if video is to be played
        imageView.isHidden = false
        
        // Load thumbnail
        loadThumbnail(from: reelItem.thumbnail)
        
        // Configure video playback
        if let videoURL = URL(string: reelItem.video) {
            self.videoURL = videoURL
            imageView.isHidden = true
            
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = contentView.bounds
            playerLayer?.videoGravity = .resizeAspectFill
            if let playerLayer = playerLayer {
                contentView.layer.addSublayer(playerLayer)
            }
            
            // Setting the video playback rate to 2x
            player?.rate = 2.0
            player?.play()
            
            // Adding an observer to stop the video after 6 seconds
            let duration = CMTime(seconds: 6.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            player?.addBoundaryTimeObserver(forTimes: [NSValue(time: duration)], queue: .main) { [weak self] in
                self?.player?.pause()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Resetting the image view and stopping the player
        imageView.image = nil
        imageView.isHidden = false
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        player = nil
        playerLayer = nil
    }
}


