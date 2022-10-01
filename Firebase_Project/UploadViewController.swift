//
//  UploadViewController.swift
//  Firebase_Project
//
//  Created by Fazlı Koç on 28.09.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()


        imageView.isUserInteractionEnabled = true
        let gestureImage = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureImage)

    }

    @objc func selectImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey: Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }


    @IBAction func uploadAction(_ sender: Any) {

        let storge = Storage.storage()
        let storageRef = storge.reference()

        let mediaFolder = storageRef.child("Media")

        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {

            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).png")

            imageRef.putData(data) { storeageMeta, error in
                if error != nil {
                    self.hataMesajı("Hata", error?.localizedDescription ?? "Hata Var")
                }
                else {
                    imageRef.downloadURL { url, error in
                        if error == nil {
                            let urlString = url?.absoluteString

                            if let urlString = urlString {
                                let storePost = ["imageURL": urlString,"comment": self.commentField.text , "email": Auth.auth().currentUser!.email,"date": FieldValue.serverTimestamp()] as [String : Any]

                                let fireStoreDb = Firestore.firestore()
                                fireStoreDb.collection("Post").addDocument(data: storePost) { error in
                                    if error != nil{
                                        self.hataMesajı("Hata", error?.localizedDescription ?? "Hata geldi")
                                    }
                                    else{
                                        self.imageView.image = UIImage(named: "SelectPhoto")
                                        self.commentField.text = ""

                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }



                        }
                    }
                }
            }


        }

    }

    func hataMesajı(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKButton)
        self.present(alert, animated: true, completion: nil)
    }
}
