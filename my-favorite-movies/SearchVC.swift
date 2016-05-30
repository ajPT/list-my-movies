//
//  SearchVC.swift
//  my-favorite-movies
//
//  Created by Amadeu Andrade on 26/05/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import CoreData

class SearchVC: UIViewController {

    @IBOutlet weak var selectAnOptionLbl: UILabel!
    @IBOutlet weak var magnifierImg: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var imdbIDField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        titleField.hidden = true
        yearField.hidden = true
        imdbIDField.hidden = true
        searchBtn.enabled = false
        searchBtn.alpha = 0.5
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context)!
        movie = Movie(entity: entity, insertIntoManagedObjectContext: context)
    }

    @IBAction func onSearchByPressed(sender: UIButton) {
        searchBtn.enabled = true
        searchBtn.alpha = 1.0
        selectAnOptionLbl.hidden = true
        magnifierImg.alpha = 0.25
        if sender.tag == 0 {
            titleField.hidden = false
            yearField.hidden = false
            imdbIDField.text = ""
            imdbIDField.hidden = true
        } else if sender.tag == 1 {
            titleField.text = ""
            yearField.text = ""
            titleField.hidden = true
            yearField.hidden = true
            imdbIDField.hidden = false
        }
    }
    
    @IBAction func onSearchPressed(sender: UIButton) {
        var url: NSURL?
        
        if imdbIDField.text != "" {
            url = NSURL(string: "http://www.omdbapi.com/?i=\(imdbIDField.text!)&plot=short&r=json")
        } else if titleField.text != "" && yearField.text != "" {
            let stringToUrl = titleField.text!.stringByReplacingOccurrencesOfString(" ", withString: "+")
            url = NSURL(string: "http://www.omdbapi.com/?t=\(stringToUrl)&y=\(yearField.text!)&plot=short&r=json")
            print(url)
        } else if titleField.text != "" {
            let stringToUrl = titleField.text!.stringByReplacingOccurrencesOfString(" ", withString: "+")
            url = NSURL(string: "http://www.omdbapi.com/?t=\(stringToUrl)&plot=short&r=json")
        } else {
            UtilAlerts().showAlert(self, title: "Warning", message: UtilAlerts.applicationAlerts.MissingInformation)
        }
    
        if url != nil {
            makeMovieInfoRequest(url!)
        }
    }
    
    func makeMovieInfoRequest(url: NSURL) {
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let response = response, data = data {
                print(response)
                print(String(data: data, encoding: NSUTF8StringEncoding))
                //BEGIN parsing JSON
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    print(json)
                    if let responde = json["Response"] as? String where responde == "False" {
                        print("Wrong IMDb ID!")
                        dispatch_async(dispatch_get_main_queue()) { () -> Void in
                            UtilAlerts().showAlert(self, title: "Warning", message: UtilAlerts.applicationAlerts.WrongInformation)
                        }
                    } else if let actors = json["Actors"] as? String,
                        let awards = json["Awards"] as? String,
                        let genre = json["Genre"] as? String,
                        let image = json["Poster"] as? String,
                        let imdbID = json["imdbID"] as? String,
                        let imdbRating = json["imdbRating"] as? String,
                        let plot = json["Plot"] as? String,
                        let releaseDate = json["Released"] as? String,
                        let runtime = json["Runtime"] as? String,
                        let title = json["Title"] as? String,
                        let year = json["Year"] as? String {
                        self.movie.actors = actors
                        self.movie.awards = awards
                        self.movie.genre = genre
                        if let url = NSURL(string: "\(image)") {
                            if let data = NSData(contentsOfURL: url) {
                                self.movie.image = data
                            }
                        }
                        self.movie.imdbID = imdbID
                        self.movie.imdbRating = imdbRating
                        self.movie.plot = plot
                        self.movie.releaseDate = releaseDate
                        self.movie.runtime = runtime
                        self.movie.title = title
                        self.movie.year = year
                        
                        dispatch_async(dispatch_get_main_queue()) { () -> Void in
                            self.performSegueWithIdentifier("showMovie", sender: self.movie)
                        }
                        
                    }
                } catch {
                    print("error serializing JSON")
                }
                //END parsing JSON
            } else {
                print(error)
            }
        }
        task.resume()
    }

//    func makeMovieVideoRequest(imdbid: String) {
//        let url = NSURL(string: "http://api.themoviedb.org/3/movie/\(imdbid)/videos?api_key=e55425032d3d0f371fc776f302e7c09b")!
//        let request = NSMutableURLRequest(URL: url)
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request) { data, response, error in
//            if let response = response, data = data {
//                print(response)
//                print(String(data: data, encoding: NSUTF8StringEncoding))
//                //BEGIN parsing JSON
//                do {
//                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
//                    if let jsonResults = json["results"] as? [[String: AnyObject]] {
//                        for result in jsonResults {
//                            if let code = result["key"] as? String {
//                                self.movie.videoPath = "https://www.youtube.com/watch?v=\(code)"
//                                break
//                            }
//                        }
//                    }
//                } catch {
//                    print("error serializing JSON")
//                }
//            //END parsing JSON
//            } else {
//                print(error)
//            }
//        }
//        task.resume()
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMovie" {
            if let viewToBeCalled = segue.destinationViewController as? ShowMovieVC {
                viewToBeCalled.movieToShow = sender as! Movie
            }
        }
    }
    
}
