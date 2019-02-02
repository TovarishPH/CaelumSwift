//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios8043 on 1/5/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit
import CoreLocation

class FormularioContatoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var nome: UITextField!
    @IBOutlet var telefone: UITextField!
    @IBOutlet var endereco: UITextField!
    @IBOutlet var site: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var contato: Contato!
    var dao:ContatoDAO
    var delegate:FormularioContatoViewControllerDelegate?
    
    @IBAction func buscarCoordenadas(_ sender: UIButton) {
        self.loading.startAnimating()
        sender.isEnabled = false
        
        let geocoder = CLGeocoder()
        
        if self.endereco.text!.isEmpty {
            let alert = UIAlertController(title: "Endereco nao preenchidos", message: "Dados de endereco nao preenchidos", preferredStyle: .alert)
            let fechar = UIAlertAction(title: "Fechar", style: .cancel, handler: nil)
            alert.addAction(fechar)
            self.present(alert, animated: true, completion: nil)
        } else {
            geocoder.geocodeAddressString(self.endereco.text!) { (resultado, error) in
                if error == nil && (resultado?.count)! > 0 {
                    let placemark = resultado![0]
                    let coordenada = placemark.location!.coordinate
                    
                    self.latitude.text = coordenada.latitude.description
                    self.longitude.text = coordenada.longitude.description
                }
                self.loading.stopAnimating()
                sender.isEnabled = true
            }
        }           
        
    }
    
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
        self.contato.foto = self.imageView.image
        
        if let latitude = Double(self.latitude.text!) {
            self.contato.latitude = latitude as NSNumber
        }
        
        if let longitude = Double(self.longitude.text!) {
            self.contato.longitude = longitude as NSNumber
        }
        
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
            self.latitude.text = contato.latitude?.description
            self.longitude.text = contato.longitude?.description
            
            if let foto = contato.foto {
                self.imageView.image = foto
            }
            
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = botaoAlterar
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(selecionaFoto(sender:)))
        self.imageView.addGestureRecognizer(tap)
        
        //arredonda o formato da imageView
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        //imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
    }
    
    func selecionaFoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //camera disponivel
            //exercicio 14.7 - simulador nao possui camera para a execucao do exercicio
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

