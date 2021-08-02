//
//  UserSignInVC.swift
//  SureshRewarCopperDemo
//
//  Created by Suresh Rewar on 30/07/21.
//

import UIKit
import GoogleSignIn
class UserSignInVC: UIViewController {

    @IBOutlet weak var signIn: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().presentingViewController = self
        signIn.addTarget(self, action: #selector(signIN), for:.touchUpInside)
        // Do any additional setup after loading the view.
    }
     
    @objc func signIN(){
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}
