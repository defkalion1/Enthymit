//
//  InfoViewController.swift
//  Enthymit
//
//  Created by Defkalion on 07/03/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit


class InfoViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var mainView: UIView!
    public let defaults = UserDefaults.standard

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.bool(forKey: "DarkThemeIsOn") == true {
            mainView.backgroundColor = DarkTheme.background
            textView.backgroundColor = DarkTheme.background
            textView.textColor = DarkTheme.textColor
        }else{
            mainView.backgroundColor = LightTheme.background
            textView.backgroundColor = LightTheme.background
            textView.textColor = LightTheme.textColor
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
