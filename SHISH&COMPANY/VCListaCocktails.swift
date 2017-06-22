//
//  VCListaCocktails.swift
//  SHISH&COMPANY
//
//  Created by Alejandro Martín-Serrano Vera on 22/6/17.
//  Copyright © 2017 Daniel de la Iglesia, Alejandro Martín. All rights reserved.
//

import UIKit
import Firebase

class VCListaCocktails: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var TableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Aqui quiero hacer return de el numero de shishas que hay
        return DataHolder.sharedInstance.numeroCocktails!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Y aquí es donde quiero cambiar los labels y la imagenview de celdaProducto para tener una diferente por cada shisha puesta en Firebase
        let celda:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "celdaCocktails")!
        //celda.contentView.
        return celda
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
