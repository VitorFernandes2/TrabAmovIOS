//
//  CatViewController.swift
//  ReceitasCulin
//
//  Created by test on 24/12/2019.
//  Copyright © 2019 Isec. All rights reserved.
//

import Foundation

import UIKit

class CatViewController: UIViewController{
    
    @IBOutlet weak var Addtextfield: UITextField!
    @IBOutlet weak var Remtextfield: UITextField!
    let app = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Remfunc(_ sender: Any) {
        
        let nome = Remtextfield.text
        var i : Int = 0
        
        for c in Receita.categorias{
            
            if(c == nome!){
                Receita.categorias.remove(at: i)
                return
            }
            i += 1
        }
        
    }
    @IBAction func addfunc(_ sender: Any) {
        
        let nome = Addtextfield.text
        
        if(nome == ""){
            return
        }
        
        Receita.categorias.append(nome!)
        
    }

    
}
