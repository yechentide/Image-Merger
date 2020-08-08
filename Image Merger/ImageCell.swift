//
//  ImageCell.swift
//  Image Merger
//
//  Created by yechen on 2020/08/07.
//  Copyright © 2020 Polarnight. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setImage(name: String) {
        imageView.image = UIImage(named: name)!
        imageView.image?.accessibilityIdentifier = name
    }
    
    func setImage(img: UIImage) {
        imageView.image = img
    }
    
    
    // 枠線の色
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    // 枠線のWidth
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    // 角丸設定
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
