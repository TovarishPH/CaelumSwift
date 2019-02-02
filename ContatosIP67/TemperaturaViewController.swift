//
//  TemperaturaViewController.swift
//  ContatosIP67
//
//  Created by ios8043 on 2/2/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit

class TemperaturaViewController: UIViewController {

    @IBOutlet weak var labelCondicaoAtual: UILabel!
    @IBOutlet weak var labelTemperaturaMinima: UILabel!
    @IBOutlet weak var labelTemperaturaMaxima: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let URL_BASE = "https://api.openweathermap.org/data/2.5/weather?APPID=2e4ac28e67124ec30b70b8c9771fdf13&units=metric"
    let URL_IMAGE = "https://openweathermap.org/img/w/"
    
    var contato: Contato?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let contato = self.contato {
            if let endpoint = URL(string: URL_BASE + "&lat=\(contato.latitude ?? 0)&lon=\(contato.longitude ?? 0)") {
                let session = URLSession(configuration: default)
                print(endpoint)
                let task = session.dataTask(with: endpoint) {(data, response, error) in
                    if let httpResponse =  response as? HTTPURLResponse {
                        if httpResponse.statusConde == 200 {
                            do {
                                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject] {
                                    let main = json["main"] as! [String:AnyObject]
                                    let weather = json["weather"]![0] as! [String:AnyObject]
                                    let temp_min = json["temp_min"] as! Double
                                    let temp_max = json["temp_max"] as! Double
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
