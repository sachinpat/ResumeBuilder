//
//  DataHolder.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 10/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

class DataHolder: NSObject {
    static let sharedInstance = DataHolder()
    var fetchSaved = 0
    private override init() {
        
    }
    // MARK: - Save and image
    func saveImage(imageName: String, image:UIImage){
        //create an instance of the FileManager
        let fileManager = FileManager.default
        //get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        //get the PNG data for this image
        let data = UIImagePNGRepresentation(image)
        //store it in the document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    
    func getImage(imageName: String) -> String {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            return imagePath
        }else{
            print("Panic! No Image!")
        }
        return imagePath
    }
}
