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


    @IBOutlet weak var healthButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    //@IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var selfImprovementButton: UIButton!
    @IBOutlet weak var topSecretButton: UIButton!
    
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var infoButton: UIBarButtonItem!
    //MARK: - Random Quotes
    @IBOutlet weak var quotesTextLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    var effect:UIVisualEffect!
    @IBOutlet weak var coral: UIImageView!
    public let defaults = UserDefaults.standard
    
    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem) {

    }
    
    var RandomQuoteNo = Int(arc4random_uniform(UInt32(Quotes().listOfQuotes.count)))
    var quotes = Quotes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons = [healthButton, selfImprovementButton, topSecretButton, otherButton]
        //StackView constraints so that it has dynamic space between the buttons
        let stackView = UIStackView(arrangedSubviews: buttons as! [UIView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
       stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        let salGuide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: salGuide.topAnchor, constant: 220),
            
            stackView.centerXAnchor.constraint(equalTo: salGuide.centerXAnchor, constant: 0),
            stackView.widthAnchor.constraint(equalTo: salGuide.widthAnchor, constant: 47.0),
            stackView.heightAnchor.constraint(equalTo: salGuide.heightAnchor, multiplier: 0.5)
//           otherButton.heightAnchor.constraint(equalToConstant: 47)
            ])
        
        
        
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
            
           
            
        }
        
        
        //Face ID
        if defaults.bool(forKey: "AuthIsOn") == true {
            infoButton.isEnabled = false
            settingsButton.isEnabled = false
            settingsButton.image = UIImage()
            infoButton.image = UIImage()
            
            
            
        let context:LAContext = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil){
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Secure Your Data With Face ID") { (match, error) in
                if match {
                    print("Welcome")
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.3, animations: {
                            
                            self.infoButton.isEnabled = true
                            self.settingsButton.isEnabled = true
                            self.settingsButton.image = UIImage(named: "Group")
                            self.infoButton.image = UIImage(named: "info")
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
        
        //MARK: - Appearance
        if defaults.bool(forKey: "DarkThemeIsOn") == true {
            view.backgroundColor = DarkTheme.background
            coral.backgroundColor = DarkTheme.background
            quotesTextLabel.textColor = DarkTheme.quoteText
            quotesTextLabel.backgroundColor = DarkTheme.background
        }else{
            view.backgroundColor = LightTheme.background
            coral.backgroundColor = LightTheme.background
            quotesTextLabel.textColor = LightTheme.quoteText
            quotesTextLabel.backgroundColor = LightTheme.background
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
