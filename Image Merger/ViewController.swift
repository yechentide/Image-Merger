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
    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBOutlet weak var mergeBtn: UIBarButtonItem!
    
    var list = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        list.append(UIImage(named: "add")!)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
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
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        if let cell = cell as? ImageCell {
            cell.setImage(img: list[indexPath.row])
        }
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: \(indexPath.row)")
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        // picker.mediaTypes = ["public.image", "public.movie"]
        self.present(picker, animated: true, completion: nil)
        
    }
    
}



extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 画像が選択された時に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        let indexPaths = collectionView.indexPathsForSelectedItems
        if let indexPath = indexPaths {
            if let selectedImage = info[.originalImage] as? UIImage {
                
                
                if indexPath[0].row==list.count-1 {
                    list.append(UIImage(named: "add")!)
                }
                list[indexPath[0].row] = selectedImage
                collectionView.reloadData()
                
                
            }
        }
        self.dismiss(animated: true)  //画像をImageViewに表示したらアルバムを閉じる
    }
    
    // 画像選択がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
