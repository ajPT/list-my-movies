//
//  RoundedCornerBtn.swift
//  my-favorite-movies
//
//  Created by Amadeu Andrade on 28/05/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class RoundedCornerBtn: UIButton {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
}