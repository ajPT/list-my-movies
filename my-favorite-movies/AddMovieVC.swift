//
//  AddMovieVC.swift
//  my-favorite-movies
//
//  Created by Amadeu Andrade on 26/05/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import CoreData

class AddMovieVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addMovie(sender: UIButton) {
        //if let title, pic...
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context)!
        let movie = Movie(entity: entity, insertIntoManagedObjectContext: context)
        movie.setMovieImage(UIImage(named: "nomovie")!)
        movie.title = "New movie in town"
        movie.plot = "A lot of stuff going on here!"
        movie.year = "1990"
        context.insertObject(movie)
        do {
            try context.save()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }

}
