//
//  HomeViewController.swift
//  ocbcbank
//
//  Created by Franz on 8/25/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var amountLabel: UILabel!
    
    
    var currentAccount:Account!
   
    @IBAction func logout(_ sender: UIBarButtonItem) {
        
        navigationController?.dismiss(animated: true , completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        currentAccount.refresh()
    }
    override func viewDidAppear(_ animated: Bool) {
        amountLabel.text = String( currentAccount.getAmount() )
    }
    
    @IBAction func loadSaving(_ sender: UIButton) {
        
        performSegue(withIdentifier: "savingsegue", sender: currentAccount)
    }
    
    @IBAction func loadWithdraw(_ sender: UIButton) {
        performSegue(withIdentifier: "withdrawsegue", sender: currentAccount)
        
    }
    @IBAction func loadTransfer(_ sender: UIButton) {
      performSegue(withIdentifier: "transfersegue", sender: currentAccount)
        
    }
    @IBAction func loadHistory(_ sender: UIButton) {
        performSegue(withIdentifier: "historysegue", sender: currentAccount)
        
    }
    @IBAction func loadInfo(_ sender: UIButton) {
        performSegue(withIdentifier: "infosegue", sender: currentAccount)
        
    }
    @IBAction func loadAbout(_ sender: UIButton) {
        
        performSegue(withIdentifier: "aboutsegue", sender: currentAccount)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        
            case"savingsegue":let savingVC = segue.destination as? SavingViewController
            savingVC?.account = sender as? Account
            case"withdrawsegue":let withdrawVC = segue.destination as? WithdrawViewController
            withdrawVC?.account = sender as? Account
            case"transfersegue":let transferVC = segue.destination as? TransferViewController
            transferVC?.account = sender as? Account
            
            case"historysegue":let historyVC = segue.destination as? HistoryViewController
            historyVC?.account = sender as? Account
            default:break;
            
        }
    }
   
}
