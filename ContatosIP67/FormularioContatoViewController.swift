//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios8043 on 1/5/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController {

    @IBOutlet var nome: UITextField!
    @IBOutlet var telefone: UITextField!
    @IBOutlet var endereco: UITextField!
    @IBOutlet var site: UITextField!
    
    var dao:ContatoDAO
    
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContatoDAO.sharedInstance()
        
        super.init(coder: aDecoder)
    }
    
    @IBAction func pegaDadosDoFormulario() {
        /*let nome = self.nome.text!
        let telefone = self.telefone.text!
        let endereco = self.endereco.text!
        let site = self.site.text!
        
        print("Nome: \(nome), Telefone: \(telefone), Endereço: \(endereco), Site: \(site)")*/
        
        let contato: Contato = Contato()
        contato.nome = self.nome.text!
        contato.telefone = self.telefone.text!
        contato.endereco = self.endereco.text!
        contato.site = self.site.text!
        
        dao.adiciona(contato)
        //print(contato)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

