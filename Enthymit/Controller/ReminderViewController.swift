//
//  ReminderViewController.swift
//  Enthymit
//
//  Created by Defkalion on 31/03/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit
import UserNotifications

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
        self.dismiss(animated: true)
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: repeating)
        let uuidString = UUID().uuidString
        print(uuidString)
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
            }
        }
        
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
