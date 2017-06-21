//
//  VCInicioNuevo.swift
//  SHISH&COMPANY
//
//  Created by Daniel de la Iglesia Gonzalez on 18/5/17.
//  Copyright © 2017 Daniel de la Iglesia, Alejandro Martín. All rights reserved.
//

import UIKit

class VCInicioNuevo: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var perfil:Perfil?
    @IBOutlet var txtTipo:UISegmentedControl?
    @IBOutlet var imgview:UIImageView?
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    
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
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imgview?.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }

    @IBAction func accionBotonAceptar(){
        DataHolder.sharedInstance.miPerfil = Perfil()
        DataHolder.sharedInstance.miPerfil?.Imagen = imgview?.image
        DataHolder.sharedInstance.miPerfil?.Tipo = txtTipo?.selectedSegmentIndex
        
        
        let uid = DataHolder.sharedInstance.uid
        DataHolder.sharedInstance.insertarPerfil(perfil: DataHolder.sharedInstance.miPerfil!, userId:uid!)
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
