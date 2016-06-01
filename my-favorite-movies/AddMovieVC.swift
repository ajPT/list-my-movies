//
//  AddMovieVC.swift
//  my-favorite-movies
//
//  Created by Amadeu Andrade on 26/05/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import CoreData

class AddMovieVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var moviePic: RoundedCornerImg?
    @IBOutlet weak var addPicBtn: UIButton!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var plotField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func addMovie(sender: UIButton) {
        if let title = titleField.text where title != "", let year = yearField.text where year != "", let plot = plotField.text where plot != "" {
            
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context)!
            let movie = Movie(entity: entity, insertIntoManagedObjectContext: context)
            
            movie.setMovieImage(moviePic?.image)
            movie.title = title
            movie.plot = plot
            movie.year = year
            
            context.insertObject(movie)
            do {
                try context.save()
            } catch let err as NSError {
                print(err.debugDescription)
            }
            self.navigationController?.popViewControllerAnimated(true)
            
        } else {
            UtilAlerts().showAlert(self, title: "Warning", message: UtilAlerts.applicationAlerts.MissingInformation)
        }
        
    }
    
    @IBAction func addPicture(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.allowsEditing = false
            if let availableMediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary) {
                imagePicker.mediaTypes = availableMediaTypes
            }
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        moviePic!.image = image
        addPicBtn.hidden = true
    }

}
