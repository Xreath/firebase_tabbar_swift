//
//  ViewController.swift
//  Firebase_Project
//
//  Created by Fazlı Koç on 28.09.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var passField: UITextField!

    @IBOutlet weak var headTitle: UILabel!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keybordClose))

        view.addGestureRecognizer(gestureRecognizer)

    }


    @objc func keybordClose() {
        view.endEditing(true)
    }


    @IBAction func girisYap(_ sender: Any) {
        if emailField.text != "" && passField.text != "" {
            Auth.auth().signIn(withEmail: emailField.text!, password: passField.text!) { authdata, error in
                if error != nil {
                    self.hataMesajı("Hata", error?.localizedDescription ?? "Hata Aldınız Tekrar Deneyin")
                }
                else {
                    self.performSegue(withIdentifier: "tabBarVC", sender: nil)
                }
            }

        }
        else {
            hataMesajı("Hata", "Kullanıcı adı ve Şifre giriniz")
        }
    }

    @IBAction func kayitOl(_ sender: Any) {
        if emailField.text != "" && passField.text != "" {
            Auth.auth().createUser(withEmail: emailField.text!, password: passField.text!) { authdata, error in
                if error != nil {
                    self.hataMesajı("Hata", error?.localizedDescription ?? "Hata Aldınız Tekrar Deneyin")


                }
                else {
                    self.performSegue(withIdentifier: "tabBarVC", sender: nil)
                }
            }

        }
        else {
            hataMesajı("Hata", "Kullanıcı adı ve Şifre giriniz")
        }
    }


    func hataMesajı(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKButton)
        self.present(alert, animated: true, completion: nil)
    }
}

