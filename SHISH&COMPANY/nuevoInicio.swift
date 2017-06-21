//
//  nuevoInicio.swift
//  SHISH&COMPANY
//
//  Created by Daniel de la Iglesia Gonzalez on 18/5/17.
//  Copyright © 2017 Daniel de la Iglesia, Alejandro Martín. All rights reserved.
//

import UIKit

class nuevoInicio: NSObject {
    var Nombre:String?
    var Tipo:Int?
    
    init(Perfiles:[String:AnyObject]) {
        Nombre = Perfiles ["Nombre"] as? String
        Tipo = Perfiles ["Tipo"] as? Int
    }
}
