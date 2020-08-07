//
//  ViewController.swift
//  Image Merger
//
//  Created by yechen on 2020/08/07.
//  Copyright © 2020 Polarnight. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        collectionView.dataSource = self
        
        let w = UIScreen.main.bounds.width
        let l = (w-24-24-30)/2
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: l, height: l)
        layout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 30
        collectionView.collectionViewLayout = layout
    }

    

}



extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        if let cell = cell as? ImageCell {
            cell.setup(img: UIImage(named: "add")!)
        }
        
        return cell
    }
    
    
}
