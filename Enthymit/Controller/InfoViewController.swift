//
//  InfoViewController.swift
//  Enthymit
//
//  Created by Defkalion on 07/03/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit
import WebKit

class InfoViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet var mainView: UIView!
    public let defaults = UserDefaults.standard
    let videoCode = "Ah0Ys50CqO8"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.bool(forKey: "DarkThemeIsOn") == true {
            mainView.backgroundColor = DarkTheme.background
        }else{
            mainView.backgroundColor = LightTheme.background
        }
        
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        let request = URLRequest(url: url!)
        webView.load(request)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
