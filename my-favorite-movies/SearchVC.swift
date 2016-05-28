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
    @IBOutlet weak var searchByLbl: UILabel!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        searchByLbl.hidden = true
        searchField.hidden = true
        yearField.hidden = true
    }

    @IBAction func onSearchByTitlePressed(sender: UIButton) {
        selectAnOptionLbl.hidden = true
        magnifierImg.hidden = true
        searchByLbl.hidden = false
        searchByLbl.text = "Insert movie title:"
        searchField.hidden = false
        searchField.placeholder = "Title"
        yearField.hidden = false
        yearField.placeholder = "Year?"
    }
    
    @IBAction func onSearchByIDPressed(sender: UIButton) {
        selectAnOptionLbl.hidden = true
        magnifierImg.hidden = true
        searchByLbl.hidden = false
        searchByLbl.text = "Insert IMDd ID:"
        searchField.hidden = false
        searchField.placeholder = "IMDb ID"
        yearField.hidden = true
    }
    
    @IBAction func onSearchPressed(sender: UIButton) {
        
    }
}
