//
//  LocalFileManager.swift
//  iCoin
//
//  Created by Lingeswaran Kandasamy on 12/13/21.
//

import Foundation
import SwiftUI

class ICLocalFileManager {
    
    static let instance = ICLocalFileManager()
    
    private init() {}
    
    func saveImage(img: UIImage, imgName: String, dirName: String) {
        createDirectoryIfNeeded(dirName: dirName)
        guard
            let data = img.pngData(),
            let  url = getURLForImage(imgName: imgName, dirName: dirName)
        else { return }
        do {
            try data.write(to: url)
        } catch let error {
            print("Error cannot save image. ImageName: \(imgName). \(error)")
        }
    }
     
    
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imgName: imageName, dirName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
        
    
    
    private func createDirectoryIfNeeded(dirName: String) {
        guard let url = getURLForDirectory(dirName: dirName) else {return}
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error cannot create Directory. DirectoryName: \(dirName). \(error)")
            }
        }
    }
        
    
    
    private func getURLForDirectory(dirName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(dirName)
    }
      
    
    
    private func getURLForImage(imgName: String, dirName: String) -> URL? {
        guard let dirURL = getURLForDirectory(dirName: dirName) else {return nil}
        
        return dirURL.appendingPathComponent(imgName + ".png")
    }
}

