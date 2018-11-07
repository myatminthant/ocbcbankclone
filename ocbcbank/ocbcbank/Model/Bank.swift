//
//  Bank.swift
//  ocbcbank
//
//  Created by Franz on 9/9/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation


class Bank {
    var currentAccount :Account?
    var db = SQLiteDB.shared
    
    func  login(userName:String, password:String)->Account? {
        let rows =  db.query(sql: "SELECT * FROM Users WHERE username  =  '\(userName)'     AND password = '\(password)'  ")
        print(rows.count)
        if rows.count == 1  {
            let accountRow = rows.first!
            let id = UInt( accountRow["id"] as! Int )
            let ac = Account(id: id )
            ac.sqlManager = SQLiteDB.shared
            return ac
        }
            
        return nil
    }
    
    func isAccountExist(id:UInt)->Bool{
        let rows =  db.query(sql: "SELECT * FROM Users WHERE id  =  \(id)")
       
        if rows.count == 1  { return true }
        return false
    }
}



