//
//  FeedViewController.swift
//  Firebase_Project
//
//  Created by Fazlı Koç on 28.09.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    var imageArray = [String]()
//    var commentArray = [String]()
//    var emailArray = [String]()

    var postArray = [Post]()

    let notFound404: String = "https://www.natro.com/hosting-sozlugu/wp-content/uploads/2015/12/404-not-found.png"


    func getFirebaseData() {
        let firebaseDb = Firestore.firestore()
        firebaseDb.collection("Post").whereField("email", isEqualTo: "samo@gmail.com").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "hata var")
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil {
//                    self.emailArray.removeAll(keepingCapacity: false)
//                    self.commentArray.removeAll(keepingCapacity: false)
//                    self.imageArray.removeAll(keepingCapacity: false)
                    self.postArray.removeAll(keepingCapacity: false)

                    for doc in snapshot!.documents {
//                        let docId = doc.documentID
                        if let imageURL = doc.get("imageURL") as? String {
                            if let comment = doc.get("comment") as? String {
                                if let email = doc.get("email") as? String {
                                    let post = Post(email: email, comment: comment, imageUrl: imageURL)
                                    self.postArray.append(post)
                                }
                            }
                        }
                        else {
                            if let comment = doc.get("comment") as? String {
                                if let email = doc.get("email") as? String {
                                    let post = Post(email: email, comment: comment, imageUrl: self.notFound404)
                                    self.postArray.append(post)

                                }
                            } }




                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell

        cell.emailLabel.text = postArray[indexPath.row].email
        cell.commentLabel.text = postArray[indexPath.row].comment
        cell.imageCell.sd_setImage(with: URL(string: postArray[indexPath.row].imageUrl))
//        cell.emailLabel.text = emailArray[indexPath.row]
//        cell.commentLabel.text = commentArray[indexPath.row]
//        cell.imageCell.sd_setImage(with: URL(string: imageArray[indexPath.row]))
        return cell
    }


    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getFirebaseData()
    }



}
