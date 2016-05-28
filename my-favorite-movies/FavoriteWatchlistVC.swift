//
//  FavoriteWatchlistVC.swift
//  my-favorite-movies
//
//  Created by Amadeu Andrade on 26/05/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import CoreData

class FavoriteWatchlistVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var moviesArray = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(FavoriteWatchlistVC.onAddBtnPressed))
        tableView.backgroundView = UIImageView(image: UIImage(named: "bg"))
    }
    
    func onAddBtnPressed() {
        performSegueWithIdentifier("showAddMovieVC", sender: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
    }
    
    func fetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Movie")
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            moviesArray = results as! [Movie]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as? MovieCell {
            let movie = moviesArray[indexPath.row]
            cell.configureCell(movie)
            return cell
        } else {
            return MovieCell()
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showMovieVC", sender: moviesArray[indexPath.row].objectID)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMovieVC" {
            if let viewToBeCalled = segue.destinationViewController as? ShowMovieVC {
                if let movieID = sender as? NSManagedObjectID {
                    let app = UIApplication.sharedApplication().delegate as! AppDelegate
                    let context = app.managedObjectContext
                    let movie = context.objectWithID(movieID) as! Movie
                    viewToBeCalled.movieToShow = movie
                }
            }
        }
    }

}
