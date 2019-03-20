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
        self.toMakeItHappenTextView.delegate = self
      
        self.title = titleLabel
        
        if fromCategory == "health" {
            if myHealthItems?.first?.why != nil && myHealthItems?.first?.toMakeItHappen != nil{
            whyTextView.text = myHealthItems?[0].why
            toMakeItHappenTextView.text = myHealthItems?[0].toMakeItHappen
        }
        }else if fromCategory == "selfImprovement" {
            if mySImprovementItems?.first != nil{
                whyTextView.text = mySImprovementItems?[0].why
                toMakeItHappenTextView.text = mySImprovementItems?[0].toMakeItHappen
            }
        }else if fromCategory == "topSecret" {
            if myTopSecretItems?.first != nil{
                whyTextView.text = myTopSecretItems?[0].why
                toMakeItHappenTextView.text = myTopSecretItems?[0].toMakeItHappen
            }
        }else if fromCategory == "other" {
            if myOtherItems?.first != nil{
                whyTextView.text = myOtherItems?[0].why
                toMakeItHappenTextView.text = myOtherItems?[0].toMakeItHappen
            }
        }
                // Do any additional setup after loading the view.
    
    }
    

    
    
    //MARK: - Difficulty Level
    
    
    @IBAction func difficultySliderValueChanged(_ sender: UISlider) {
//        let roundedValue = round(sender.value / step) * step
//        sender.value = roundedValue
//        difficultyLevel.text = "\(Int(roundedValue))"
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    
    }
  
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        
        if fromCategory == "health" {
        
            if let currentHealthCategory = self.fromHealthCategory {
                if textView == whyTextView   {
        do {
            try self.realm.write {
                let healthItem = myHealthItems![0]
                healthItem.why = whyTextView.text!
                currentHealthCategory.healthItems.replace(index: 0, object: healthItem)
            }
        }catch {
            print(error)
        }
                }else if textView == toMakeItHappenTextView  {
                    print("2")
                    do {
                        try self.realm.write {
                            let healthItem = myHealthItems![0]
                            healthItem.toMakeItHappen = toMakeItHappenTextView.text!
                            currentHealthCategory.healthItems.replace(index: 0, object: healthItem)
                        }
                    }catch {
                        print(error)
                    }
                }
            }
        }else if fromCategory == "selfImprovement" {
            
            if let currentSelfCategory = self.fromSelfImprovementCategory {
                if textView == whyTextView {
                do {
                    try self.realm.write {
                        let sImprovementItem = mySImprovementItems![0]
                        sImprovementItem.why = whyTextView.text!
                        currentSelfCategory.selfImprovementItems.replace(index: 0, object: sImprovementItem)
                    }
                }catch {
                    print(error)
                }
                }else if textView == toMakeItHappenTextView{
                    do {
                        try self.realm.write {
                            let sImprovementItem = mySImprovementItems![0]
                            sImprovementItem.toMakeItHappen = toMakeItHappenTextView.text!
                            currentSelfCategory.selfImprovementItems.replace(index: 0, object: sImprovementItem)
                        }
                    }catch {
                        print(error)
                    }
                }
            }
        }else if fromCategory == "topSecret"{
            if let currentSelfCategory = self.fromTopSecretCategory {
                if textView.tag == 1 {
                do {
                    try self.realm.write {
                        let topSecretItem = myTopSecretItems![0]
                        topSecretItem.why = whyTextView.text!
                        currentSelfCategory.topSecretItems.replace(index: 0, object: topSecretItem)
                    }
                }catch {
                    print(error)
                }
                }else if textView.tag == 2 {
                    do {
                        try self.realm.write {
                            let topSecretItem = myTopSecretItems![0]
                            topSecretItem.toMakeItHappen = toMakeItHappenTextView.text!
                            currentSelfCategory.topSecretItems.replace(index: 0, object: topSecretItem)
                        }
                    }catch {
                        print(error)
                    }
                }
            }
        }else if fromCategory == "other" {
            if let currentCategory = self.fromOtherCategory {
                if textView.tag == 1{
                do{
                    try realm.write {
                        let otherItem = myOtherItems![0]
                        otherItem.why = whyTextView.text!
                        currentCategory.otherItems.replace(index: 0, object: otherItem)
                    }
                }catch {
                    print(error)
                }
                }else if textView.tag == 2{
                    do{
                        try realm.write {
                            let otherItem = myOtherItems![0]
                            otherItem.toMakeItHappen = toMakeItHappenTextView.text!
                            currentCategory.otherItems.replace(index: 0, object: otherItem)
                        }
                    }catch {
                        print(error)
                    }
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
            //realm?.objects(HealthItem.self)
            


        }else if fromCategory == "selfImprovement" {
            
            mySImprovementItems = fromSelfImprovementCategory?.selfImprovementItems.sorted(byKeyPath: "why")
            
        }else if fromCategory == "topSecret" {
            
            myTopSecretItems = fromTopSecretCategory?.topSecretItems.sorted(byKeyPath: "why")
            
        }else if fromCategory == "other" {
           
            myOtherItems = fromOtherCategory?.otherItems.sorted(byKeyPath: "why")
            
        }
        //whyTextView.reloadInputViews()
        
    }

}

//extension ItemViewController: UISlider {
//
//}
