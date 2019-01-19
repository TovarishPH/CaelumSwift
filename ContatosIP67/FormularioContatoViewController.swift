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
    
    var contato: Contato!
    var dao:ContatoDAO
    
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContatoDAO.sharedInstance()
        
        super.init(coder: aDecoder)
    }
    
    func pegaDadosDoFormulario() {
        /*let nome = self.nome.text!
        let telefone = self.telefone.text!
        let endereco = self.endereco.text!
        let site = self.site.text!
        
        print("Nome: \(nome), Telefone: \(telefone), Endereço: \(endereco), Site: \(site)")*/
        
        if contato == nil {
            self.contato = Contato()
        }
        
        self.contato.nome = self.nome.text!
        self.contato.telefone = self.telefone.text!
        self.contato.endereco = self.endereco.text!
        self.contato.site = self.site.text!
        
        //print(contato)
    }
    
    @IBAction func criaContato() {
        self.pegaDadosDoFormulario()
        dao.adiciona(contato)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func atualizaContato() {
        pegaDadosDoFormulario()
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if contato != nil {
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.site.text = contato.site
            
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = botaoAlterar
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

