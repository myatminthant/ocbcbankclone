//
//  Account.swift
//  ocbcbank
//
//  Created by Franz on 9/9/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

class Account {
    
    private var _id:UInt
    private var minimumAmt:Double = 1000.0
    var sqlManager:SQLiteDB?
    
    var id:UInt {
        return _id
    }
    
    init(id:UInt){
        self._id = id
        self.amount =  0
        updateAmount { (amt, status) in
            self.amount =  amt
        }
      
    }
    private var amount:Double
    
    //Methods
    func save(_ amt:Double)->Bool{
       
        guard amt > 0 else {
                return false
        }
        //prepare fields
        let frid = self.id
        let toid = self.id
        let op = "s"
        let created = Date().timeIntervalSinceReferenceDate
        sqlManager?.open()
        let cmdStr = "INSERT INTO Transac (frid,toid,amt,op,created ) VALUES (\(frid),\(toid),\(amt),'\(op)',\(created))"
        sqlManager?.execute(sql: cmdStr)
        sqlManager?.closeDB()
        refresh()
        return true
    }
    
    func refresh() {
        updateAmount { (amt, status) in
            self.amount = amt
        }
    }
    
    func withdraw(_ amt:Double)->Bool {
        
        //TODO Load SQLite
        guard (amt    <= ( self.amount  - minimumAmt )) else {
            return false
        }
        
        let frid = self.id
        let toid = self.id
        let op = "w"
        let created = Date().timeIntervalSinceReferenceDate
        sqlManager?.open()
        let cmdStr = "INSERT INTO Transac (frid,toid,amt,op,created ) VALUES (\(frid),\(toid),\(amt),'\(op)',\(created))"
        sqlManager?.execute(sql: cmdStr)
        sqlManager?.closeDB()
        refresh()
        return true
        
    }
    func transfer(_ amt:Double,toid:UInt)-> Bool {
        //TODO Load SQLite
        guard (amt    <= ( self.amount  - minimumAmt )) else {
            return false
        }
        
        let frid = self.id
        let toid = toid
        let op = "t"
        let created = Date().timeIntervalSinceReferenceDate
        sqlManager?.open()
        let cmdStr = "INSERT INTO Transac (frid,toid,amt,op,created ) VALUES (\(frid),\(toid),\(amt),'\(op)',\(created))"
        sqlManager?.execute(sql: cmdStr)
        sqlManager?.closeDB()
        refresh( )
        return true
    }
    //Getters
    
    func getTranscations()->[(dateStr:String,trTypeStr:String,amtStr:String)]{
        sqlManager?.open()
        let cmdStr = "SELECT * FROM Transac WHERE frid = \(self.id) OR toid = \(self.id) ORDER BY created DESC"
        
     let rows =  sqlManager!.query(sql: cmdStr)
        var transacs = [(dateStr:String,trTypeStr:String,amtStr:String)]()
        
        for trDict in rows{
            let date = Date.init(timeIntervalSinceReferenceDate:(trDict["created"] as? Double) ?? 0.0)
            let dateStr = String(describing: date)
            let amtStr = String(describing: trDict["amt"] as? Double ?? 0.0)
            let trTypeStr = (trDict["op"] as? String) ?? ""
            transacs.append((dateStr: dateStr, trTypeStr: trTypeStr, amtStr: amtStr))
        }
        return transacs
    }

    func getTranscations(startDate:Date,endDate:Date){
        
    }
    
    
    
    func getAmount()->Double {
        return amount
    }
    
    func updateAmount( callback:  (Double, Bool    )->( )    ) {
        var totalAmt = 0.0
        sqlManager?.open()//***
        if  let rows = sqlManager?.query(sql: "SELECT  *  FROM Transac WHERE frid = \(self._id) OR  toid = \(self._id)" ) {
        for row in rows {
            
          //  let id = row["tid"] as! Int
             var  amt = row["amt"] as! Double
             let frid = row["frid"] as! Int
          //   let toid = row["toid"] as! Int
             let op = row["op"] as! String
            if op == "w" || ( op == "t" && frid == self.id ) {
                amt = -amt
            }
            totalAmt +=  amt
            
        }
            callback(totalAmt, true)
            return
        }
        callback(0,false )
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

