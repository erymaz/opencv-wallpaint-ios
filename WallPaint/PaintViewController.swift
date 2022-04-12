//
//  ViewController.swift
//  WallPaint
//
//  Created by devstar on 4/12/22.
//

import UIKit

class PaintViewController: UIViewController {
    //MARK:- ViewController Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- ViewController state variables
    private var touchX = 0.0
    private var touchY = 0.0
    private var screenSize = CGSize.zero
    private var cameraToggled = false
    private var applyPaint = true
    private var currentColor = UIColor.red
    
    var colorPicker: ChromaColorPicker!
    
    private var imagePickerVC: UIImagePickerController {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        colorPicker = ChromaColorPicker(frame: CGRect(x: view.frame.width/2 - 140, y: view.frame.height/2 - 270, width: 300, height: 300))
        colorPicker.delegate = self //ChromaColorPickerDelegate
        colorPicker.padding = 5
        colorPicker.stroke = 3
        colorPicker.currentColor = currentColor
        colorPicker.hexLabel.textColor = currentColor
               
        colorPicker.isHidden = true
        view.addSubview(colorPicker)
        getPhoto()
    }

    @IBAction func openGallery(_ sender: UIBarButtonItem) {
        cameraToggled = false
        getPhoto()
    }
    
    @IBAction func toggleTexture(_ sender: UIBarButtonItem) {
        applyPaint = false
        showAlert("Alert", "Please touch the position of the wall to apply texture.")
    }
    
    @IBAction func toggleColor(_ sender: UIBarButtonItem) {
        applyPaint = true
        showAlert("Alert", "Please touch the position of the wall to apply color.")
    }
    
    @IBAction func chooseColor(_ sender: UIBarButtonItem) {
        colorPicker.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: imageView)
            print(position)
            touchX = Double(position.x)
            touchY = Double(position.y)
            
            var overlayedImage = UIImage()
            
            activityIndicator.startAnimating()
            if applyPaint {
                overlayedImage = WallPainterBridge().paintWall(of: imageView.image, touchPointX: touchX, touchPointY: touchY,imageWidth: Double(imageView.bounds.width),imageHeight: Double(imageView.bounds.height),colorToapply: currentColor)
            } else {
                let texture = UIImage(named: "brick_wall_texture_small_bricks_ios")
                overlayedImage = WallPainterBridge().applyTexture(to: imageView.image, textureToApply: texture, touchPointX: touchX, touchPointY: touchX,imageWidth: Double(imageView.bounds.width),imageHeight: Double(imageView.bounds.height))
            }
            imageView.image = overlayedImage
            activityIndicator.stopAnimating()
        }
    }
    
    //MARK:- Custom Methods
    
    private func getPhoto() {
        if cameraToggled {
            imagePickerVC.sourceType = .camera
        } else {
            imagePickerVC.sourceType = .photoLibrary
        }
        present(imagePickerVC, animated: true)
    }
    
    func showAlert(_ title: String, _ message: String){
       
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )

        alert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        ))
        present(alert, animated: true, completion: nil)
    }
}

//MARK:- ImagePicker delegate methods
extension PaintViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("no image found")
            return
        }
        print(image)
        imageView.image = image
    }
}

//MARK:- ChromaColorPicker delegate methods
extension PaintViewController: ChromaColorPickerDelegate {
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        currentColor = color
        colorPicker.hexLabel.textColor = currentColor
        colorPicker.isHidden = true
    }
}
