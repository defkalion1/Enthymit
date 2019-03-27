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
    
    
    


    @IBOutlet weak var lockIcon: UIImageView!
    @IBOutlet weak var appearanceLabel: UILabel!
    @IBOutlet weak var appearanceView: UIView!
    @IBOutlet weak var authLabel: UILabel!
    @IBOutlet weak var DarkThemeLabel: UILabel!
    @IBOutlet weak var coralRect: UIImageView!
    @IBOutlet weak var darkTheme: UISwitch!
    @IBOutlet weak var securityUnlock: UISwitch!
    @IBOutlet weak var privacyView: UIView!
    @IBOutlet weak var privacyLabel: UILabel!
    
    public let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        darkTheme.isOn = defaults.bool(forKey: "DarkThemeIsOn")
        securityUnlock.isOn = defaults.bool(forKey: "AuthIsOn")
        
        if securityUnlock.isOn == true {
            lockIcon.image = UIImage(named: "Lock Closed")
        }else{
            lockIcon.image = UIImage(named: "Lock Opened")
        }
        
        if darkTheme.isOn == true {
            setDarkTheme()
        }else{
            setLightTheme()
        }
        

    }
    
    
    @IBAction func darkThemePressed(_ sender: UISwitch) {
        //self.defaults.set(darkThemeOn, forKey: "DarkThemeOn")
        self.defaults.set(darkTheme.isOn, forKey: "DarkThemeIsOn")
        if darkTheme.isOn == true{
            setDarkTheme()
        }else{
            setLightTheme()
        }
        
        
        
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
                                    if self.securityUnlock.isOn == true {
                                        self.lockIcon.image = UIImage(named: "Lock Closed")
                                    }else{
                                        self.lockIcon.image = UIImage(named: "Lock Opened")
                                    }
                                    
        //                            self.effect = self.visualEffectView.effect
        //                            self.visualEffectView.effect = nil
        //                            self.visualEffectView.isHidden = true
                                })
                            }
        
                        }else {
                            print("Try Again")
                            DispatchQueue.main.async {
                                self.securityUnlock.isOn = !self.securityUnlock.isOn
                                self.defaults.set(self.securityUnlock.isOn, forKey: "AuthIsOn")
                                self.lockIcon.image = UIImage(named: "Lock Opened")
                            }
                            
                            
                            
                            
                            
                            
                            
                                
                                
                            
                            
        
                        }
                    }
                }
        
    }
    
    func setDarkTheme() {
        self.tableView.backgroundColor = DarkTheme.background
        authLabel.textColor = DarkTheme.textColor
        coralRect.backgroundColor = DarkTheme.background
        DarkThemeLabel.textColor = DarkTheme.textColor
        appearanceView.backgroundColor = DarkTheme.background
        appearanceLabel.textColor = DarkTheme.headerText
        privacyView.backgroundColor = DarkTheme.background
        privacyLabel.textColor = DarkTheme.headerText

    }
    func setLightTheme(){
        self.tableView.backgroundColor = LightTheme.background
        authLabel.textColor = LightTheme.textColor
        coralRect.backgroundColor = LightTheme.background
        DarkThemeLabel.textColor = LightTheme.textColor
        appearanceView.backgroundColor = LightTheme.background
        appearanceLabel.textColor = LightTheme.headerText
        privacyView.backgroundColor = LightTheme.background
        privacyLabel.textColor = LightTheme.headerText
        
    }
    
}
