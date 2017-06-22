//
//  DataHolder.swift
//  SHISH&COMPANY
//
//  Created by Daniel de la Iglesia Gonzalez on 27/4/17.
//  Copyright © 2017 Daniel de la Iglesia, Alejandro Martín. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage


class DataHolder: NSObject, ListaShishas {
    var uid:String?
    
    static let sharedInstance:DataHolder=DataHolder()
    
    var firDatabaseRef: FIRDatabaseReference!
    var firStorage:FIRStorage?
    var firStorageRef:FIRStorageReference?
    var miPerfil:Perfil?
    var miShisha:Shishas?
    var miCocktail:Cocktails?
    var nShishas:Int?
    var numeroShishas:Int?
    var nCocktails:Int?
    var numeroCocktails:Int?
    
    
    func initFirebase() {
        FIRApp.configure()
        firDatabaseRef = FIRDatabase.database().reference()
        firStorage = FIRStorage.storage()
        firStorageRef = firStorage?.reference()
    }
    
    func insertarPerfil(perfil:Perfil,userId uid:String){
        let rutaTemp = String(format: "/Perfiles/%@",uid)
        let childUpdates = [rutaTemp:perfil.getPerfil()]
        firDatabaseRef.updateChildValues (childUpdates)
    }
    
    func cargarShishasYCocktails(delegate: ListaShishas) {
        firDatabaseRef.child("Shishas/" + (FIRAuth.auth()?.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.nShishas = value?.count
            self.CocktailsDelegate(delegate: delegate, nShishas: self.nShishas!)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func CocktailsDelegate(delegate: ListaShishas, nShishas: Int)  {
        firDatabaseRef.child("Cocktails/" + (FIRAuth.auth()?.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.nCocktails = value?.count
            delegate.ShishasDelegate!(nShishas: nShishas, nCocktails: self.nCocktails!)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

@objc protocol ListaShishas{
    @objc optional func ShishasDelegate(nShishas:Int, nCocktails: Int)
    @objc optional func CocktailsDelegate(delegate: ListaShishas, nShishas: Int)
}
