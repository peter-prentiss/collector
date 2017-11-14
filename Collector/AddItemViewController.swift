//
//  AddItemViewController.swift
//  Collector
//
//  Created by admin on 11/13/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleTextView: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
           itemImageView.image = chosenImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func addTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let item = Item(entity: Item.entity(), insertInto: context)
            
            item.title = titleTextView.text
            
            if let image = itemImageView.image {
                if let imageData = UIImagePNGRepresentation(image) {
                    item.image = imageData
                }
            }
            
            try? context.save()
            
            navigationController?.popViewController(animated: true)
        }
        
        
    }
}
