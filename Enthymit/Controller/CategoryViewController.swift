//
//  CategoryViewController.swift
//  Enthymit
//
//  Created by Defkalion on 21/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//


// Add the acessory type to > from nothing when there are items


import UIKit
import RealmSwift

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    
    
    var tableType = ""
    var myHealthData : Results<HealthData>!
    var mySelfImprovementData : Results<SelfImprovement>!
    var myTopSecretData : Results<TopSecret>!
    var myOtherData : Results<Other>!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        
        
        loadCategories()
        //self.navigationController?.navigationBar.isHidden = false
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if tableType == "health" {
            title = "Health"
        } else if tableType == "self_improvement" {
            title = "Self Improvement"
        } else if tableType == "topSecret"{
            title = "Top Secret"
        } else if tableType == "other"{
            title = "Other"
        }
    }

    // MARK: - Table view data source

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 1
        if self.tableType == "health"{
            count = self.myHealthData.count
        } else if self.tableType == "self_improvement"{
            count = self.mySelfImprovementData.count
        } else if tableType == "topSecret" {
            count = self.myTopSecretData.count
        } else if tableType == "other" {
            count = self.myOtherData.count
        }
        return count
    }
    


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        if self.tableType == "health"{
          cell.textLabel?.text = myHealthData?[indexPath.row].name ?? "No Categories Have Been Added Yet"
        //cell.accessoryType = UITableViewCell.AccessoryType.none
        }else if self.tableType == "self_improvement" {
            cell.textLabel?.text = mySelfImprovementData?[indexPath.row].name ?? "No Self Improvement Items Yet"
        }else if self.tableType == "topSecret" {
            cell.textLabel?.text = myTopSecretData?[indexPath.row].name ?? "No Top Secret Items Yet"
        } else if self.tableType == "other" {
            cell.textLabel?.text = myOtherData?[indexPath.row].name ?? "No Other Items Yet"
        }
        
        
        cell.textLabel?.textColor = UIColor.black
        tableView.rowHeight = 50.0

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            if tableType == "health" {
                destinationVC.fromCategory = "health"
                destinationVC.fromHealthCategory = myHealthData?[indexPath.row]
                destinationVC.titleLabel = myHealthData![indexPath.row].name
            
            } else if tableType == "self_improvement" {
                destinationVC.fromCategory = "selfImprovement"
                destinationVC.fromSelfImprovementCategory = mySelfImprovementData?[indexPath.row]
            
            } else if tableType == "topSecret"{
                destinationVC.fromCategory = "topSecret"
            
            } else if tableType == "other"{
                destinationVC.fromCategory = "other"
            }
        }
    }

    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    //MARK: - Add Button Pressed
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            
            if self.tableType == "health" {
                let newItemName = HealthData()
                newItemName.name = textField.text!
                
                do{
                    try self.realm.write {
                        self.realm.add(newItemName)
                    }
                }catch{
                    print(error)
                }
                
                
            }else if self.tableType == "self_improvement" {
               
                let newItemName = SelfImprovement()
                newItemName.name = textField.text!
                
                do{
                    try self.realm.write {
                        self.realm.add(newItemName)
                    }
                }catch{
                    print(error)
                }
                
            }else if self.tableType == "topSecret" {
                
                let newItemName = TopSecret()
                newItemName.name = textField.text!
                
                do{
                    try self.realm.write {
                        self.realm.add(newItemName)
                    }
                }catch{
                    print(error)
                }
                
            }else if self.tableType == "other" {
                
                let newItemName = Other()
                newItemName.name = textField.text!
                
                do{
                    try self.realm.write {
                        self.realm.add(newItemName)
                    }
                }catch{
                    print(error)
                }
                
                
            }
            
            self.tableView.reloadData()
        }
        
        
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Name Your New Item"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    


    func loadCategories() {
        if tableType == "health" {
         myHealthData = realm.objects(HealthData.self)
        }else if tableType == "self_improvement" {
            mySelfImprovementData = realm.objects(SelfImprovement.self)
        }else if tableType == "topSecret" {
            myTopSecretData = realm.objects(TopSecret.self)
        }else if tableType == "other" {
            myOtherData = realm.objects(Other.self)
        }
        tableView.reloadData()
        
    }
    
    
}


