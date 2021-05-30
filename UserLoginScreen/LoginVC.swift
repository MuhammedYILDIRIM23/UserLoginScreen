//
//  ViewController.swift
//  RamazanUserInterface
//
//  Created by Muhammed YILDIRIM  on 26.05.2021.
//

import UIKit
import Parse

class LoginVC: UIViewController {
    
    var iconClick = false

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            //Login button
            loginButtonFeatures()
        }
    }
    @IBOutlet weak var singupButton: UIButton! {
        didSet {
            //singup button
            singupButtonFeatures()

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        indicator.isHidden = true
        //TextField İcon
        textFieldIcon()
        //PasswordTextField Open-eye icon func
        passwordTextFieldEye()
    }
    @IBAction func loginButton(_ sender: Any) {
        
        if emailText.text != nil && passwordText.text != nil {
            indicator.isHidden = false
            indicator.startAnimating()
            PFUser.logInWithUsername(inBackground: self.emailText.text!, password: self.passwordText.text!) { user, err in
                self.indicator.stopAnimating()
                if err != nil {
                    self.alert(titleInput: "Error", messageInput: err?.localizedDescription ?? "ERROR")
                    self.indicator.isHidden = true
                } else {
                    self.indicator.isHidden = true
                    self.performSegue(withIdentifier: "toMasterPageVC", sender: nil)
                }
            }
            
        } else {
            self.alert(titleInput: "ERROR", messageInput: "email / password!!!")
        }
    }
    @IBAction func singupButton(_ sender: Any) {
        performSegue(withIdentifier: "toSingupVC", sender: nil)
    }
    func alert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    //BUttons özelleştirme
    func loginButtonFeatures() {
        //login button
        loginButton.backgroundColor = .white
        loginButton.layer.cornerRadius = 20
        loginButton.layer.shadowColor = UIColor.gray.cgColor
        loginButton.layer.shadowOpacity = 0.75
        loginButton.layer.shadowOffset = .zero
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowPath = UIBezierPath(roundedRect: loginButton.bounds, cornerRadius: loginButton.layer.cornerRadius).cgPath
    }
    func singupButtonFeatures() {
        // singup button
        singupButton.backgroundColor = .white
        singupButton.layer.cornerRadius = 20
        singupButton.layer.shadowColor = UIColor.gray.cgColor
        singupButton.layer.shadowOpacity = 0.75
        singupButton.layer.shadowOffset = .zero
        singupButton.layer.shadowRadius = 5
        singupButton.layer.shadowPath = UIBezierPath(roundedRect: loginButton.bounds, cornerRadius: loginButton.layer.cornerRadius).cgPath
    }
    func textFieldIcon()  {
        // E-mail textfield icon kodları...
        let emailIcon = UIImageView()
        emailIcon.image = UIImage(named: "mail")
        
        let emailContentView = UIView()
        emailContentView.addSubview(emailIcon)
        
        emailContentView.frame = CGRect(x: 10, y: 0, width:  20, height: 20)
        emailIcon.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        
        emailText.leftView = emailContentView
        emailText.leftViewMode = .always
        
        // Password textfield icon kodları...
        let passwordIcon = UIImageView()
        passwordIcon.image = UIImage(named: "password")
        
        let passwordContentView = UIView()
        passwordContentView.addSubview(passwordIcon)
        
        passwordContentView.frame = CGRect(x: 10, y: 0, width:  20, height: 20)
        passwordIcon.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        
        passwordText.leftView = passwordContentView
        passwordText.leftViewMode = .always
    }
    // PasswordTextField Open-eye
    func passwordTextFieldEye() {
        
        let openEye = UIImageView()
        openEye.image = UIImage(named: "open-eye")
        
        let openEyeContentView = UIView()
        openEyeContentView.addSubview(openEye)
        
        openEyeContentView.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        openEye.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        
        passwordText.rightView = openEyeContentView
        passwordText.rightViewMode = .always
        
        openEye.isUserInteractionEnabled = true
        let tapGestureReccognizer = UITapGestureRecognizer(target: self, action: #selector(textFieldEyeTapped))
        openEye.addGestureRecognizer(tapGestureReccognizer)
    }
    @objc func textFieldEyeTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tapOpenEye = tapGestureRecognizer.view as! UIImageView
        if iconClick {
            iconClick = false
            tapOpenEye.image = UIImage(named: "close-eye")
            passwordText.isSecureTextEntry = false
        } else {
            iconClick = true
            tapOpenEye.image = UIImage(named: "open-eye")
            passwordText.isSecureTextEntry = true
        }
    }
}
    









