//
//  MovieCell.swift
//  my-favorite-movies
//
//  Created by Amadeu Andrade on 26/05/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitleYear: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(movie: Movie) {
        movieImg.image = movie.getMovieImage()
        if let title = movie.title, let year = movie.year {
            movieTitleYear.text = "\(title) (\(year))"
        }
        //movieTitleYear.text = "\(movie.title!) (\(movie.year!))"
        moviePlot.text = movie.plot
    }

}
