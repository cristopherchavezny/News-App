//
//  LogoCollectionViewCell.swift
//  UppermostNews
//
//  Created by Cris on 12/4/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import UIKit

class LogoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var logoImageView: UIImageView!
    
    override func prepareForReuse() {
        logoImageView.image = nil
    }
}
