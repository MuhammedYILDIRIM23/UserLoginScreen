//
//  MasterPageVC.swift
//  UserLoginScreen
//
//  Created by Muhammed YILDIRIM  on 30.05.2021.
//

import UIKit
import Parse

class MasterPageVC: UIViewController {
    
    @IBOutlet weak var logoutButtonClicked: UIButton! {
        didSet {
            LogoutButton()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func LogoutButton() {
        logoutButtonClicked.backgroundColor = .white
        logoutButtonClicked.layer.cornerRadius = 20
        logoutButtonClicked.layer.shadowColor = UIColor.gray.cgColor
        logoutButtonClicked.layer.shadowOpacity = 0.75
        logoutButtonClicked.layer.shadowOffset = .zero
        logoutButtonClicked.layer.shadowRadius = 5
        logoutButtonClicked.layer.shadowPath = UIBezierPath(roundedRect: logoutButtonClicked.bounds,
                                                            cornerRadius: logoutButtonClicked.layer.cornerRadius).cgPath
    }
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOutInBackground { err in
            if err != nil {
                let alert = UIAlertController(title: "ERROR", message: err?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "toLogoutVC", sender: nil)
            }
        }
    }
}
