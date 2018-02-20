//
//  LoginVC.swift
//  Smack
//
//  Created by Nathaniel Burciaga on 2/2/18.
//  Copyright © 2018 Nathaniel Burciaga. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //Outlets
    @IBOutlet weak var userNamedTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = userNamedTxt.text, userNamedTxt.text != "" else { return }
        guard let pass = passwordTxt.text, passwordTxt.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
        
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    
    func setUpView() {
        //spinner
        spinner.isHidden = true
        
        //set login/username/password Field text color to purple
        userNamedTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes:[NSAttributedStringKey.foregroundColor: smackPurple])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes:[NSAttributedStringKey.foregroundColor: smackPurple])
        //fix bug for tapping out of the keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.haddleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func haddleTap() {
        view.endEditing(true)
    }
    
}
