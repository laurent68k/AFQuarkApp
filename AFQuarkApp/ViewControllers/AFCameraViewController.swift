//
//  FACameraViewController.swift
//  AFQuarkApp
//
//  Created by Laurent Favard on 30/03/2019.
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import UIKit
import AFQuark

class AFCameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    private let iCloud = AFiCloud.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cameraShoot(_ sender: Any) {
        
        AFCamera.shoot(self)
    }
    
    @IBAction func iCloudAction(_ sender: Any) {
        
        var image = self.imageView.image
        
        if image == nil {
            
            image = UIImage(named: "photo")
        }
        
        if let image = image {
            
            if let data = image.jpegData(compressionQuality: 1.0)  {
            
                var imageUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:true)
                let localDocument = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:true)
                
                let file = "photo.jpg"
                
                imageUrl?.appendPathComponent(file)
                
                //print("writing from: \(String(describing: documentDirectory?.absoluteString))")
                
                if let imageUrl = imageUrl, let localDocument =  localDocument {
                    
                    do {
                        try data.write(to: imageUrl)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                    
                    //  testing
                    let containerURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)
                    let documentDirectoryURL = containerURL!.appendingPathComponent("Documents")
                    let documentURL = documentDirectoryURL.appendingPathComponent("Readme.txt")
                    let text = String("Your photo has been uploaded")
                    try? text.write(to: documentURL, atomically:true, encoding:String.Encoding.utf8)
                    //  ---
                    
                    
                    iCloud.synchronize(fromSource: localDocument)
                    
                    AFAlert.okAlert(self, title: "iCloud", message: "iCloud share done")
                }
            }
        }
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        
        if let image = self.imageView.image {

            AFCamera.shareImages(self, anchorObject: sender, images: [image])
        }
        else if let image = UIImage(named: "photo") {
            
            AFCamera.shareImages(self, anchorObject: sender, images: [image])
        }        
    }
}


extension AFCameraViewController  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            self.imageView.image = editedImage
        }
        
        //Dismiss the UIImagePicker after selection
        picker.dismiss(animated: true, completion: {
            
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
