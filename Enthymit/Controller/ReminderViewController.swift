//
//  ReminderViewController.swift
//  Enthymit
//
//  Created by Defkalion on 31/03/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

class ReminderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var repeatPickerView: UIPickerView!
    let choises = ["Never","Every Day","Every Other Day", "Weekly"]
    var day = DateFormatter()
    var month = DateFormatter()
    var year = DateFormatter()
    var hour = DateFormatter()
    var minute = DateFormatter()
    var pmam = DateFormatter()
    var notificationTitle = ""
    var notificationBody = ""
    var dateComponents = DateComponents()
    let content = UNMutableNotificationContent()
    var repeating = false
    public let defaults = UserDefaults.standard
    var fromCategory = ""
    let realm = try! Realm()
    
    var myHealthItems : Results<HealthItem>?
    var mySImprovementItems : Results<SImprovementItem>?
    var myTopSecretItems : Results<TopSecretItem>?
    var myOtherItems : Results<OtherItem>?
    
    var fromHealthCategory : HealthData?
    var fromSelfImprovementCategory : SelfImprovement?
    var fromTopSecretCategory : TopSecret?
    var fromOtherCategory : Other?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //var down: UISwipeGestureRecognizer.Direction
        day.dateFormat = "d"
        month.dateFormat = "M"
        year.dateFormat = "yyyy"
        hour.dateFormat = "h"
        minute.dateFormat = "mm"
        pmam.dateFormat = "a"
        datePickerView.reloadInputViews()
        
        
        dateComponents.calendar = Calendar.current
       
        content.title = notificationTitle
        content.sound = UNNotificationSound.default
        
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choises[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choises.count
    }
    
    //MARK: - What to do when the user selects an option
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(choises[row])
        if choises[row] == "Every Day"{
            repeating = true
        }else{
            repeating = false
        }
    }
    
    
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: repeating)
        let uuidString = UUID().uuidString
        print(uuidString)
        
        if fromCategory == "health" {

            if let currentHealthCategory = self.fromHealthCategory {
                do {
                    try self.realm.write {
                        let healthItem = myHealthItems![0]
                        healthItem.notificationKey = uuidString
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
                        sImprovementItem.notificationKey = uuidString
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
                        topSecretItem.notificationKey = uuidString
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
                        otherItem.notificationKey = uuidString
                        currentCategory.otherItems.replace(index: 0, object: otherItem)
                    }
                }catch {
                    print(error)
                }
            }
        }
        
        
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
            }
        }
        

        self.dismiss(animated: true)
        
    }
    
    
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    //MARK: - Date Picker View
    @IBAction func datePickerView(_ sender: UIDatePicker) {
        print(day.string(from: datePickerView.date))
        print(month.string(from: datePickerView.date))
        print(hour.string(from: datePickerView.date))
        print(minute.string(from: datePickerView.date))
        print(pmam.string(from: datePickerView.date))
        
        dateComponents.day = Int(day.string(from: datePickerView.date))
        dateComponents.month = Int(month.string(from: datePickerView.date))
        dateComponents.year = Int(year.string(from: datePickerView.date))
        if pmam.string(from: datePickerView.date) == "PM"{
            dateComponents.hour = Int(hour.string(from: datePickerView.date))! + 12
        }else{
            dateComponents.hour = Int(hour.string(from: datePickerView.date))
        }
        dateComponents.minute = Int(minute.string(from: datePickerView.date))
        
        
        
        
        
        
        
        
        
        
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
