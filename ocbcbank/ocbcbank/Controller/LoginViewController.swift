//
//  LoginViewController.swift
//  ocbcbank
//
//  Created by Franz on 8/25/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
      let db = SQLiteDB.shared
      let bank = Bank( )
    
    
    @IBAction func login(_ sender: UIButton) {
        
        //TODO: send account ID after successful login
        
        guard  let username = self.userNameTextField.text, username != "" else {
            return
        }
        guard  let pwd = self.passwordTextField.text , pwd != "" else {
            return
        }
      
        if let account =  bank.login(userName: username, password: pwd){
            
            performSegue(withIdentifier: "homesegue", sender: account)
        } else {
            print("INvalid username & password")
        }
       /* let account =  bank.login(userName: username, password: pwd)
        if account != nil   {
            performSegue(withIdentifier: "homesegue", sender: account! )
        } else {
            
        }*/
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if   segue.identifier == "homesegue" {
            let navCtrl =  segue.destination as? UINavigationController
            let homeVC = navCtrl?.viewControllers.first as? HomeViewController
            homeVC?.currentAccount = sender as! Account
            
          
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        db.open()
        
      
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
