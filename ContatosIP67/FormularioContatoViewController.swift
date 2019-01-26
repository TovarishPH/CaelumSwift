//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios8043 on 1/5/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var nome: UITextField!
    @IBOutlet var telefone: UITextField!
    @IBOutlet var endereco: UITextField!
    @IBOutlet var site: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var contato: Contato!
    var dao:ContatoDAO
    var delegate:FormularioContatoViewControllerDelegate?
    
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
        
        self.delegate?.contatoAdicionado(contato)
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func atualizaContato() {
        pegaDadosDoFormulario()
        
        self.delegate?.contatoAtualizado(contato)
        
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(selecionaFoto(sender:)))
        self.imageView.addGestureRecognizer(tap)
        
        //arredonda o formato da imageView
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
    }
    
    func selecionaFoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //camera disponivel
        } else {
            //usar biblioteca
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagemSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = imagemSelecionada
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

