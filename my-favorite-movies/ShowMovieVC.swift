//
//  ShowMovieVC.swift
//  my-favorite-movies
//
//  Created by Amadeu Andrade on 26/05/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class ShowMovieVC: UIViewController {
    
    @IBOutlet weak var movieCover: UIImageView!
    @IBOutlet weak var titleYear: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var awards: UILabel!
    @IBOutlet weak var plot: UILabel!
    @IBOutlet weak var youtube: UIButton!
    @IBOutlet weak var imdb: UIButton!
    @IBOutlet weak var addToFavoritesBtn: UIButton!
    @IBOutlet weak var addToWatchlistBtn: UIButton!
    
    var movieToShow: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.hidesBarsOnTap = true
        updateMovieInfoToShow()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = false
    }
    
    func updateMovieInfoToShow() {
        if let title = movieToShow.title, let year = movieToShow.year, let plotTxt = movieToShow.plot { //change this
            movieCover.image = movieToShow.getMovieImage()
            titleYear.text = "\(title) (\(year))"
            plot.text = plotTxt
            if let imdbRating = movieToShow.imdbRating {
                rating.text = imdbRating
            } else {
                rating.text = "?"
            }
            if let releaseData = movieToShow.releaseDate {
                date.text = releaseData
            } else {
                date.text = "?"
            }
            if let movieGenre = movieToShow.genre {
                genre.text = movieGenre
            } else {
                genre.text = "?"
            }
            if let movieDuration = movieToShow.runtime {
                duration.text = movieDuration
            } else {
                duration.text = "?"
            }
            if let mainActors = movieToShow.actors {
                actors.text = mainActors
            } else {
                actors.text = "?"
            }
            if let movieAwards = movieToShow.awards {
                awards.text = movieAwards
            } else {
                awards.text = "?"
            }
            //add videoPath
            if let movieVideoPath = movieToShow.videoPath {
                print(movieVideoPath)
            } else {
                youtube.enabled = false
                youtube.alpha = 0.5
            }
            //add imdbPath
            if let imdbPath = movieToShow.imdbID {
                print(imdbPath)
            } else {
                imdb.enabled = false
                imdb.alpha = 0.5
            }
        
        }
    }
    
    @IBAction func onAddToFavoritesPressed(sender: AnyObject) {
    
    }
    
    @IBAction func onAddToWatchlistPressed(sender: AnyObject) {
    
    }
    
    @IBAction func onYoutubePressed(sender: AnyObject) {
    
    }
    
    @IBAction func onIMDbPressed(sender: AnyObject) {
    
    }
    

}
