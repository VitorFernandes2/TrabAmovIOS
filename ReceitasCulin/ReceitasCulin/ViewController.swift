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

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource, IngreReturns{
    
    
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
        let cate = Catinpt.text
        
        if(nome == "" || tempoString == "" || descrip == "" || cate == ""){
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
        
        if(Ingredientestemp.count == 0){
            let alert = UIAlertController(title: "Alerta", message: "Defina ingredientes para a receita", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        
        app.listaReceitas.append(Receita.init(nome: nome!, categoria: cate!, temporealiz: tempo!, ingredienes: Ingredientestemp, desc: descrip!))
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
        return Ingredientestemp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngIdent", for: indexPath)
        
        let valInt = NSDecimalNumber(decimal: Ingredientestemp[indexPath.row].quant).intValue
        
        let output = Ingredientestemp[indexPath.row].nome + "  -  " + String(valInt) + Ingredientestemp[indexPath.row].Uni
        
        cell.textLabel?.text = output
        
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let row = indexPath.row
            Ingredientestemp.remove(at: row)
            
            tableView.reloadData()
            
        } else if editingStyle == .insert {

        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Ingsegue"{
            let vc = segue.destination as! IngredViewController // definir o proprio vew controler... com view controller generis nao encontre o dellegate certo
            vc.delegateing = self
            // NECESSARIO , sem isto o protocol do view controler nao funciona

        }
    }
    
    func UpdateIngData(ingret : Ingrediente) {
        //print(3)
        Ingredientestemp.append(ingret)
        InfVT.reloadData()
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
}

