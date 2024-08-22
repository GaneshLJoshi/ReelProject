//
//  ViewController.swift
//  ReelProject
//
//  Created by Ganesh Joshi on 03/08/24.
//

import UIKit

/*class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var collectionView: UICollectionView!
    private let viewModel = VideoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 400)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.identifier)
        
        view.addSubview(collectionView)
        
        viewModel.loadReels()
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.reels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.identifier, for: indexPath) as! MyCell
        let reel = viewModel.reels[indexPath.section]
        cell.configure(with: reel.videos)
        return cell
    }
}
*/

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UICollectionViewDataSourcePrefetching {
    
    private let numberOfItemsInRow: CGFloat = 2
    private let minimumSpacing: CGFloat = 0.2
    private let edgeInsetPadding: CGFloat = 0.2
    
    @IBOutlet var collectionView: UICollectionView!
    
    var reelItems: [ReelItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchReelData()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.backgroundColor = .lightGray
    }
    
    func fetchReels(completion: @escaping (Result<[ReelItem], Error>) -> Void) {
        do {
            let decoder = JSONDecoder()
            let reelResponse = try decoder.decode(ReelResponse.self, from: jsonData)
            reelItems = reelResponse.reels.flatMap { $0.arr }
            print(reelItems)
            completion(.success(reelItems))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchReelData() {
        fetchReels { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self?.reelItems = items
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print("Failed to fetch reels: \(error)")
                }
            }
        }
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reelItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        let reelItem = reelItems[indexPath.item]
        cell.configure(with: reelItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: edgeInsetPadding, left: edgeInsetPadding, bottom: edgeInsetPadding, right: edgeInsetPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = minimumSpacing * (numberOfItemsInRow - 1) + edgeInsetPadding * 2
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsInRow
        return CGSize(width: width, height: width) // Cells are square
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
            for indexPath in indexPaths {
                let reelItem = reelItems[indexPath.item]
                ImageLoader.shared.loadImage(from: reelItem.thumbnail) { _ in }
            }
        }
}




