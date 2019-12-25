//
//  Receita.swift
//  ReceitasCulin
//
//  Created by Joao on 23/12/2019.
//  Copyright © 2019 Isec. All rights reserved.
//

import Foundation
extension Double {
    
    func roundValue(_ casasDecimais: Int ) -> Double{
        let fator = pow(10, Double(casasDecimais))
        return (self * fator + 0.5).rounded() / fator
    }
    
}

class Receita : Codable {
    
    static var categorias = ["Entrada","Sopa","Carne","Peixe","Sobremesa"].sorted()
    var nome : String
    var categoria : String
    var temporealiz : Double
    var Ingredientes: [Ingrediente] = []
    var desc : String
    
    init(nome : String, categoria : String , temporealiz : Double, ingredienes : [Ingrediente] , desc : String) {
        self.nome = nome
        self.categoria = categoria
        self.temporealiz = temporealiz
        self.Ingredientes = ingredienes
        self.desc = desc
    }
    
    /*convenience init(<#parameters#>) {
        <#statements#>
    }*/
    
}

class Ingrediente : Codable {
    
    var nome : String
    var quant : Decimal
    var Uni : String
    
    init(Nome : String, quant : Decimal, Uni : String) {
        self.nome = Nome
        self.quant = quant
        self.Uni = Uni
    }
    
    
}
