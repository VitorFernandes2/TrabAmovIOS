//
//  EditViewController.swift
//  ReceitasCulin
//
//  Created by Joao on 25/12/2019.
//  Copyright © 2019 Isec. All rights reserved.
//

import Foundation
import UIKit


class EditViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource, IngreReturns{
    
    // editviewsegue - nome do segue
    var posicao:String = ""
    let app = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var Nomeoutlet: UITextField!
    @IBOutlet weak var Categoriaoutlet: UITextField!
    @IBOutlet weak var TempodeConfecaooutlet: UITextField!
    @IBOutlet weak var TableViewoutlet: UITableView!
    @IBOutlet weak var Decricaooutlet: UITextView!
    @IBOutlet weak var Editbutton: UIBarButtonItem!
    @IBOutlet weak var addIngredientebtn: UIButton!
    let pickerTipo = UIPickerView()
    var delegateback : AtualizaReceita?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // desabilitar os textboxs e btns
        Nomeoutlet.isUserInteractionEnabled = false
        Categoriaoutlet.isUserInteractionEnabled = false
        TempodeConfecaooutlet.isUserInteractionEnabled = false
        Decricaooutlet.isUserInteractionEnabled = false
        addIngredientebtn.isHidden = true
        
        // defenir os valores em cada posicao
        let pos : Int? = Int(posicao)
        Nomeoutlet.text = app.listaReceitas[pos!].nome
        Categoriaoutlet.text = app.listaReceitas[pos!].categoria
        TempodeConfecaooutlet.text = String(app.listaReceitas[pos!].temporealiz)
        Decricaooutlet.text = app.listaReceitas[pos!].desc
        
        // picker view e table view
        pickerTipo.dataSource = self
        pickerTipo.delegate = self
        Categoriaoutlet.inputView = pickerTipo
        self.TableViewoutlet.delegate = self
        self.TableViewoutlet.dataSource = self
        
    }
    @IBAction func Edisavebtnclick(_ sender: Any) {
        
        if(Editbutton.title == "Edit"){
            // mudar visual
            Editbutton.title = "Save"
            Nomeoutlet.isUserInteractionEnabled = true
            Categoriaoutlet.isUserInteractionEnabled = true
            TempodeConfecaooutlet.isUserInteractionEnabled = true
            Decricaooutlet.isUserInteractionEnabled = true
            addIngredientebtn.isHidden = false
            
            
            return
        }
        if(Editbutton.title == "Save"){
            // mudar visual
            
            if (saveverif() == true){
                Editbutton.title = "Edit"
                Nomeoutlet.isUserInteractionEnabled = false
                Categoriaoutlet.isUserInteractionEnabled = false
                TempodeConfecaooutlet.isUserInteractionEnabled = false
                Decricaooutlet.isUserInteractionEnabled = false
                addIngredientebtn.isHidden = true
                delegateback?.UpdateRData()
            }
            
            return
        }
        
        
        
    }
    
    
    /*@IBAction func onaddingbtn(_ sender: Any) {
        
        performSegue(withIdentifier: "Ingsegue", sender: nil)
    }*/
    
    func saveverif() -> Bool{
        
        let nome = Nomeoutlet.text
        let categoria = Categoriaoutlet.text
        let tempconf = TempodeConfecaooutlet.text
        let Decri = Decricaooutlet.text
        let pos : Int? = Int(posicao)
        
        if(nome == "" || categoria == "" || tempconf == "" || Decri == ""){
            let alert = UIAlertController(title: "Alerta", message: "Obrigatório escrever em todas as caixas de texto", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        let tempo:Double? = Double(tempconf!) // converte pra Int
        
        if(tempo == nil){
            let alert = UIAlertController(title: "Alerta", message: "Entre uma numero valido na caixa de tempo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default ))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if(app.listaReceitas[pos!].Ingredientes.count == 0){
            let alert = UIAlertController(title: "Alerta", message: "Defina ingredientes para a receita", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return false
            
        }
        
        //edições
        app.listaReceitas[pos!].nome = nome!
        app.listaReceitas[pos!].categoria = categoria!
        app.listaReceitas[pos!].temporealiz = tempo!
        app.listaReceitas[pos!].desc = Decri!
        
        let alert = UIAlertController(title: "Sucesso", message: "Alterações definidas com sucesso", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
        self.present(alert, animated: true, completion: nil)
        
        return true
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
        Categoriaoutlet.text = Receita.categorias[row] // necessario pra meter na textbox o valor selecianado
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pos : Int? = Int(posicao)
        return app.listaReceitas[pos!].Ingredientes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pos : Int? = Int(posicao)
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditIngident", for: indexPath)
        
        let valInt = NSDecimalNumber(decimal: app.listaReceitas[pos!].Ingredientes[indexPath.row].quant).intValue
        
        let output = app.listaReceitas[pos!].Ingredientes[indexPath.row].nome + "  -  " + String(valInt) + app.listaReceitas[pos!].Ingredientes[indexPath.row].Uni
        
        cell.textLabel?.text = output
        
        return cell
    }
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(addIngredientebtn.isHidden == true){
            if editingStyle == .delete {
                // Delete the row from the data source
                let pos : Int? = Int(posicao)
                let row = indexPath.row
                app.listaReceitas[pos!].Ingredientes.remove(at: row)
                
                TableViewoutlet.reloadData()
                
            } else if editingStyle == .insert {

            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editingsegue"{
            let vc = segue.destination as! IngredViewController // definir o proprio vew controler... com view controller generis nao encontre o dellegate certo
            vc.delegateing = self
            // NECESSARIO , sem isto o protocol do view controler nao funciona

        }
    }
    
    func UpdateIngData(ingret : Ingrediente) {
        //print(3)
        let pos : Int? = Int(posicao)
        app.listaReceitas[pos!].Ingredientes.append(ingret)
        TableViewoutlet.reloadData()
    }
    
}
