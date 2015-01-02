//
//  ViewController.swift
//  InventoryTracker
//
//  Created by Vinny Carpenter on 1/1/15.
//  Copyright (c) 2015 Vinny Carpenter. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListOfFilesFromDocDirectory()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        getListOfFilesFromDocDirectory()
    }


    func getListOfFilesFromDocDirectory() {
        
        var docDir = documentsDirectory()
        let filemanager:NSFileManager = NSFileManager()
        let files = filemanager.enumeratorAtPath(docDir)
        var stringBuffer: String = ""
        
        while let file: AnyObject = files?.nextObject() {
            stringBuffer += file.description
            stringBuffer += "\n"
        }
        
        textView.text = stringBuffer
    }

}

