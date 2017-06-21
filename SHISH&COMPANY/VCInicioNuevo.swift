//
//  VCInicioNuevo.swift
//  SHISH&COMPANY
//
//  Created by Daniel de la Iglesia Gonzalez on 18/5/17.
//  Copyright © 2017 Daniel de la Iglesia, Alejandro Martín. All rights reserved.
//

import UIKit
import Firebase

class VCInicioNuevo: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var perfil:Perfil?
    @IBOutlet var txtTipo:UISegmentedControl?
    @IBOutlet var imgview:UIImageView?
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
        let profilePicRef = referenceStorage?.child("perfil/\(self.loggedInUser!)/profile_pic.jpg")
        //profilePicRef.put(UIImageJPEGRepresentation((self.imageProfile.imageView?.image)!, 0.8)!)
        profilePicRef?.put(UIImageJPEGRepresentation((img)!, 0.4)!, metadata: metadata)
        
        profilePicRef?.downloadURL(completion: { (url, error) in
            if error != nil{
                print("ERROR DE SUBIR IMAGEN",error?.localizedDescription)
                print(url)
            }
            else{
                var imageURL = url?.absoluteString
                self.uploadImageToUser(uploadURL: imageURL!)
            }
        })
    }
    
    func uploadImageToUser(uploadURL: String){
        let token = FIRAuth.auth()?.currentUser?.uid
        let referenceStorage = DataHolder.sharedInstance.firDatabaseRef
        let usersReference = referenceStorage?.child("Perfiles").child(token!)
        let values = ["profileImg":uploadURL]
        usersReference?.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            
            if err != nil {
                
                //Tells the user that there is an error and then gets firebase to tell them the error
                let alertController = UIAlertController(title: "Error", message: err?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                
                
                self.present(alertController, animated: true, completion: nil)
                print("ERROR SET USER IMAGE IN FIREBASE ",err?.localizedDescription)
            }
            else{
                print("Image uploaded")
            }
        })
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }

    @IBAction func accionBotonAceptar(){

        DataHolder.sharedInstance.miPerfil = Perfil()
        DataHolder.sharedInstance.miPerfil?.Tipo = txtTipo?.selectedSegmentIndex
        
        
        let uid = DataHolder.sharedInstance.uid
        DataHolder.sharedInstance.insertarPerfil(perfil: DataHolder.sharedInstance.miPerfil!, userId:uid!)
        
        if(DataHolder.sharedInstance.miPerfil?.Tipo == 1){
            self.performSegue(withIdentifier: "transicionPerfilTienda", sender: self)
        }
        else if(DataHolder.sharedInstance.miPerfil?.Tipo == 0){
            self.performSegue(withIdentifier: "transicionPerfilUsuario", sender: self)
            
        }

        //self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
