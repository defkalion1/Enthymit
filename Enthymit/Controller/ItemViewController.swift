//
//  ItemViewController.swift
//  Enthymit
//
//  Created by Defkalion on 24/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

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
    @IBOutlet weak var difficultyLevel: UILabel!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var itemTitle: UITextView!
    
    
    var delegate : CanReceive?
    var row : Int?
    var fromCategory = ""
    var titleLabel = ""
    var key : String?
    var found = false

    
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
        self.itemTitle.delegate = self
        navigationItem.largeTitleDisplayMode = .never
        //self.navigationController?.navigationBar.isHidden = true
        
        
        
        
        
      
        
      
        self.itemTitle.text = titleLabel
        
        
        if fromCategory == "health" {
            if myHealthItems?.first?.why != nil{
                whyTextView.text = myHealthItems?[0].why
                toMakeItHappenTextView.text = myHealthItems?[0].toMakeItHappen
                difficultySlider.value = myHealthItems?[0].difficulty ?? 1.0
                expectationsTextView.text = myHealthItems?[0].expectations
                key = (myHealthItems?[0].notificationKey)!
                
//                if myHealthItems?[0].notificationKey == "" {
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm"), for: .normal)
//                }else{
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm_filled"), for: .normal)
//
//        }
        }
        }else if fromCategory == "selfImprovement" {
            if mySImprovementItems?.first != nil{
                whyTextView.text = mySImprovementItems?[0].why
                toMakeItHappenTextView.text = mySImprovementItems?[0].toMakeItHappen
                difficultySlider.value = mySImprovementItems?[0].difficulty ?? 1.0
                expectationsTextView.text = mySImprovementItems?[0].expectations
                key = (mySImprovementItems?[0].notificationKey)!
//                if mySImprovementItems?[0].notificationKey == "" {
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm"), for: .normal)
//                }else{
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm_filled"), for: .normal)
//
//                }
            }
        }
        else if fromCategory == "topSecret" {
            if myTopSecretItems?.first != nil{
                whyTextView.text = myTopSecretItems?[0].why
                toMakeItHappenTextView.text = myTopSecretItems?[0].toMakeItHappen
                difficultySlider.value = myTopSecretItems?[0].difficulty ?? 1.0
                expectationsTextView.text = myTopSecretItems?[0].expectations
                key = (myTopSecretItems?[0].notificationKey)!
                
//                if myTopSecretItems?[0].notificationKey == "" {
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm"), for: .normal)
//                }else{
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm_filled"), for: .normal)
//
//                }
            }
        }else if fromCategory == "other" {
            if myOtherItems?.first != nil{
                whyTextView.text = myOtherItems?[0].why
                toMakeItHappenTextView.text = myOtherItems?[0].toMakeItHappen
                difficultySlider.value = myOtherItems?[0].difficulty ?? 1.0
                expectationsTextView.text = myOtherItems?[0].expectations
                key = (myOtherItems?[0].notificationKey)!
//                if myOtherItems?[0].notificationKey == "" {
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm"), for: .normal)
//                }else{
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm_filled"), for: .normal)
//
//                }
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
        
        
        
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: {requests -> () in
            print("\(requests.count) -----------,")
            //print(requests[0].identifier)
            
            
            if requests.count != 0 {
            print("HEYYYYYYYYY")
            for number in 0...requests.count - 1 {
                
                if self.key == requests[number].identifier {
                    self.found = true
                    print("------------- FOUND ------------")
                    
                    break
                }
                
                
                
               }
                    self.foundNot()
            }
            
            
            
        })
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //MARK: - Appearance
        if defaults.bool(forKey: "DarkThemeIsOn") == true {
            coral.backgroundColor = DarkTheme.background
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
            difficultySlider.minimumTrackTintColor = DarkTheme.slider
            itemTitle.textColor = DarkTheme.textColor
            itemTitle.backgroundColor = DarkTheme.background
        }else{
            coral.backgroundColor = LightTheme.background
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
            difficultySlider.minimumTrackTintColor = LightTheme.slider
            itemTitle.textColor = LightTheme.textColor
            itemTitle.backgroundColor = LightTheme.background
            
        }
        

        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        if fromCategory == "health" {
//            if myHealthItems?.first?.why != nil{
//
//
//                if myHealthItems?[0].notificationKey == "" {
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm"), for: .normal)
//                }else{
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm_filled"), for: .normal)
//
//                }
//            }
//        }else if fromCategory == "selfImprovement" {
//            if mySImprovementItems?.first != nil{
//
//
//                if mySImprovementItems?[0].notificationKey == "" {
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm"), for: .normal)
//                }else{
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm_filled"), for: .normal)
//
//                }
//            }
//        }
//        else if fromCategory == "topSecret" {
//            if myTopSecretItems?.first != nil{
//
//
//                if myTopSecretItems?[0].notificationKey == "" {
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm"), for: .normal)
//                }else{
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm_filled"), for: .normal)
//
//                }
//            }
//        }else if fromCategory == "other" {
//            if myOtherItems?.first != nil{
//
//
//                if myOtherItems?[0].notificationKey == "" {
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm"), for: .normal)
//                }else{
//                    reminderButton.setImage(UIImage(named: "icon_ios_alarm_filled"), for: .normal)
//
//                }
//            }
//        }
//    }

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
        //MARK: - Title Changed
        if textView == itemTitle {
            delegate?.dataReceived(data: itemTitle.text!, at: row!)
        }
        
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ReminderViewController
        destinationVC.notificationTitle = itemTitle.text!
        destinationVC.fromCategory = fromCategory
        
        
        if fromCategory == "health" {
            
            destinationVC.myHealthItems = fromHealthCategory?.healthItems.sorted(byKeyPath: "why")
            destinationVC.fromHealthCategory = fromHealthCategory
            
            
        }else if fromCategory == "selfImprovement" {
            
            destinationVC.mySImprovementItems = fromSelfImprovementCategory?.selfImprovementItems.sorted(byKeyPath: "why")
            destinationVC.fromSelfImprovementCategory = fromSelfImprovementCategory
            
        }else if fromCategory == "topSecret" {
            
            destinationVC.myTopSecretItems = fromTopSecretCategory?.topSecretItems.sorted(byKeyPath: "why")
            destinationVC.fromTopSecretCategory = fromTopSecretCategory
            
        }else if fromCategory == "other" {
            
            destinationVC.myOtherItems = fromOtherCategory?.otherItems.sorted(byKeyPath: "why")
            destinationVC.fromOtherCategory = fromOtherCategory
            
        }
        
        
    }
    

    //MARK: - Notifications
        
    @IBAction func notificattionsButtonPressed(_ sender: UIButton) {
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (didAllow, error) in
            if error != nil{
                print("notifications error")
            }else{
                print("nice you will get notifications")
            }
        }
        
        UNUserNotificationCenter.current().getNotificationSettings(){ (settings) in
            
            switch settings.alertSetting{
            case .enabled:
                DispatchQueue.main.async {
                    
                    //self.reminderButton.setImage(UIImage(named: "icon_ios_alarm_filled"), for: .normal)
                    
                    if self.fromCategory == "health" {
                        if self.myHealthItems?.first?.why != nil{
                            
                            
                            if self.myHealthItems?[0].notificationKey == "" {
                                
                                self.performSegue(withIdentifier: "goToReminder", sender: self)
                            }else{
                                self.showActionSheet(key: (self.myHealthItems?[0].notificationKey)!)
                                
                            }
                        }
                    }else if self.fromCategory == "selfImprovement" {
                        if self.mySImprovementItems?.first != nil{
                            
                            
                            if self.mySImprovementItems?[0].notificationKey == "" {
                                self.performSegue(withIdentifier: "goToReminder", sender: self)
                            }else{
                                self.showActionSheet(key: (self.mySImprovementItems?[0].notificationKey)!)
                                
                            }
                        }
                    }
                    else if self.fromCategory == "topSecret" {
                        if self.myTopSecretItems?.first != nil{
                            
                            
                            if self.myTopSecretItems?[0].notificationKey == "" {
                                self.performSegue(withIdentifier: "goToReminder", sender: self)
                            }else{
                                self.showActionSheet(key: (self.myTopSecretItems?[0].notificationKey)!)
                                
                            }
                        }
                    }else if self.fromCategory == "other" {
                        if self.myOtherItems?.first != nil{
                            
                            
                            if self.myOtherItems?[0].notificationKey == "" {
                                self.performSegue(withIdentifier: "goToReminder", sender: self)
                            }else{
                                self.showActionSheet(key: (self.myOtherItems?[0].notificationKey)!)
                                
                            }
                        }
                    }

                }
                //Permissions are granted
                print("allowed")

            case .disabled:
                //Permissions are not granted
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Notifications Not Enabled", message: "In order to receive notifications as well as use this feature, you have to go into settings and allow notifications for this app.", preferredStyle: .alert)
                    let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: { (action) in })
                    
                    alert.addAction(dismiss)
                    self.present(alert,animated: true,completion: nil)
                }
                
                
            case .notSupported:
                print("dfdfdf")
                //The application does not support this notification type
            }
        }
        
        

    }
    

    func showActionSheet(key: String){
        
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //let action = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let clear = UIAlertAction(title: "Clear Reminder", style: .default) { (action) in
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [key])
            
            
            if self.fromCategory == "health" {
                
                if let currentHealthCategory = self.fromHealthCategory {
                    do {
                        try self.realm.write {
                            let healthItem = self.myHealthItems![0]
                            healthItem.notificationKey = ""
                            currentHealthCategory.healthItems.replace(index: 0, object: healthItem)
                        }
                        print("saved")
                    }catch {
                        print(error)
                    }
                }
                
            }else if self.fromCategory == "selfImprovement" {
                
                if let currentSelfCategory = self.fromSelfImprovementCategory {
                    
                    do {
                        try self.realm.write {
                            let sImprovementItem = self.mySImprovementItems![0]
                            sImprovementItem.notificationKey = ""
                            currentSelfCategory.selfImprovementItems.replace(index: 0, object: sImprovementItem)
                        }
                    }catch {
                        print(error)
                    }
                }
            }else if self.fromCategory == "topSecret"{
                if let currentSelfCategory = self.fromTopSecretCategory {
                    do {
                        try self.realm.write {
                            let topSecretItem = self.myTopSecretItems![0]
                            topSecretItem.notificationKey = ""
                            currentSelfCategory.topSecretItems.replace(index: 0, object: topSecretItem)
                        }
                    }catch {
                        print(error)
                    }
                    
                    
                }
            }else if self.fromCategory == "other" {
                if let currentCategory = self.fromOtherCategory {
                    
                    do{
                        try self.realm.write {
                            let otherItem = self.myOtherItems![0]
                            otherItem.notificationKey = ""
                            currentCategory.otherItems.replace(index: 0, object: otherItem)
                        }
                    }catch {
                        print(error)
                    }
                }
            }
            
            //self.reminderButton.setImage(UIImage(named: "icon_ios_alarm"), for: .normal)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
//        let edit = UIAlertAction(title: "Edit Reminder", style: .default) { (action) in
//
//        }
        
        actionSheet.addAction(clear)
        actionSheet.addAction(cancel)
        //actionSheet.addAction(edit)
        
        present(actionSheet,animated: true, completion: nil)
        
    }
    
    
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
    
    func foundNot(){
        DispatchQueue.main.async {
            if self.found == false {
                
                if self.fromCategory == "health" {
                    
                    if let currentHealthCategory = self.fromHealthCategory {
                        do {
                            try self.realm.write {
                                let healthItem = self.myHealthItems![0]
                                healthItem.notificationKey = ""
                                currentHealthCategory.healthItems.replace(index: 0, object: healthItem)
                                print("REMOVED")
                            }
                            print("saved")
                        }catch {
                            print(error)
                        }
                    }
                    
                }else if self.fromCategory == "selfImprovement" {
                    
                    if let currentSelfCategory = self.fromSelfImprovementCategory {
                        
                        do {
                            try self.realm.write {
                                let sImprovementItem = self.mySImprovementItems![0]
                                sImprovementItem.notificationKey = ""
                                currentSelfCategory.selfImprovementItems.replace(index: 0, object: sImprovementItem)
                            }
                        }catch {
                            print(error)
                        }
                    }
                }else if self.fromCategory == "topSecret"{
                    if let currentSelfCategory = self.fromTopSecretCategory {
                        do {
                            try self.realm.write {
                                let topSecretItem = self.myTopSecretItems![0]
                                topSecretItem.notificationKey = ""
                                currentSelfCategory.topSecretItems.replace(index: 0, object: topSecretItem)
                            }
                        }catch {
                            print(error)
                        }
                        
                        
                    }
                }else if self.fromCategory == "other" {
                    if let currentCategory = self.fromOtherCategory {
                        
                        do{
                            try self.realm.write {
                                let otherItem = self.myOtherItems![0]
                                otherItem.notificationKey = ""
                                currentCategory.otherItems.replace(index: 0, object: otherItem)
                            }
                        }catch {
                            print(error)
                        }
                    }
                }
            }
        }
        }
        

}
