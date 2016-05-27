//
//  Movie.swift
//  my-favorite-movies
//
//  Created by Amadeu Andrade on 26/05/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Movie: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    func setMovieImage(img: UIImage?) {
        if let movieImg = img {
            let data = UIImagePNGRepresentation(movieImg)
            self.image = data
        } else {
            let data = UIImagePNGRepresentation(UIImage(named: "nomovie")!)
            self.image = data
        }
    }
    
    func getMovieImage() -> UIImage {
        let img = UIImage(data: self.image!)!
        return img
    }
    
}
