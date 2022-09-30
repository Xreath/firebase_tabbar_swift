//
//  SettingViewController.swift
//  Firebase_Project
//
//  Created by Fazlı Koç on 28.09.2022.
//

import UIKit
import Firebase
class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func logOutAction(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }
        catch{
            print("Çıkış yapılamadı")
        }
         
    }
}
