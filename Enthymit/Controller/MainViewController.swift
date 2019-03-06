//
//  MainViewController.swift
//  Enthymit
//
//  Created by Defkalion on 22/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit
import LocalAuthentication

class MainViewController: UIViewController {
    
    
    //MARK: - Random Quotes
    @IBOutlet weak var quotesTextLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    var effect:UIVisualEffect!
    @IBOutlet weak var noWayInLabel: UILabel!
    
    var RandomQuoteNo = Int(arc4random_uniform(UInt32(Quotes().listOfQuotes.count)))
    var quotes = Quotes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noWayInLabel.isHidden = false
        let context:LAContext = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil){
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Secure Your Data With Face ID") { (match, error) in
                if match {
                    print("Welcome")
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.3, animations: {
                            self.noWayInLabel.isHidden = true
                            self.effect = self.visualEffectView.effect
                           self.visualEffectView.effect = nil
                            self.visualEffectView.isHidden = true
                        })
                    }
                
                }else {
                    print("Try Again")
                    
                }
            }
        }
        
        
        quotesTextLabel.text = quotes.listOfQuotes[RandomQuoteNo]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CategoryViewController
        if segue.identifier == "fromHealth" {
            destinationVC.tableType = "health"
        }else if segue.identifier == "fromSelf" {
            destinationVC.tableType = "self_improvement"
        }else if segue.identifier == "fromTopSecret"{
            destinationVC.tableType = "topSecret"
        }else if segue.identifier == "fromOther" {
            destinationVC.tableType = "other"
        }
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
