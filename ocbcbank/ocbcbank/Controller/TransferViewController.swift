//
//  TransferViewController.swift
//  ocbcbank
//
//  Created by Franz on 8/25/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class TransferViewController: UIViewController {
    
    var account:Account!//***
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var acTextField: UITextField!
    
    @IBAction func Transfer(_ sender: UIButton) {
        
        guard let amount = amountTextField.text, amount != "",let value = Double(amount),value > 0.0 else{
            return
        }
        guard let ac = acTextField.text, ac != "",let toid = UInt(ac) else{
            return
        }
        let bank = Bank()
        
        bank.isAccountExist(id:toid)
        let status = account.transfer(value, toid: toid)
        print(status)
        
        if status{
            amountTextField.text = ""
            account.refresh()
            acTextField.text = ""
        }
        else{
            print("Acount not exist")
        }
    
        
    
    
}
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
}


}
