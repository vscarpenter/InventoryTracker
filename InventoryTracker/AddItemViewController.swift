//
//  AddItemViewController.swift
//  InventoryTracker
//
//  Created by Vinny Carpenter on 1/1/15 - leveraged tutorial @ http://goo.gl/M0Gl6p
//  Copyright (c) 2015 Vinny Carpenter. All rights reserved.
//

import UIKit


func documentsDirectory() -> String {
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
    return documentsFolderPath
}

func fileInDocumentsDirectory(fileName: String) -> String {
    return documentsDirectory().stringByAppendingPathComponent(fileName)
}

class AddItemViewController: UIViewController, UIAlertViewDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate,UIPopoverControllerDelegate {
    
    @IBOutlet var addImageButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var itemPrice: UITextField!
    @IBOutlet var itemDesc: UITextField!
    var picker: UIImagePickerController? = UIImagePickerController()
    var popover: UIPopoverController? = nil
    let documentsPath = fileInDocumentsDirectory("sample.csv")
    let saveUtils = SaveUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker!.delegate=self
        itemPrice.delegate = self
        itemDesc.delegate = self
    }
    
    @IBAction func addItemButtonClicked(sender: AnyObject) {
        
        
        
        var image = imageView.image
        var imagePath = documentsPath + ".jpg"
        saveUtils.saveImage(image!, path: imagePath)
        var itemDescription = itemDesc.text
        var itemPriceVal = itemPrice.text
        
        var stringToSave = "\(itemDescription), \(itemPriceVal), \(image?.description)"
        
        println("CSV file saved - \(documentsPath)")
        var saveStatus = saveUtils.saveText(stringToSave, path: documentsPath)
        
        if saveStatus {
            var alert = UIAlertController(title: "Success", message: "Files saved successfully", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func imageButtonClicked(sender: AnyObject) {
        
        var alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        var gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.openGallary()
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            
        }
        
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        // Present the controller
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            popover=UIPopoverController(contentViewController: alert)
            popover!.presentPopoverFromRect(addImageButton.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    func openGallary() {
        picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.presentViewController(picker!, animated: true, completion: nil)
        } else {
            popover=UIPopoverController(contentViewController: picker!)
            popover!.presentPopoverFromRect(addImageButton.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!)    {
        picker .dismissViewControllerAnimated(true, completion: nil)
        imageView.image=(info[UIImagePickerControllerOriginalImage] as UIImage)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        println("Cancel!")
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
    }
    
}

