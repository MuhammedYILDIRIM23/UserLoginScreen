//
//  SingupVC.swift
//  RamazanUserInterface
//
//  Created by Muhammed YILDIRIM  on 27.05.2021.
//

import UIKit
import Parse

class SingupVC: UIViewController {
    
    var iconClick = false

    @IBOutlet weak var singupEmailText: UITextField!
    @IBOutlet weak var singupUserText: UITextField!
    @IBOutlet weak var singupPasswordText: UITextField!
    @IBOutlet weak var singupRepeatPasswordText: UITextField!
    
    @IBOutlet weak var singupCreateAccountButton: UIButton! {
        didSet {
            CreateAccountFeatures()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TextField İcon
        textFieldIcon()

        // Password & RepeatPassword TextField Open-Eye icon
        passwordTextFieldEye()
        repeatPasswordTextFieldEye()

    }
    @IBAction func singupCreateAccountButton(_ sender: Any) {
        if singupEmailText.text != "" && singupUserText.text != "" && singupPasswordText.text != ""  {
            if singupPasswordText.text == singupRepeatPasswordText.text {
                let user = PFUser()
                user.email = singupEmailText.text!
                user.username = singupUserText.text!
                user.password = singupPasswordText.text!
                user.signUpInBackground { success, err in
                    if err != nil {
                        self.alert(titleInput: "ERROR", messageInput: err?.localizedDescription ?? "Error" )
                    } else {
                        let alert = UIAlertController(title: "Successfully", message: "Kayıt işlemi başarılı.", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "Back to login screen", style: .default) { UIAlertAction in
                            self.performSegue(withIdentifier: "toLoginVC", sender: nil)
                        }
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                self.alert(titleInput: "Error", messageInput: "Şifreler uyuşmamaktadır.!")
            }
        }
    }
    // Alert
    func alert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    func CreateAccountFeatures() {
        singupCreateAccountButton.backgroundColor = .white
        singupCreateAccountButton.layer.cornerRadius = 20
        singupCreateAccountButton.layer.shadowColor = UIColor.gray.cgColor
        singupCreateAccountButton.layer.shadowOpacity = 0.75
        singupCreateAccountButton.layer.shadowOffset = .zero
        singupCreateAccountButton.layer.shadowRadius = 5
        singupCreateAccountButton.layer.shadowPath = UIBezierPath(roundedRect: singupCreateAccountButton.bounds,
                                                                  cornerRadius: singupCreateAccountButton.layer.cornerRadius).cgPath
    }
    func textFieldIcon()  {
        // E-mail textfield icon kodları...
        let emailIcon = UIImageView()
        emailIcon.image = UIImage(named: "mail")
        
        let emailContentView = UIView()
        emailContentView.addSubview(emailIcon)
        
        emailContentView.frame = CGRect(x: 10, y: 0, width:  20, height: 20)
        emailIcon.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        
        singupEmailText.leftView = emailContentView
        singupEmailText.leftViewMode = .always
        
        //username textfield icon...
        let usernameIcon = UIImageView()
        usernameIcon.image = UIImage(named: "user")
        
        let usernameContentView = UIView()
        usernameContentView.addSubview(usernameIcon)
        
        usernameContentView.frame = CGRect(x: 10, y: 0, width:  20, height: 20)
        usernameIcon.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        
        singupUserText.leftView = usernameContentView
        singupUserText.leftViewMode = .always
        
        // Password textfield icon
        let passwordIcon = UIImageView()
        passwordIcon.image = UIImage(named: "password")
        
        let passwordContentView = UIView()
        passwordContentView.addSubview(passwordIcon)
        
        passwordContentView.frame = CGRect(x: 10, y: 0, width:  20, height: 20)
        passwordIcon.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        
        singupPasswordText.leftView = passwordContentView
        singupPasswordText.leftViewMode = .always
        
        // Repeatpassword Textfield icon
        let repeatPasswordIcon = UIImageView()
        repeatPasswordIcon.image = UIImage(named: "password")
        
        let repeatPasswordContentView = UIView()
        repeatPasswordContentView.addSubview(repeatPasswordIcon)
        
        repeatPasswordContentView.frame = CGRect(x: 10, y: 0, width:  20, height: 20)
        repeatPasswordIcon.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        
        singupRepeatPasswordText.leftView = repeatPasswordContentView
        singupRepeatPasswordText.leftViewMode = .always
    }
    // PasswordTextField Open-eye
    func passwordTextFieldEye() {
        
        let openEye = UIImageView()
        openEye.image = UIImage(named: "open-eye")
        
        let openEyeContentView = UIView()
        openEyeContentView.addSubview(openEye)
        
        openEyeContentView.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        openEye.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        
        singupPasswordText.rightView = openEyeContentView
        singupPasswordText.rightViewMode = .always
        
        openEye.isUserInteractionEnabled = true
        let tapGestureReccognizer = UITapGestureRecognizer(target: self, action: #selector(textFieldEyeTapped))
        openEye.addGestureRecognizer(tapGestureReccognizer)
    }
    @objc func textFieldEyeTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tapOpenEye = tapGestureRecognizer.view as! UIImageView
        if iconClick {
            iconClick = false
            tapOpenEye.image = UIImage(named: "close-eye")
            singupPasswordText.isSecureTextEntry = false
        } else {
            iconClick = true
            tapOpenEye.image = UIImage(named: "open-eye")
            singupPasswordText.isSecureTextEntry = true
        }
    }
    // RepeatPasswordTextField Open-eye
    func repeatPasswordTextFieldEye() {

        let repeatopenEye = UIImageView()
        repeatopenEye.image = UIImage(named: "open-eye")
        
        let repeatopenEyeContentView = UIView()
        repeatopenEyeContentView.addSubview(repeatopenEye)
        
        repeatopenEyeContentView.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        repeatopenEye.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        
        singupRepeatPasswordText.rightView = repeatopenEyeContentView
        singupRepeatPasswordText.rightViewMode = .always
        
        repeatopenEye.isUserInteractionEnabled = true
        let repeatTapGestureReccognizer = UITapGestureRecognizer(target: self, action: #selector(repeatTextFieldEyeTapped))
        repeatopenEye.addGestureRecognizer(repeatTapGestureReccognizer)
    }
    @objc func repeatTextFieldEyeTapped(repeatTapGestureRecognizer: UITapGestureRecognizer) {
        let repeatTapOpenEye = repeatTapGestureRecognizer.view as! UIImageView
        if iconClick {
            iconClick = false
            repeatTapOpenEye.image = UIImage(named: "close-eye")
            singupRepeatPasswordText.isSecureTextEntry = false
        } else {
            iconClick = true
            repeatTapOpenEye.image = UIImage(named: "open-eye")
            singupRepeatPasswordText.isSecureTextEntry = true
        }
    }
    @IBAction func loginBackClicked(_ sender: Any) {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
}
