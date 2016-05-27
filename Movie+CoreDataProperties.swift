//
//  Movie+CoreDataProperties.swift
//  my-favorite-movies
//
//  Created by Amadeu Andrade on 26/05/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movie {

    @NSManaged var imdbID: String?
    @NSManaged var title: String?
    @NSManaged var year: String?
    @NSManaged var plot: String?
    @NSManaged var imdbRating: String?
    @NSManaged var actors: String?
    @NSManaged var genre: String?
    @NSManaged var runtime: String?
    @NSManaged var releaseDate: String?
    @NSManaged var videoPath: String?
    @NSManaged var image: NSData?

}
