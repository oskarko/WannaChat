//
//  FileStorage.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import FirebaseStorage
import Foundation
import ProgressHUD
import UIKit

let storage = Storage.storage()

class FileStorage {
    
    // MARK: - Images
    
    class func uploadImage(_ image: UIImage, directory: String, completion: @escaping (_ avatarLink: String?) -> Void) {
        
        let storageRef = storage.reference(forURL: kFILEREFERENCE).child(directory)
        let imageData = image.jpegData(compressionQuality: 0.6)
        
        var task: StorageUploadTask!
        
        task = storageRef.putData(imageData!, metadata: nil, completion: { metadata, error in
            
            task.removeAllObservers()
            ProgressHUD.dismiss()
            
            if let error = error {
                print("Error uploading image: ", error.localizedDescription)
                return
            }
            
            storageRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("Error with downloadURL: ", error?.localizedDescription ?? "")
                    completion(nil)
                    return
                }
                
                completion(downloadURL.absoluteString)
            }
        })
        
        task.observe(.progress) { snapshot in
            if let snapshotProgress = snapshot.progress {
                let progress = snapshotProgress.completedUnitCount / snapshotProgress.totalUnitCount
                ProgressHUD.showProgress(CGFloat(progress))
            }
        }
    }
    
    class func downloadImage(imageURL: String, completion: @escaping (_ image: UIImage?) -> Void) {
        if let imageFileName = imageURL.getFileName() {
            if fileExists(at: imageFileName) {
                // get it locally
                if let filePath = fileInDocumentsDirectory(fileName: imageFileName),
                   let contentsOfFile = UIImage(contentsOfFile: filePath) {
                    completion(contentsOfFile)
                } else {
                    print("Could not convert local image!")
                    completion(UIImage(named: "avatar")) // placeholder
                }
            } else {
                // download from Firebase
                if !imageURL.isEmpty {
                    if let documentURL = URL(string: imageURL) {
                        
                        DispatchQueue(label: "ImageDownloadQueue").async {
                            if let data = NSData(contentsOf: documentURL) {
                                // Save it locally
                                FileStorage.saveFileLocally(fileData: data, fileName: imageFileName)
                                
                                DispatchQueue.main.async {
                                    completion(UIImage(data: data as Data))
                                }
                            } else {
                                print("No document in Firebase database!")
                                
                                DispatchQueue.main.async {
                                    completion(nil)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    class func saveFileLocally(fileData: NSData, fileName: String) {
        guard let docURL = getDocumentsURL()?.appendingPathComponent(fileName, isDirectory: false) else { return }
        
        fileData.write(to: docURL, atomically: true)
    }
}

// MARK: - Helpers

func fileInDocumentsDirectory(fileName: String) -> String? {
    getDocumentsURL()?.appendingPathComponent(fileName).path
}

func getDocumentsURL() -> URL? {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
}

func fileExists(at path: String) -> Bool {
    guard let filePath = fileInDocumentsDirectory(fileName: path) else { return false }
    
    return FileManager.default.fileExists(atPath: filePath)
}
