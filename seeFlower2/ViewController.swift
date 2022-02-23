//
//  ViewController.swift
//  seeFlower2
//
//  Created by ran you on 2/22/22.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    let wikipediaURL = "https://en.wikipedia.org/w/api.php"
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let userPickedImage = info[.originalImage] as? UIImage {
//                imageView.image = userPickedImage
                
              guard let ciimage = CIImage(image: userPickedImage)
                else {fatalError("Can't convert to CIImage")}
                
                detect(image:ciimage)
                
            }
           
            imagePicker.dismiss(animated: true, completion: nil)
        }
    
    
    func detect(image: CIImage) {
            
            guard let model = try? VNCoreMLModel(for:FlowerClassifier().model)
            
            else {
                fatalError("Can't use VNCoreMLModel")
                
            }
            
            let request = VNCoreMLRequest(model: model) { (request, error) in
                
              guard let results = request.results as? [VNClassificationObservation]
                      
                else {
                    fatalError("Model failed to process image")
                }
                
                if let firstResult = results.first {
                    self.navigationItem.title = firstResult.identifier.capitalized
                    self.requestInfo(flowerName: firstResult.identifier)
                }
                
            }
                
                let handler = VNImageRequestHandler(ciImage: image)
            
                do { try handler.perform([request])
                   
               } catch {
                   print(error)
                   
               }
            
        }
    
   
    
    func requestInfo(flowerName:String) {
        
        let parameters : [String:String] = [
        "format" : "json",
        "action" : "query",
        "prop" : "extracts|pageimages",
        "exintro" : "",
        "explaintext" : "",
        "titles" : flowerName,
        "indexpageids" : "",
        "redirects" : "1",
        "pithumbsize":"500"
        ]
        
        Alamofire.request(wikipediaURL, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess{
                print("got wiki info")
                print(response)
                
                let flowerJSON: JSON = JSON(response.result.value!)
                let pageid = flowerJSON["query"]["pageids"][0].stringValue
                let flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue
                
                let flowerImageURL = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                self.imageView.sd_setImage(with:URL(string:flowerImageURL) )
                
                self.label.text = flowerDescription
            } else {
                print("wiki info failure")
            }
        }
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated:true, completion: nil)
    }
}

