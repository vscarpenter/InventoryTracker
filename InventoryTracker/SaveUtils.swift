//
//  SaveUtils.swift
//  InventoryTracker
//
//  Created by Vinny Carpenter on 1/1/15.
//  Copyright (c) 2015 Vinny Carpenter. All rights reserved.
//

import UIKit

class SaveUtils {

    func saveText(text: String, path: String) -> Bool {
        
        var error: NSError? = nil
        let status = text.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
        
        if !status {
            println("Error saving file at path \(path) with error \(error?.localizedDescription)")
        }
        
        return status
    }
    
    func loadTextFromPath(path: String) -> String? {
        var error: NSError? = nil
        let text = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: &error)
        
        if (text == nil) {
            println("Error loading text from path \(path) and error is \(error?.localizedDescription)")
            
        }
        
        return text
    }
    
    func saveImage(image: UIImage, path: String) -> Bool {
        
        let jpgImageData = UIImageJPEGRepresentation(image, 1.0)
        let pngImageData = UIImagePNGRepresentation(image)
        
        let result = jpgImageData.writeToFile(path, atomically: true)
        let pngResult = pngImageData.writeToFile(path + ".png", atomically: true)
        
        return result
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            println("Missing image at path: \(path)")
        }
        return image
    }

}
