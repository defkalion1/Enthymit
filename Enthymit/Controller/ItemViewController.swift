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
    
   
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var difficultyLevel: UILabel!
    let step: Float = 10
    
    
    
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

    

    @IBOutlet weak var whyTextView: UITextView!
    @IBOutlet weak var toMakeItHappenTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.whyTextView.delegate = self
        toMakeItHappenTextView.delegate = self
        self.title = titleLabel
        
        if fromCategory == "health" {
        if myHealthItems?.first != nil{
            whyTextView.text = myHealthItems?[0].why
            toMakeItHappenTextView.text = myHealthItems?[1].expectations
        }
        }else if fromCategory == "selfImprovement" {
            if mySImprovementItems?.first != nil{
                whyTextView.text = mySImprovementItems?[0].why
            }
        }else if fromCategory == "topSecret" {
            if myTopSecretItems?.first != nil{
                whyTextView.text = myTopSecretItems?[0].why
            }
        }else if fromCategory == "other" {
            if myOtherItems?.first != nil{
                whyTextView.text = myOtherItems?[0].why
            }
        }
                // Do any additional setup after loading the view.
    
    }
    
    //MARK: - Difficulty Level
    
    
    @IBAction func difficultySliderValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        difficultyLevel.text = "\(Int(roundedValue))"
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    
    }
    
  
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if fromCategory == "health"{
        if myHealthItems?.first != nil {
            if textView.tag == 1 {
            do{
                print(textView.tag)
                let toDelete = self.myHealthItems![0]
                try realm.write {
                    realm.delete(toDelete)
                }
            }catch {
                print(error)
            }
            }else {
                print("To make it happen I need to")
            }
        }
        }else if fromCategory == "selfImprovement" {
            if mySImprovementItems?.first != nil {
                do{
                    let toDelete = self.mySImprovementItems![0]
                    try realm.write {
                        realm.delete(toDelete)
                    }
                }catch {
                    print(error)
                }
            }
            
        }else if fromCategory == "topSecret" {
            if myTopSecretItems?.first != nil {
                do{
                    let toDelete = self.myTopSecretItems![0]
                    try realm.write {
                        realm.delete(toDelete)
                    }
                }catch {
                    print(error)
                }
            }
    
        }else if fromCategory == "other" {
            if myOtherItems?.first != nil {
                do{
                    let toDelete = self.myOtherItems![0]
                    try realm.write {
                        realm.delete(toDelete)
                    }
                }catch {
                    print(error)
                }
            }
            }

}
    
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
        }else if fromCategory == "selfImprovement" {
            
            if let currentSelfCategory = self.fromSelfImprovementCategory {
                do {
                    try self.realm.write {
                        let sImprovementItem = SImprovementItem()
                        sImprovementItem.why = whyTextView.text!
                        currentSelfCategory.selfImprovementItems.append(sImprovementItem)
                    }
                }catch {
                    print(error)
                }
            }
        }else if fromCategory == "topSecret"{
            if let currentSelfCategory = self.fromTopSecretCategory {
                do {
                    try self.realm.write {
                        let topSecretItem = TopSecretItem()
                        topSecretItem.why = whyTextView.text!
                        currentSelfCategory.topSecretItems.append(topSecretItem)
                    }
                }catch {
                    print(error)
                }
            }
        }else if fromCategory == "other" {
            if let currentCategory = self.fromOtherCategory {
                do{
                    try realm.write {
                        let otherItem = OtherItem()
                        otherItem.why = whyTextView.text!
                        currentCategory.otherItems.append(otherItem)
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


        }else if fromCategory == "selfImprovement" {
            
            mySImprovementItems = fromSelfImprovementCategory?.selfImprovementItems.sorted(byKeyPath: "why")
            
        }else if fromCategory == "topSecret" {
            
            myTopSecretItems = fromTopSecretCategory?.topSecretItems.sorted(byKeyPath: "why")
            
        }else if fromCategory == "other" {
           
            myOtherItems = fromOtherCategory?.otherItems.sorted(byKeyPath: "why")
            
        }
        //whyTextView.reloadInputViews()
        
    }
    
    
    func saveItem() {
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

}

//extension ItemViewController: UISlider {
//
//}
