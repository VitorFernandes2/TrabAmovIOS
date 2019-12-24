//
//  CatViewController.swift
//  ReceitasCulin
//
//  Created by test on 24/12/2019.
//  Copyright © 2019 Isec. All rights reserved.
//

import Foundation

import UIKit

class CatViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var Addtextfield: UITextField!
    @IBOutlet weak var Remtextfield: UITextField!
    @IBOutlet weak var tfTipo: UITextField!
    @IBOutlet weak var newval: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let app = UIApplication.shared.delegate as! AppDelegate
    let pickerTipo = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerTipo.dataSource = self
        pickerTipo.delegate = self
        tfTipo.inputView = pickerTipo
    }
    
    @IBAction func Remfunc(_ sender: Any) {
        
        let nome = Remtextfield.text
        var i : Int = 0
        
        if(nome == "" || nome == nil){ // ve se o valor ou é vazio ou null
            let alert = UIAlertController(title: "Alerta", message: "Categoria Invalida", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Erro, nome invalido no rem")
            }))
            self.present(alert, animated: true, completion: nil)
            clearvalores()
            return
        }
        
        for b in app.listaReceitas{ // procura se existem receitas com a categoria
            
            if(b.categoria == nome!){
                let alert = UIAlertController(title: "Alerta", message: "Existem receitas anexadas a esta categoria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("Erro, ligacao a receitas")
                }))
                self.present(alert, animated: true, completion: nil)
                clearvalores()
                return
            }
        }
        
        
        for c in Receita.categorias{ // ve se já existe algum valor na lista de categoria
            
            if(c == nome!){
                Receita.categorias.remove(at: i)
                let alert = UIAlertController(title: "Sucesso", message: "A Categoria foi removida com sucesso", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
                clearvalores()
                return
            }
            i += 1
        }
        
        let alert = UIAlertController(title: "Alerta", message: "Não foi encontrada a Categoria definida", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("Erro, nome invalido no rem")
        }))
        self.present(alert, animated: true, completion: nil)
        clearvalores()
        return
        
    }
    @IBAction func addfunc(_ sender: Any) {
        
        let nome = Addtextfield.text
        
        if(nome == "" || nome == nil){
            let alert = UIAlertController(title: "Alerta", message: "Categoria Invalida", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Erro, nome invalido no add")
            }))
            self.present(alert, animated: true, completion: nil)
            clearvalores()
            return
        }
        
        var a : Int = 0
        for c in Receita.categorias{
            
            if(c == nome!){
                a += 1
            }
            
        }
        
        if(a == 0){
            Receita.categorias.append(nome!)
            let alert = UIAlertController(title: "Sucesso", message: "A Categoria foi adicionada com sucesso", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            clearvalores()
            return
        } else {
            let alert = UIAlertController(title: "Alerta", message: "Já existe uma categoria com o nome definido", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Erro, ja existe valor no add")
            }))
            self.present(alert, animated: true, completion: nil)
            clearvalores()
            return
        }
        
        
    }

    
    @IBAction func Editfunc(_ sender: Any) {
        
        let escolhe = tfTipo.text
        let editar = newval.text
        
        if(escolhe == "" || escolhe == nil || editar == "" || editar == nil){
            let alert = UIAlertController(title: "Alerta", message: "Categoria Invalida", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Erro, nome invalido no edit")
            }))
            self.present(alert, animated: true, completion: nil)
            clearvalores()
            return
        }
        
        for c in Receita.categorias{ // ve se já existe algum valor na lista de categoria
            
            if(c == editar!){
                let alert = UIAlertController(title: "Alerta", message: "Novo valor já existe nas categorias", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("Erro, nome ja existe no edit")
                }))
                self.present(alert, animated: true, completion: nil)
                clearvalores()
                return
            }
        }
        
        var pos : Int = 0
        for b in Receita.categorias{ // procura posicao de valor
            
            if(b == escolhe!){
                
                Receita.categorias.remove(at: pos)
                Receita.categorias.insert(editar!, at: pos)
                
                let alert = UIAlertController(title: "Sucesso", message: "A Categoria foi editada com sucesso", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
                clearvalores()
                return
            }
            pos += 1
        }
        
        
        
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
        tfTipo.text = Receita.categorias[row] // necessario pra meter na textbox o valor selecianado
    }
    
    @IBAction func Onvalselect(_ sender: Any) {
        
        pickerTipo.selectRow(Receita.categorias.firstIndex(of: tfTipo.text!) ?? 0, inComponent: 0, animated: false)
        
    }
    
    
    func clearvalores(){
        Addtextfield.text = ""
        Remtextfield.text = ""
        tfTipo.text = ""
        newval.text = ""
        
    }
}
