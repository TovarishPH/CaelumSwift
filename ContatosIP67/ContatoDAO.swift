//
//  ContatoDAO.swift
//  ContatosIP67
//
//  Created by ios8043 on 1/5/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ContatoDAO: CoreDataUtil {

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
        //Carrega os dados na inicializacao do app
        self.inserirDadosIniciais()
        print("Caminho do DB: \(NSHomeDirectory())")
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
    
    //Busca a Posicao de um contato
    func buscaPosicaoDoContato(_ contato:Contato) -> Int {
        return contatos.index(of: contato)!
    }
    
    func inserirDadosIniciais() {
        let configuracoes = UserDefaults.standard
        
        let dadosInseridos = configuracoes.bool(forKey: "dados_inseridos")
        
        if !dadosInseridos {
            let caelumSP = NSEntityDescription.insertNewObject(forEntityName: "Contato", into: self.persistentContainer.viewContext) as! Contato
            
            caelumSP.nome = "Caelum SP"
            caelumSP.endereco = "Sao Paulo, SP, Rua Vergueiro, 3185"
            caelumSP.telefone = "01155712751"
            caelumSP.site = "http://www.caelum.com.br"
            caelumSP.latitude = -23.5883034
            caelumSP.longitude = -46.632369
            
            self.saveContext()
            
            configuracoes.set(true, forKey: "dados_inseridos")
            
            configuracoes.synchronize()
        }
    }
    
}
