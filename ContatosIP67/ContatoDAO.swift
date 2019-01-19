//
//  ContatoDAO.swift
//  ContatosIP67
//
//  Created by ios8043 on 1/5/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit
import Foundation

class ContatoDAO: NSObject {

    static private var defaultDAO: ContatoDAO!
    var contatos: Array<Contato>
    
    func adiciona(_ contato:Contato){
        contatos.append(contato)
        print(contatos)
    }
    
    static func sharedInstance() -> ContatoDAO {
        if defaultDAO == nil {
          defaultDAO = ContatoDAO()
        }
        return defaultDAO
    }
    
    override private init() {
        self.contatos = Array()
        super.init()
    }
    
    func listaTodos() -> [Contato] {
        return contatos
    }
    
    func buscaContatoNaPosicao(_ posicao:Int) -> Contato {
        return contatos[posicao]
    }
    
    func remove(_ posicao:Int) {
        contatos.remove(at:posicao)
    }
    
}
