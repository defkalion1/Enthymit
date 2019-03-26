//
//  MainViewController.swift
//  Enthymit
//
//  Created by Defkalion on 22/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit
import LocalAuthentication

class MainViewController: UIViewController{
    //let searchController = UISearchController(searchResultsController: nil)

    
    //MARK: - Random Quotes
    @IBOutlet weak var quotesTextLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    var effect:UIVisualEffect!


    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem) {

    }
    
    var RandomQuoteNo = Int(arc4random_uniform(UInt32(Quotes().listOfQuotes.count)))
    var quotes = Quotes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        //navigationItem.searchController = searchController
        
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
            
        }
        
        let defaults = UserDefaults.standard
        //Face ID
        if defaults.bool(forKey: "AuthIsOn") == true {
        let context:LAContext = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil){
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Secure Your Data With Face ID") { (match, error) in
                if match {
                    print("Welcome")
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.3, animations: {
                            self.navigationController?.navigationBar.isHidden = false
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
        }else{
            self.navigationController?.navigationBar.isHidden = false
            self.effect = self.visualEffectView.effect
            self.visualEffectView.effect = nil
            self.visualEffectView.isHidden = true
        }
        
        quotesTextLabel.text = quotes.listOfQuotes[RandomQuoteNo]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // Do any additional setup after loading the view.
    }
    
    struct System {
        static func clearNavigationBar(forBar navBar: UINavigationBar) {
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
            navBar.isTranslucent = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
        }
    }
    


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "fromHealth" {
            let destinationVC = segue.destination as! CategoryViewController
            destinationVC.tableType = "health"
        }else if segue.identifier == "fromSelf" {
            let destinationVC = segue.destination as! CategoryViewController
            destinationVC.tableType = "self_improvement"
        }else if segue.identifier == "fromTopSecret"{
            let destinationVC = segue.destination as! CategoryViewController
            destinationVC.tableType = "topSecret"
        }else if segue.identifier == "fromOther" {
            let destinationVC = segue.destination as! CategoryViewController
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
