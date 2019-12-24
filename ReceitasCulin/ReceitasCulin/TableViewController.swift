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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return app.listaReceitas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceitasIdent", for: indexPath)
        
        // Configure the cell...
        /*var abc : String = " "
        for c in Receita.categorias{
            abc += c
        }
        
        cell.textLabel?.text = abc
        cell.detailTextLabel?.text = app.listaReceitas[indexPath.row].categoria*/
        
        cell.textLabel?.text = 	app.listaReceitas[indexPath.row].nome
        cell.detailTextLabel?.text = app.listaReceitas[indexPath.row].categoria
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let row = indexPath.row
        //let nome = app.listaReceitas[indexPath.row]
        
        performSegue(withIdentifier: "adicionarsegue", sender: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let row = indexPath.row
            app.listaReceitas.remove(at: row)
            
            tableView.reloadData()
            //tableView.deleteRows(at: [indexPath], with: .fade)
            print(2)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            print(1)
        }    
    }
    

    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */
	
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
    }
    

    func UpdateRData() {
        print(3)
       tableView.reloadData()
    }
    
}
