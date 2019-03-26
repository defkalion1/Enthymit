//
//  SettingsStaticTableViewController.swift
//  Enthymit
//
//  Created by Defkalion on 25/03/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit
import LocalAuthentication

class SettingsStaticTableViewController: UITableViewController {
    
    
    
    @IBOutlet weak var darkTheme: UISwitch!
    @IBOutlet weak var securityUnlock: UISwitch!
    
    public let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        darkTheme.isOn = defaults.bool(forKey: "DarkThemeIsOn")
        securityUnlock.isOn = defaults.bool(forKey: "AuthIsOn")

    }
    
    
    @IBAction func darkThemePressed(_ sender: UISwitch) {
        //self.defaults.set(darkThemeOn, forKey: "DarkThemeOn")
        self.defaults.set(darkTheme.isOn, forKey: "DarkThemeIsOn")
        
    }
    
    
    @IBAction func authPressed(_ sender: UISwitch) {
        self.defaults.set(securityUnlock.isOn, forKey: "AuthIsOn")
        
                let context:LAContext = LAContext()
        
                if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil){
                    context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Secure Your Data With Face ID") { (match, error) in
                        if match {
                            print("Welcome")
                            DispatchQueue.main.async {
                                UIView.animate(withDuration: 0.3, animations: {
                                        self.dismiss(animated: true, completion: nil)
        //                            self.effect = self.visualEffectView.effect
        //                            self.visualEffectView.effect = nil
        //                            self.visualEffectView.isHidden = true
                                })
                            }
        
                        }else {
                            print("Try Again")
                            self.securityUnlock.isOn = !self.securityUnlock.isOn
                            self.defaults.set(self.securityUnlock.isOn, forKey: "AuthIsOn")
                            DispatchQueue.main.async {
                                self.securityUnlock.setOn(false, animated: true)
                                self.tableView.reloadData()
                                
                                
                            }
                            
        
                        }
                    }
                }
        
    }
    func loadData(){
        
        DispatchQueue.main.async {
            self.securityUnlock.setOn(false, animated: true)
            self.tableView.reloadData()
            
            
        }
    }
    
}
