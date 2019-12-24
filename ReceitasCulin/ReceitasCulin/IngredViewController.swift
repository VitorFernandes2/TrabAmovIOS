//
//  IngredViewController.swift
//  ReceitasCulin
//
//  Created by test on 24/12/2019.
//  Copyright © 2019 Isec. All rights reserved.
//

import Foundation
import UIKit

protocol IngreReturns{
    
    func UpdateIngData(ingret : Ingrediente)
    //func atualizaContacto(contacto: Contacto)
    // adicionar o que for necessario para comunicaçao para a scene anterior
    
}

class IngredViewController: UIViewController{
    
    @IBOutlet weak var Nomeout: UITextField!
    @IBOutlet weak var quantout: UITextField!
    @IBOutlet weak var UnidOut: UITextField!
    var delegateing : IngreReturns?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func Addbtn(_ sender: Any) {
        
        let nome = Nomeout.text
        let quant = quantout.text
        let Unidade = UnidOut.text
        
        if(nome == nil || nome == "" || quant == nil || quant == "" || Unidade == nil || Unidade == ""){
            let alert = UIAlertController(title: "Alerta", message: "Todas as entradas teem de ser preenchidas", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //let quanto:Decimal? = Decimal(quant!) // converte pra decimal
        
        let result = Decimal(string: quant!) // converte pra decimal
        
        if(result == nil){
            let alert = UIAlertController(title: "Alerta", message: "Entre uma numero valido na caixa de quantidade", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let ingret : Ingrediente = Ingrediente.init(Nome: nome!, quant: result!, Uni: Unidade!)
        
        delegateing?.UpdateIngData(ingret : ingret)
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
}
