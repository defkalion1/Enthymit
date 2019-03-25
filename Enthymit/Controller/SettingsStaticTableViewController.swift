//
//  SettingsStaticTableViewController.swift
//  Enthymit
//
//  Created by Defkalion on 25/03/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit

class SettingsStaticTableViewController: UITableViewController {
    
    
    
    @IBOutlet weak var darkTheme: UISwitch!
    @IBOutlet weak var securityUnlock: UISwitch!
    
    let defaults = UserDefaults.standard

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
        
        
    }
    
    
}
