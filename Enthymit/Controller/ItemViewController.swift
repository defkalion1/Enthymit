//
//  ItemViewController.swift
//  Enthymit
//
//  Created by Defkalion on 24/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit
import RealmSwift

protocol CanReceive {
    func dataReceived(data: String, at: Int)
}


class ItemViewController: UIViewController, UITextViewDelegate {
    public let defaults = UserDefaults.standard
   


    
    @IBOutlet weak var coral: UIImageView!
    @IBOutlet weak var expectationsLabel: UILabel!
    @IBOutlet weak var levelOfDifficultyLabel: UILabel!
    @IBOutlet weak var toMakeItHappenLabel: UILabel!
    @IBOutlet weak var whyLabel: UILabel!
    @IBOutlet weak var whyTextView: UITextView!
    @IBOutlet weak var toMakeItHappenTextView: UITextView!
    @IBOutlet weak var expectationsTextView: UITextView!
    @IBOutlet weak var difficultySlider: UISlider!
    @IBOutlet weak var itemLabel: UITextField!
    @IBOutlet weak var difficultyLevel: UILabel!

    
    var delegate : CanReceive?
    var row : Int?
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

    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.whyTextView.delegate = self
        self.toMakeItHappenTextView.delegate = self
        self.expectationsTextView.delegate = self
        navigationItem.largeTitleDisplayMode = .never
        

      
        
      
        self.itemLabel.text = titleLabel
        
        
        if fromCategory == "health" {
            if myHealthItems?.first?.why != nil{
                whyTextView.text = myHealthItems?[0].why
                toMakeItHappenTextView.text = myHealthItems?[0].toMakeItHappen
                difficultySlider.value = myHealthItems?[0].difficulty ?? 1.0
                expectationsTextView.text = myHealthItems?[0].expectations
                
        }
        }else if fromCategory == "selfImprovement" {
            if mySImprovementItems?.first != nil{
                whyTextView.text = mySImprovementItems?[0].why
                toMakeItHappenTextView.text = mySImprovementItems?[0].toMakeItHappen
                difficultySlider.value = mySImprovementItems?[0].difficulty ?? 1.0
                expectationsTextView.text = mySImprovementItems?[0].expectations
            }
        }else if fromCategory == "topSecret" {
            if myTopSecretItems?.first != nil{
                whyTextView.text = myTopSecretItems?[0].why
                toMakeItHappenTextView.text = myTopSecretItems?[0].toMakeItHappen
                difficultySlider.value = myTopSecretItems?[0].difficulty ?? 1.0
                expectationsTextView.text = myTopSecretItems?[0].expectations
            }
        }else if fromCategory == "other" {
            if myOtherItems?.first != nil{
                whyTextView.text = myOtherItems?[0].why
                toMakeItHappenTextView.text = myOtherItems?[0].toMakeItHappen
                difficultySlider.value = myOtherItems?[0].difficulty ?? 1.0
                expectationsTextView.text = myOtherItems?[0].expectations
            }
        }
                // Do any additional setup after loading the view.
        switch difficultySlider.value {
        case 1.0:
            difficultyLevel.text = "1 / 10"
        case 2.0:
            difficultyLevel.text = "2 / 10"
        case 3.0:
            difficultyLevel.text = "3 / 10"
        case 4.0:
            difficultyLevel.text = "4 / 10"
        case 5.0:
            difficultyLevel.text = "5 / 10"
        case 6.0:
            difficultyLevel.text = "6 / 10"
        case 7.0:
            difficultyLevel.text = "7 / 10"
        case 8.0:
            difficultyLevel.text = "8 / 10"
        case 9.0:
            difficultyLevel.text = "9 / 10"
        case 10.0:
            difficultyLevel.text = "10 / 10"
        default:
            print("1")
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //MARK: - Appearance
        if defaults.bool(forKey: "DarkThemeIsOn") == true {
            coral.backgroundColor = DarkTheme.background
            itemLabel.textColor = DarkTheme.textColor
            whyLabel.textColor = DarkTheme.textColor
            whyTextView.textColor = DarkTheme.textColor
            toMakeItHappenLabel.textColor = DarkTheme.textColor
            toMakeItHappenTextView.backgroundColor = DarkTheme.background
            toMakeItHappenTextView.textColor = DarkTheme.textColor
            whyTextView.backgroundColor = DarkTheme.background
            levelOfDifficultyLabel.textColor = DarkTheme.textColor
            difficultySlider.maximumTrackTintColor = DarkTheme.headerText
            difficultyLevel.textColor = DarkTheme.quoteText
            expectationsLabel.textColor = DarkTheme.textColor
            expectationsTextView.backgroundColor = DarkTheme.background
            expectationsTextView.textColor = DarkTheme.textColor
            view.backgroundColor = DarkTheme.background
        }else{
            coral.backgroundColor = LightTheme.background
            itemLabel.textColor = LightTheme.textColor
            whyLabel.textColor = LightTheme.textColor
            whyTextView.textColor = LightTheme.textColor
            toMakeItHappenLabel.textColor = LightTheme.textColor
            whyTextView.backgroundColor = LightTheme.background
            levelOfDifficultyLabel.textColor = LightTheme.textColor
            difficultySlider.maximumTrackTintColor = DarkTheme.headerText
            difficultyLevel.textColor = LightTheme.quoteText
            expectationsLabel.textColor = LightTheme.textColor
            expectationsTextView.backgroundColor = LightTheme.background
            expectationsTextView.textColor = LightTheme.textColor
            view.backgroundColor = LightTheme.background
            toMakeItHappenTextView.backgroundColor = LightTheme.background
            toMakeItHappenTextView.textColor = LightTheme.textColor
        }
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
                }else if textView == expectationsTextView  {
                    print("2")
                    do {
                        try self.realm.write {
                            let healthItem = myHealthItems![0]
                            healthItem.expectations = expectationsTextView.text!
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
                }else if textView == expectationsTextView{
                    do {
                        try self.realm.write {
                            let sImprovementItem = mySImprovementItems![0]
                            sImprovementItem.expectations = expectationsTextView.text!
                            currentSelfCategory.selfImprovementItems.replace(index: 0, object: sImprovementItem)
                        }
                    }catch {
                        print(error)
                    }
                }
            }
        }else if fromCategory == "topSecret"{
            if let currentSelfCategory = self.fromTopSecretCategory {
                if textView == whyTextView {
                do {
                    try self.realm.write {
                        let topSecretItem = myTopSecretItems![0]
                        topSecretItem.why = whyTextView.text!
                        currentSelfCategory.topSecretItems.replace(index: 0, object: topSecretItem)
                    }
                }catch {
                    print(error)
                }
                }else if textView == toMakeItHappenTextView {
                    do {
                        try self.realm.write {
                            let topSecretItem = myTopSecretItems![0]
                            topSecretItem.toMakeItHappen = toMakeItHappenTextView.text!
                            currentSelfCategory.topSecretItems.replace(index: 0, object: topSecretItem)
                        }
                    }catch {
                        print(error)
                    }
                }else if textView == expectationsTextView {
                    do {
                        try self.realm.write {
                            let topSecretItem = myTopSecretItems![0]
                            topSecretItem.expectations = expectationsTextView.text!
                            currentSelfCategory.topSecretItems.replace(index: 0, object: topSecretItem)
                        }
                    }catch {
                        print(error)
                    }
                }
            }
        }else if fromCategory == "other" {
            if let currentCategory = self.fromOtherCategory {
                if textView == whyTextView{
                do{
                    try realm.write {
                        let otherItem = myOtherItems![0]
                        otherItem.why = whyTextView.text!
                        currentCategory.otherItems.replace(index: 0, object: otherItem)
                    }
                }catch {
                    print(error)
                }
                }else if textView == toMakeItHappenTextView{
                    do{
                        try realm.write {
                            let otherItem = myOtherItems![0]
                            otherItem.toMakeItHappen = toMakeItHappenTextView.text!
                            currentCategory.otherItems.replace(index: 0, object: otherItem)
                        }
                    }catch {
                        print(error)
                    }
                }else if textView == expectationsTextView{
                    do{
                        try realm.write {
                            let otherItem = myOtherItems![0]
                            otherItem.expectations = expectationsTextView.text!
                            currentCategory.otherItems.replace(index: 0, object: otherItem)
                        }
                    }catch {
                        print(error)
                    }
                }
            }
        }
        
    }
    
    //MARK: - Title Changed
    @IBAction func titleChanged(_ sender: UITextField) {
        delegate?.dataReceived(data: itemLabel.text!, at: row!)
        
    }
    
 
    
    
    @IBAction func difficultySliderChanged(_ sender: UISlider) {
       //difficultySlider.value = roundf(difficultySlider.value)
        difficultySlider.setValue(roundf(difficultySlider.value), animated: true)
        //let tap = UISelectionFeedbackGenerator()
        
        
        switch difficultySlider.value {
        case 1.0:
            difficultyLevel.text = "1 / 10"
        case 2.0:
            difficultyLevel.text = "2 / 10"
        case 3.0:
            difficultyLevel.text = "3 / 10"
        case 4.0:
            difficultyLevel.text = "4 / 10"
        case 5.0:
            difficultyLevel.text = "5 / 10"
        case 6.0:
            difficultyLevel.text = "6 / 10"
        case 7.0:
            difficultyLevel.text = "7 / 10"
        case 8.0:
            difficultyLevel.text = "8 / 10"
        case 9.0:
            difficultyLevel.text = "9 / 10"
        case 10.0:
            difficultyLevel.text = "10 / 10"
        default:
            print("1")
        }
        
            
            //MARK: - Save Difficulty Value
            if fromCategory == "health" {
                
                if let currentHealthCategory = self.fromHealthCategory {
                        do {
                            try self.realm.write {
                                let healthItem = myHealthItems![0]
                                healthItem.difficulty = difficultySlider.value
                                currentHealthCategory.healthItems.replace(index: 0, object: healthItem)
                            }
                            print("saved")
                        }catch {
                            print(error)
                        }
                }
                   
            }else if fromCategory == "selfImprovement" {
                
                if let currentSelfCategory = self.fromSelfImprovementCategory {
    
                        do {
                            try self.realm.write {
                                let sImprovementItem = mySImprovementItems![0]
                                sImprovementItem.difficulty = difficultySlider.value
                                currentSelfCategory.selfImprovementItems.replace(index: 0, object: sImprovementItem)
                            }
                        }catch {
                            print(error)
                        }
                }
            }else if fromCategory == "topSecret"{
                if let currentSelfCategory = self.fromTopSecretCategory {
                        do {
                            try self.realm.write {
                                let topSecretItem = myTopSecretItems![0]
                                topSecretItem.difficulty = difficultySlider.value
                                currentSelfCategory.topSecretItems.replace(index: 0, object: topSecretItem)
                            }
                        }catch {
                            print(error)
                        }
                    
                    
                }
            }else if fromCategory == "other" {
                if let currentCategory = self.fromOtherCategory {
                   
                        do{
                            try realm.write {
                                let otherItem = myOtherItems![0]
                                otherItem.difficulty = difficultySlider.value
                                currentCategory.otherItems.replace(index: 0, object: otherItem)
                            }
                        }catch {
                            print(error)
                        }
                }
                }
            
        }
    
            
        
        
        
        
        //tap.selectionChanged()
    
    

    
    
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
