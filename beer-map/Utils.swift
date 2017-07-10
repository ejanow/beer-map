//
//  Utils.swift
//  janowski-assignment2
//
//  Created by e on 4/29/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

struct Utils {
    
    static func presentError(message: String, for vc: UIViewController ) {
        
        let title = "Error"
        let alertController =
            UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okay =
            UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alertController.addAction(okay)
        
        vc.present(alertController, animated: true, completion: nil)
    }
    
    public static func logError(_ msg: String) {
        logError([msg])
    }
    
    public static func logError(_ errors: [Any]) {
        
        log("------------------ERROR------------------")
        
        for e in errors {
            self.log(e)
        }
        
        log("-----------------------------------------")
        
    }
    
    public static func logDebug(_ items: [Any]) {
        
        log("------------------DEBUG------------------")
        
        for i in items {
            log(i)
        }
        
        log("-----------------------------------------")
    }
    
    public static func logDebug(_ s: String){
        self.logDebug([s])
    }
    
    private static func log(_ x: Any) {
        
        print(x) // write this to file? Send to PagerDuty? Etc etc.
    }
}
