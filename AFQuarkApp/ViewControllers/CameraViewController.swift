//
//  CameraViewController.swift
//  AFQuarkApp
//
//  Created by Laurent Favard on 30/03/2019.
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import UIKit
import AFQuark

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var zoomableScrollView: AFZoomableScrollView!
    
    private let iCloud = AFiCloud.shared
    
    var photo: UIImage? {
        
        set {
            if let image = newValue {
                
                self.zoomableScrollView.display(image: image)
            }
        }
        get {
            if let imageView = self.zoomableScrollView.contentView as? UIImageView {
                
                return imageView.image
            }
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cameraShoot(_ sender: Any) {
            
        AFCamera.capture(self)
    }
    
    @IBAction func iCloudAction(_ sender: Any) {
        
        var image = self.photo
        
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
                    if let cloud = iCloud.remoteCloudUrl() {
                        
                        let documentURL = cloud.appendingPathComponent("Readme.txt")
                        let text = String("Your photo has been uploaded")
                        
                        do {
                            try text.write(to: documentURL, atomically:true, encoding:String.Encoding.utf8)
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                    
                    if iCloud.synchronize(fromSourceFolder: localDocument, to: "Photo") {
                        
                        AFAlert.okAlert(self, title: "iCloud", message: "iCloud share done")
                    }
                    else {
                        AFAlert.okAlert(self, title: "iCloud", message: "iCloud share failed")
                    }
                }
            }
        }
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        
        if let image = self.photo {

            AFShare.shareImages(self, anchorObject: sender, images: [image])
        }
        else if let image = UIImage(named: "photo") {
            
            AFShare.shareImages(self, anchorObject: sender, images: [image])
        }        
    }
}


extension CameraViewController  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            self.photo = editedImage
        }
        
        //Dismiss the UIImagePicker after selection
        picker.dismiss(animated: true, completion: {
            
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
