//
//  HistoryViewController.swift
//  ocbcbank
//
//  Created by Franz on 8/25/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    
    var account:Account!
    var transacs = [(dateStr:String,trTypeStr:String,amtStr:String)]()
    
    func getData(){
        transacs = account.getTranscations()
    }
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        getData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transacs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trcell") as? HistoryTableViewCell
        let currentTransac = transacs[indexPath.row]
        
        cell?.dateLabel.text = currentTransac.dateStr
        cell?.trTypeLabel.text = currentTransac.trTypeStr
        cell?.amountLabel.text = currentTransac.amtStr
        return cell!
    }
    
    
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
