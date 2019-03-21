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

    

    @IBOutlet weak var categoryTableView: UITableView!
    let realm = try! Realm()
    

    let formatter = DateFormatter()
    var tableType = ""
    var myHealthData : Results<HealthData>!
    var mySelfImprovementData : Results<SelfImprovement>!
    var myTopSecretData : Results<TopSecret>!
    var myOtherData : Results<Other>!
    
//    struct System {
//        static func clearNavigationBar(forBar navBar: UINavigationBar) {
//            navBar.setBackgroundImage(UIImage(), for: .default)
//            navBar.shadowImage = UIImage()
//            navBar.isTranslucent = true
//        }
//    }
    
//
//    override func viewWillAppear(_ animated: Bool) {
//
//        if let navController = navigationController {
//            System.clearNavigationBar(forBar: navController.navigationBar)
//            navController.view.backgroundColor = .clear
//        }
//    }

//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        if let navController = navigationController {
//            System.clearNavigationBar(forBar: navController.navigationBar)
//            navController.view.backgroundColor = .clear
//        }
//    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        categoryTableView.delegate = self
        categoryTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        configureTableView()
        formatter.dateFormat = "EEEE, MMMM dd, yyyy' at 'h:mm a"
        
        categoryTableView.separatorStyle = .none

        
        
        loadCategories()
        self.navigationController?.navigationBar.isHidden = false
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    


    // MARK: - Table view data source

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 1
        switch self.tableType {
        case "health":
            count = self.myHealthData.count
        case "self_improvement":
            count = self.mySelfImprovementData.count
        case "topSecret":
            count = self.myTopSecretData.count
        case "other":
            count = self.myOtherData.count
        default:
            count = 1
        }

        return count
    }
    


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCategoryCell
        
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        if self.tableType == "health"{
            cell.titleLabel.text = myHealthData?[indexPath.row].name ?? "No Categories Have Been Added Yet"
            cell.dateCreatedLabel.text = "Created " + formatter.string(from: (myHealthData?[indexPath.row].dateCreated ?? Date()))
        
        }else if self.tableType == "self_improvement" {
            cell.titleLabel.text = mySelfImprovementData?[indexPath.row].name ?? "No Self Improvement Items Yet"
            cell.dateCreatedLabel.text = "Created " + formatter.string(from: (mySelfImprovementData?[indexPath.row].dateCreated ?? Date()))
        }else if self.tableType == "topSecret" {
            cell.titleLabel.text = myTopSecretData?[indexPath.row].name ?? "No Top Secret Items Yet"
            cell.dateCreatedLabel.text = "Created " + formatter.string(from: (myTopSecretData?[indexPath.row].dateCreated ?? Date()))
        } else if self.tableType == "other" {
            cell.titleLabel.text = myOtherData?[indexPath.row].name ?? "No Other Items Yet"
            cell.dateCreatedLabel.text = "Created " + formatter.string(from: (myOtherData?[indexPath.row].dateCreated ?? Date()))
        }
        
        
//        cell.textLabel?.textColor = UIColor.black
//        tableView.rowHeight = 50.0

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: Any?.self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemViewController
        
        if let indexPath = categoryTableView.indexPathForSelectedRow {
            
            if tableType == "health" {
                destinationVC.fromCategory = "health"
                destinationVC.fromHealthCategory = myHealthData?[indexPath.row]
                destinationVC.titleLabel = myHealthData[indexPath.row].name
            
            } else if tableType == "self_improvement" {
                destinationVC.fromCategory = "selfImprovement"
                destinationVC.fromSelfImprovementCategory = mySelfImprovementData?[indexPath.row]
                destinationVC.titleLabel = mySelfImprovementData[indexPath.row].name
            } else if tableType == "topSecret"{
                destinationVC.fromCategory = "topSecret"
                destinationVC.fromTopSecretCategory = myTopSecretData?[indexPath.row]
                destinationVC.titleLabel = myTopSecretData[indexPath.row].name
            } else if tableType == "other"{
                destinationVC.fromCategory = "other"
                destinationVC.fromOtherCategory = myOtherData?[indexPath.row]
                destinationVC.titleLabel = myOtherData[indexPath.row].name
            }
        }
    }

    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    //MARK: - Delete row at indexPath when user swipes
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            if self.tableType == "health" {
            if let itemForDeletion = self.myHealthData?[indexPath.row] {
                do{
                    try realm.write {
                        realm.delete(itemForDeletion)
                    }
                }catch {
                    print("Error deleting item\(error)")
                }
            }
            } else if self.tableType == "self_improvement"{
                if let itemForDeletion = self.mySelfImprovementData?[indexPath.row] {
                    do{
                        try realm.write {
                            realm.delete(itemForDeletion)
                        }
                    }catch {
                        print("Error deleting item\(error)")
                    }
                }
            }else if self.tableType == "topSecret"{
                if let itemForDeletion = self.myTopSecretData?[indexPath.row] {
                    do{
                        try realm.write {
                            realm.delete(itemForDeletion)
                        }
                    }catch {
                        print("Error deleting item\(error)")
                    }
                }
            }else if self.tableType == "other"{
                if let itemForDeletion = self.myOtherData?[indexPath.row] {
                    do{
                        try realm.write {
                            realm.delete(itemForDeletion)
                        }
                    }catch {
                        print("Error deleting item\(error)")
                    }
                }
            }
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
                let newTableViewItem = HealthData()
                newTableViewItem.name = textField.text!
                newTableViewItem.dateCreated = Date()
                let newEmptyListItem = HealthItem()
                newEmptyListItem.why = ""
                
                
                do{
                    try self.realm.write {
                        self.realm.add(newTableViewItem)
                        newTableViewItem.healthItems.append(newEmptyListItem)
                    }
                }catch{
                    print(error)
                }
               
                
            }else if self.tableType == "self_improvement" {
               
                let newTableViewItem = SelfImprovement()
                newTableViewItem.name = textField.text!
                newTableViewItem.dateCreated = Date()
                let newEmptyListItem = SImprovementItem()
                newEmptyListItem.why = ""
                do{
                    try self.realm.write {
                        self.realm.add(newTableViewItem)
                        newTableViewItem.selfImprovementItems.append(newEmptyListItem)
                        
                    }
                }catch{
                    print(error)
                }
                
            }else if self.tableType == "topSecret" {
                
                let newTableViewItem = TopSecret()
                newTableViewItem.name = textField.text!
                newTableViewItem.dateCreated = Date()
                let newEmptyListItem = TopSecretItem()
                newEmptyListItem.why = ""
                do{
                    try self.realm.write {
                        self.realm.add(newTableViewItem)
                        newTableViewItem.topSecretItems.append(newEmptyListItem)
                        
                    }
                }catch{
                    print(error)
                }
                
            }else if self.tableType == "other" {
                
                let newTableViewItem = Other()
                newTableViewItem.name = textField.text!
                newTableViewItem.dateCreated = Date()
                let newEmptyListItem = OtherItem()
                newEmptyListItem.why = ""
                do{
                    try self.realm.write {
                        self.realm.add(newTableViewItem)
                        newTableViewItem.otherItems.append(newEmptyListItem)
                    }
                }catch{
                    print(error)
                }
                
                
            }
            
            self.categoryTableView.reloadData()
            
        }
        
        
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Name Your New Item"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func configureTableView(){
        categoryTableView.rowHeight = UITableView.automaticDimension
        categoryTableView.estimatedRowHeight = 120.0
    }
    


    func loadCategories() {
        if tableType == "health" {
            myHealthData = realm.objects(HealthData.self)
            title = "Health & Fitness"
        }else if tableType == "self_improvement" {
            mySelfImprovementData = realm.objects(SelfImprovement.self)
            title = "Self Improvement"
        }else if tableType == "topSecret" {
            myTopSecretData = realm.objects(TopSecret.self)
            title = "Top Secret"
        }else if tableType == "other" {
            myOtherData = realm.objects(Other.self)
            title = "Other"
        }
        categoryTableView.reloadData()
        
    }
    

    
    
}


