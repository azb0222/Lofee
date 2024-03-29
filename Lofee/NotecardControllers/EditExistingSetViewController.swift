//
//  EditExistingSetViewController.swift
//  Lofee
//
//  Created by 65,115,114,105,116,104,98 on 9/14/20.
//  Copyright © 2020 Asritha Bodepudi. All rights reserved.
//

import UIKit
import RealmSwift
import GoogleMobileAds

class EditExistingSetViewController: NewNotecardSetViewController {
    let defaults = UserDefaults(suiteName: "group.com.Tonnelier.Lofee")

    //IBOulets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var setName: UITextField!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //Variables
    let cell = UITableViewCell()
    let realm = try! Realm()
    var notecards: Results<Notecard>?
    var selectedSet: Set?{
        didSet{
            notecards = selectedSet?.notecards.sorted(byKeyPath: "dateCreated", ascending: true)
        }
    }
    
    //View Heirarchy Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setName.text = selectedSet?.name
        newNotecardSetTableView = tableView
        set = selectedSet
        tableViewConfiguration()
    
        
        //Banner View
        if defaults?.bool(forKey: "premium") == false{
            bannerView.rootViewController = self
            bannerView.adUnitID = "ca-app-pub-1093493132842059~4613068867"
            bannerView.load(GADRequest())
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let titleFont: UIFont = UIFont(name: "Avenir Heavy", size: 20.0)!
        let attributes = [NSAttributedString.Key.font : titleFont]
        saveButton.setTitleTextAttributes(attributes, for: .normal)
    }
    //Add new notecard
    @IBAction func addButtonPressed(_ sender: UIButton) {
        addNewNotecard()
    }
    
    //Save updated set
    func showAlert(alertTitle: String, alertMessage: String, actionTitle: String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if (selectedSet?.notecards.count)! < 1{
            showAlert(alertTitle: "Please create atleast one notecard to continue", alertMessage: "", actionTitle: "Ok")
        }
        else{
            if notecards != nil{
                do {
                    try realm.write{
                        realm.add(notecards!)
                    }
                }
                catch {
                    print (error)
                }
            }
            tableView.reloadData()
            self.navigationController!.popToRootViewController(animated: true)
        }
    }
  
}
