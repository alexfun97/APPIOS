//
//  Cocktails.swift
//  SHISH&COMPANY
//
//  Created by Alejandro Martín-Serrano Vera on 21/6/17.
//  Copyright © 2017 Daniel de la Iglesia, Alejandro Martín. All rights reserved.
//

import UIKit

class Cocktails: NSObject {
    var Imagen:UIImage?
    var Nombre:String?
    var Descripcion:String?
    
    override init() {
        
    }
    
    init(valores:[String:AnyObject]) {
        Imagen = valores ["Imagen"] as? UIImage
        Nombre = valores ["Nombre"] as? String
        Descripcion = valores ["Descripcion"] as? String
    }
    
    
}
