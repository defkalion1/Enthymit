//
//  MainViewController.swift
//  Enthymit
//
//  Created by Defkalion on 22/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    //MARK: - Random Quotes
    @IBOutlet weak var quotesTextLabel: UILabel!
    var RandomQuoteNo = Int(arc4random_uniform(UInt32(Quotes().listOfQuotes.count)))
    var quotes = Quotes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        quotesTextLabel.text = quotes.listOfQuotes[RandomQuoteNo]
        // Do any additional setup after loading the view.
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
