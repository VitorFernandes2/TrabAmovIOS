//
//  SettingViewController.swift
//  ReceitasCulin
//
//  Created by test on 24/12/2019.
//  Copyright © 2019 Isec. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController{
    
    @IBOutlet weak var Val: UITextField!
    let app = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func add(_ sender: Any) {
        
        let nome = Val.text
        
        if(nome == ""){
            return
        }
        
        Receita.categorias.append(nome!)
        
    }
    @IBAction func Remov(_ sender: Any) {
        
        let nome = Val.text
        var i : Int = 0
        
        for c in Receita.categorias{
            
            if(c == nome!){
                Receita.categorias.remove(at: i)
                return
            }
            i += 1
        }
        
        
    }
    
}
