//
//  WithdrawViewController.swift
//  ocbcbank
//
//  Created by Franz on 8/25/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class WithdrawViewController: UIViewController {
    
    var account:Account!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBAction func Withdraw(_ sender: UIButton) {
        
        guard let amount = amountTextField.text, amount != "",let value = Double(amount),value > 0.0 else{
            return
        }
        let status = account.withdraw(value)
        print(status)
        if status{
            amountTextField.text = ""
            account.refresh()
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   

}
