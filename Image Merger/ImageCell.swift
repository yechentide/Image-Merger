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

    func setup(img: UIImage) {
        imageView.image = img
    }
}
