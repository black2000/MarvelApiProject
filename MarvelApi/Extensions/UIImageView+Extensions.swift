//
//  UIImageView+Extensions.swift
//  MarvelApi
//
//  Created by lapshop on 11/10/21.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func downloadImage(With imageUrl: URL) {
        self.kf.setImage(with: imageUrl)
    }
    
    
    
    
}




