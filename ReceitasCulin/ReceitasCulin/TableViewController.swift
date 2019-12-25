//
//  TableViewController.swift
//  ReceitasCulin
//
//  Created by Joao on 23/12/2019.
//  Copyright © 2019 Isec. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, AtualizaReceita{

    //var emptyDoubles: [Receita] = []
    let app = UIApplication.shared.delegate as! AppDelegate
    var pos : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Tamanho do array : " , app.listaReceitas.count)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Receita.categorias.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var count = 0
        for c in app.listaReceitas{
            
            if(c.categoria == Receita.categorias[section]){
                count += 1
            }
            
        }
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Receita.categorias[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceitasIdent", for: indexPath)
        
        let section = indexPath.section
        let row = indexPath.row
        //let contato = itens[categorias[section]]![row]//contacto na linha row, da secao section
        var pos : Int = 0
        for c in app.listaReceitas{
            
            if(c.categoria == Receita.categorias[section]){
                if(pos == row){
                    cell.textLabel?.text = c.nome
                    cell.detailTextLabel?.text = c.categoria
                    return cell
                }else{
                    pos += 1
                }
            }
        }

        //cell.textLabel?.text = 	app.listaReceitas[indexPath.row].nome
        //cell.detailTextLabel?.text = app.listaReceitas[indexPath.row].categoria
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let row = indexPath.row
        //let nome = app.listaReceitas[indexPath.row]
        let section = indexPath.section
        let row = indexPath.row
        var posi : Int = 0
        var posarray : Int = 0
        for c in app.listaReceitas{
            if(c.categoria == Receita.categorias[section]){
                if(posi == row){
                    pos = String(posarray)
                    performSegue(withIdentifier: "editviewsegue", sender: pos)
                    return
                }else{
                    posi += 1
                }
            }
            posarray += 1
        }
        
        
        //pos = String(indexPath.row)
        //performSegue(withIdentifier: "editviewsegue", sender: pos)
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let section = indexPath.section
            let row = indexPath.row
            var posi : Int = 0
            var posarray : Int = 0
            for c in app.listaReceitas{
                if(c.categoria == Receita.categorias[section]){
                    if(posi == row){
                        let rowe = posarray
                        app.listaReceitas.remove(at: rowe)
                        tableView.reloadData()
                        return
                    }else{
                        posi += 1
                    }
                }
                posarray += 1
            }
            
            
            /*let row = indexPath.row
            app.listaReceitas.remove(at: row)
            
            tableView.reloadData()*/

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            //print(1)
        }    
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "adicionarsegue"{
            let vc = segue.destination as! ViewController
            vc.delegateback = self
            // NECESSARIO , sem isto o protocol do view controler nao funciona

        }
        if segue.identifier == "editviewsegue"{ // para o editviewcontroller tb tem acesso
            let vc = segue.destination as! EditViewController
            vc.delegateback = self
            // NECESSARIO , sem isto o protocol do view controler nao funciona

        }
        
        
        if segue.destination is EditViewController
        {
            let vc = segue.destination as? EditViewController
            vc?.posicao = self.pos
        }
    }
    

    func UpdateRData() {
        print(3)
       tableView.reloadData()
    }
    
}
