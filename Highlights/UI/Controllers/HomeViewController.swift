//
//  HomeViewController.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 29/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        self.view.backgroundColor = .testColor
        // Do any additional setup after loading the view.

    }

    // MARK: Methods
    
}

// MARK: CollectionView extension
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SearchResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        25
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath)
    }
    
    
}
