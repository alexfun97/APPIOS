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


class DataHolder: NSObject {
    var uid:String?
    
    static let sharedInstance:DataHolder=DataHolder()
    
    var firDatabaseRef: FIRDatabaseReference!
    var firStorage:FIRStorage?
    var firStorageRef:FIRStorageReference?
    var miPerfil:Perfil?
    var miShisha:Shishas?
    
    
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
    
}
