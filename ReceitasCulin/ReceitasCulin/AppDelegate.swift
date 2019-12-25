//
//  AppDelegate.swift
//  ReceitasCulin
//
//  Created by Joao on 23/12/2019.
//  Copyright © 2019 Isec. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var listaReceitas : [Receita] = []
    var file : URL?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let urldir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true){
            file = urldir.appendingPathComponent("listaContactos.json")
            loadData()
            
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {//chamado quando é fechado
        saveData()
    }
    func applicationWillTerminate(_ application: UIApplication) {
        saveData()
    }
    
    func saveData(){
        guard let file = file else {
            return
        }
        
        if let data = try? JSONEncoder().encode(listaReceitas){
            //data.write(to: file) //assim já funciona
            let str = String(data: data, encoding: .utf8)
            //print("JSON a guardar : \(str)")
            do{
                try str?.write(to: file, atomically: true,encoding: .utf8)
            }catch{
                print("Erro a gravar dados")
            }
        }
    }

    func loadData(){
        
        listaReceitas = []
        guard let file = file else {
            return
        }
        
        guard let data = try? String(contentsOf: file).data(using: .utf8) else {return}
        
        if let listaRecs = try? JSONDecoder().decode([Receita].self, from: data) {
            self.listaReceitas = listaRecs
            
        }
    }
        



}

