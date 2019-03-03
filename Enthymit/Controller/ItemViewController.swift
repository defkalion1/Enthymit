//
//  ItemViewController.swift
//  Enthymit
//
//  Created by Defkalion on 24/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit
import RealmSwift

class ItemViewController: UIViewController, UITextViewDelegate {
    
   
    @IBOutlet weak var itemLabel: UILabel!
    
    
    
    var fromCategory = ""
    var titleLabel = ""
    
    var myHealthItems : Results<HealthItem>?
    var mySImprovementItems : Results<SImprovementItem>?
    var myTopSecretItems : Results<TopSecretItem>?
    var myOtherItems : Results<OtherItem>?
    
    
    var fromHealthCategory : HealthData?{
        didSet {
            
            loadItems()
        }
    }

    var fromSelfImprovementCategory : SelfImprovement?{
        didSet {
            loadItems()
        }
    }
    
    var fromTopSecretCategory : TopSecret?{
        didSet {
            loadItems()
        }
    }

    var fromOtherCategory : Other?{
        didSet {
            loadItems()
        }
    }
    
    let realm = try! Realm()
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        if whyTextView != nil {
//
//        } else {
//            whyTextView.text = ""
//        }
//    }

    @IBOutlet weak var whyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.whyTextView.delegate = self
        itemLabel.text = titleLabel
        
        if myHealthItems?.first != nil{
        
        whyTextView.text = myHealthItems?[0].why
        }
       
        
//        if myHealthItems?[0].why != nil {
//            whyTextView.text = myHealthItems?[0].why
//        } else {
//            whyTextView.text = "something"
//        }
        
        

                // Do any additional setup after loading the view.
        
    
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if fromCategory == "health"{
//            do{
//                try realm.write {
//
//                }
//            }catch {
//                print(error)
//            }
//        }
//    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        
        if fromCategory == "health" {
        
            if let currentHealthCategory = self.fromHealthCategory {
        do {
            try self.realm.write {
                let healthItem = HealthItem()
                healthItem.why = whyTextView.text!
                currentHealthCategory.healthItems.append(healthItem)
                
                
            }
        }catch {
            print(error)
        }
    }
        }
        
    }
    
    
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//
//        whyTextView.sizeToFit()
//        // Run code here for when user begins type into the text view
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadItems () {
        
        if fromCategory == "health" {
            
            myHealthItems = fromHealthCategory?.healthItems.sorted(byKeyPath: "why")
            
            
            
            
            
        }else if fromCategory == "self_improvement" {
            
        }else if fromCategory == "topSecret" {
            
        }else if fromCategory == "other" {
           
        }
        //whyTextView.reloadInputViews()
        
    }

}
