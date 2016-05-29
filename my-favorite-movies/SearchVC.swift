//
//  SearchVC.swift
//  my-favorite-movies
//
//  Created by Amadeu Andrade on 26/05/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var selectAnOptionLbl: UILabel!
    @IBOutlet weak var magnifierImg: UIImageView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        searchField.hidden = true
        yearField.hidden = true
    }

    @IBAction func onSearchByPressed(sender: UIButton) {
        selectAnOptionLbl.hidden = true
        magnifierImg.alpha = 0.25
        searchField.hidden = false
        if sender.tag == 0 {
            searchField.placeholder = "Title"
            yearField.hidden = false
            yearField.placeholder = "Year?"
        } else if sender.tag == 1 {
            searchField.placeholder = "IMDb ID"
            yearField.hidden = true
        }
    }
    
    @IBAction func onSearchPressed(sender: UIButton) {
        makeRequest("tt0137523")
        //performSegueWithIdentifier("showMovie", sender: nil)
    }
    
    func makeRequest(imdbid: String) {
        let url = NSURL(string: "http://api.themoviedb.org/3/movie/\(imdbid)?api_key=e55425032d3d0f371fc776f302e7c09b")!
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let response = response, data = data {
                //print(response)
                //print(String(data: data, encoding: NSUTF8StringEncoding))
                self.pparseJSON(data)
            } else {
                print(error)
            }
        }
        task.resume()
    }
    
    func pparseJSON(data: NSData) {
        var json: [String: AnyObject]!
        
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
        } catch {
            //erro
        }
        print(json)
        // print(json["title"])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMovie" {
            if let viewToBeCalled = segue.destinationViewController as? ShowMovieVC {
                viewToBeCalled.movieToShow = Movie()
            }
        }
    }
    
}
