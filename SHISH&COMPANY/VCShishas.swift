//
//  VCShishas.swift
//  SHISH&COMPANY
//
//  Created by Alejandro Martín-Serrano Vera on 21/6/17.
//  Copyright © 2017 Daniel de la Iglesia, Alejandro Martín. All rights reserved.
//

import UIKit
import Firebase

class VCShishas: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var shishas:Shishas?
    @IBOutlet var txtNombre:UITextField?
    @IBOutlet var imgview:UIImageView?
    @IBOutlet var txtDescripcion:UITextView?
    let imagePicker: UIImagePickerController = UIImagePickerController()
    var imgData:Data?
    
    var loggedInUser = FIRAuth.auth()?.currentUser?.uid
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Descomentar, si el tap no debe interferir o cancelar otras acciones
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard() {
        //Las vistas y toda la jerarquía renuncia a responder, para esconder el teclado
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func accionBotonGaleria(){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func accionBotonCamara(_ sender:AnyObject){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil{
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                
                self.present(imagePicker, animated: true, completion: nil)
            }
            
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let referenceStorage = DataHolder.sharedInstance.firStorageRef
        
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        imgData = UIImageJPEGRepresentation(img!, 0.5)!  as Data
        
        imgview?.image = img
        
        self.dismiss(animated: true, completion: nil)
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        let profilePicRef = referenceStorage?.child("Shishas/\(String(describing: (FIRAuth.auth()?.currentUser?.uid)!))/\((txtNombre?.text)!).jpg")
        
        profilePicRef?.put(UIImageJPEGRepresentation((img)!, 0.4)!, metadata: metadata)
        
        profilePicRef?.downloadURL(completion: { (url, error) in
            if error != nil{
                print("ERROR DE SUBIR IMAGEN",error?.localizedDescription)
                print(url)
            }
            else{
                var imageURL = url?.absoluteString
                self.uploadImageToImagen(uploadURL: imageURL!)
            }
        })
    }
    
    func uploadImageToImagen(uploadURL: String){
     }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    @IBAction func accionBotonAceptar(){
        FIRDatabase.database().reference().child("Shishas/\(String(describing: (FIRAuth.auth()?.currentUser?.uid)!))/\((txtNombre?.text)!)/Descripcion").setValue(txtDescripcion?.text)
        FIRDatabase.database().reference().child("Shishas/\(String(describing: (FIRAuth.auth()?.currentUser?.uid)!))/\((txtNombre?.text)!)/URL").setValue("Shishas/\(String(describing: (FIRAuth.auth()?.currentUser?.uid)!))/\(txtNombre?.text as! String).jpg")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func accionBotonCancelar(){
        self.dismiss(animated: true, completion: nil)
    }
}
