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
    var isEditMode = false {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        list.append(UIImage(named: "add")!)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        // set reuse identifier of custom cell
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
        // set collectionView's layout
        let w = UIScreen.main.bounds.width
        let l = (w-24-24-30)/2          // width - left - right - minimumInteritemSpacing
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: l, height: l)
        layout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 30
        collectionView.collectionViewLayout = layout
        
        
        // collectionView.allowsMultipleSelection = true
        editBtn.target = self
        editBtn.action = #selector(editAAA(_:))
    }

    @objc func editAAA(_ sender: UIBarButtonItem) {
        
        self.isEditMode = !self.isEditMode
        print("editMode = \(isEditMode)")
        /*let title = self.isEditMode ? "完了" : "編集"
        sender.title = title*/
    }

}


/* Data Source */
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        if let cell = cell as? ImageCell {
            cell.setImage(img: list[indexPath.row])
        }
        
        if self.isEditMode {
            cell.startVibrateAnimation(range: 3.0)
        } else {
            cell.stopVibrateAnimation()
        }
        
        return cell
    }
    
}

/* Delegate */
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

/* Image Picker */
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



/* Edit mode animation */
extension UIView {
    /**
     震えるアニメーションを再生します
     https://kikuragechan.com/swift/vibration-collection-view
     - parameters:
        - range: 震える振れ幅
        - speed: 震える速さ
        - isSync: 複数対象とする場合,同時にアニメーションするかどうか
     */
    func startVibrateAnimation(range: Double = 2.0, speed: Double = 0.15, isSync: Bool = false) {
        if self.layer.animation(forKey: "VibrateAnimationKey") != nil {
            return
        }
        let animation: CABasicAnimation
        animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.beginTime = isSync ? 0.0 : Double( Int.random(in: 1...10) ) * 0.1
        animation.isRemovedOnCompletion = false
        animation.duration = speed
        animation.fromValue = range * Double.pi / 180.0
        animation.toValue = -range * Double.pi / 180.0
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        self.layer.add(animation, forKey: "VibrateAnimationKey")
    }
    /// 震えるアニメーションを停止します
    func stopVibrateAnimation() {
        self.layer.removeAnimation(forKey: "VibrateAnimationKey")
    }
}
