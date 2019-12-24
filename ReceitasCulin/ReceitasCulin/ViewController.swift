//
//  ViewController.swift
//  ReceitasCulin
//
//  Created by Joao on 23/12/2019.
//  Copyright © 2019 Isec. All rights reserved.
//

import UIKit

protocol AtualizaReceita{
    
    func UpdateRData()
    //func atualizaContacto(contacto: Contacto)
    // adicionar o que for necessario para comunicaçao para a scene anterior
    
}

class ViewController: UIViewController {

    @IBOutlet weak var Nameoutlet: UITextField!
    @IBOutlet weak var Tempoconfoutlet: UITextField!
    @IBOutlet weak var Descrioutlet: UITextView!
    let app = UIApplication.shared.delegate as! AppDelegate
    var delegateback : AtualizaReceita?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func BtnPress(_ sender: Any) {
        
        // ! a frente de var tipo (...)? para retirar o erro de poder ser null
        
        let nome = Nameoutlet.text
        let tempoString = Tempoconfoutlet.text
        let descrip = Descrioutlet.text
        
        if(nome == "" || tempoString == "" || descrip == ""){
            let alert = UIAlertController(title: "Alerta", message: "Obrigatório escrever em todas as caixas de texto", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let tempo:Double? = Double(tempoString!) // converte pra Int
        
        if(tempo == nil){
            let alert = UIAlertController(title: "Alerta", message: "Entre uma numero valido na caixa de tempo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        app.listaReceitas.append(Receita.init(nome: nome!, categoria: "String", temporealiz: tempo!, ingredienes: [], desc: descrip!))
        //return
        delegateback?.UpdateRData()
        
        navigationController?.popViewController(animated: true)
    }
    

}

