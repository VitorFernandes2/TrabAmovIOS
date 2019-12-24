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

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var Catinpt: UITextField!
    @IBOutlet weak var InfVT: UITableView!
    @IBOutlet weak var Nameoutlet: UITextField!
    @IBOutlet weak var Tempoconfoutlet: UITextField!
    @IBOutlet weak var Descrioutlet: UITextView!
    let app = UIApplication.shared.delegate as! AppDelegate
    var delegateback : AtualizaReceita?
    let pickerTipo = UIPickerView()
    var Ingredientestemp: [Ingrediente] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerTipo.dataSource = self
        pickerTipo.delegate = self
        Catinpt.inputView = pickerTipo
        self.InfVT.delegate = self
        self.InfVT.dataSource = self
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
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  Receita.categorias.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Receita.categorias[row]  // necessario pra mostrar os valores da lista em vez de ?
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Catinpt.text = Receita.categorias[row] // necessario pra meter na textbox o valor selecianado
    }
    
    
    @IBAction func Oncatselect(_ sender: Any) {
        
        pickerTipo.selectRow(Receita.categorias.firstIndex(of: Catinpt.text!) ?? 0, inComponent: 0, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Receita.categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngIdent", for: indexPath)
        
        cell.textLabel?.text = Receita.categorias[indexPath.row]
        
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let row = indexPath.row
            Receita.categorias.remove(at: row)
            
            tableView.reloadData()
            
        } else if editingStyle == .insert {

        }
    }
    
    /*
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return  Receita.categorias.count
     }
     
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return Receita.categorias[row]  // necessario pra mostrar os valores da lista em vez de ?
     }
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         tfTipo.text = Receita.categorias[row] // necessario pra meter na textbox o valor selecianado
     }
     */
    
    
}

