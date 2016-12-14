//
//  SourceCollectionViewController.swift
//  UppermostNews
//
//  Created by Cris on 12/4/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SourceNews"

class SourceCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var sources = [NewsSources]()
    var logos = [UIImage]()
    
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIColors()
        APICall()
    }
    
    func setUIColors() {
        collectionView?.backgroundColor = UIColor(displayP3Red: 247/255, green: 235/255, blue: 216/255, alpha: 1)
        self.navigationController?.navigationBar.backgroundColor = UIColor(displayP3Red: 255/255, green: 165/255, blue: 79/255, alpha: 1)
    }
    
    func APICall() {
        APIManager.shared.getSources(from: "https://newsapi.org/v1/sources?language=en") { (newsSources: [NewsSources]?) in
            if let sources = newsSources {
                self.sources = sources
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sources.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let logoCell = cell as? LogoCollectionViewCell {
            
            let source = sources[indexPath.row]
            let urlString = source.sourceLogo
            GetImage.shared.getImage(urlString: urlString) { (image : UIImage?) in
                if let sourceLogo = image {
                    logoCell.logoImageView.image = sourceLogo
                    self.logos.append(sourceLogo)
                }
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let temp = sources[sourceIndexPath.row]
        sources.remove(at: sourceIndexPath.row)
        sources.insert(temp, at: destinationIndexPath.row)
    }
    
    // margin around the whole section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selected = sender as? UICollectionViewCell,
            let indexPath = collectionView?.indexPath(for: selected),
            let dest = segue.destination as? ArticlesViewController {
            dest.articleDetails = sources[indexPath.row]
        }
    }
    
}
