//
//  ChooseCreationMethodViewController.swift
//  Design
//
//  Created by 65,115,114,105,116,104,98 on 8/16/20.
//  Copyright © 2020 Asritha Bodepudi. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ChooseCreationMethodViewController: UIViewController {
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var uploadFromQuizletButton: UIButton!
    @IBOutlet weak var createNewSetButton: UIButton!
    let defaults = UserDefaults(suiteName: "group.com.Tonnelier.Lofee")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadFromQuizletButton.layer.cornerRadius = 18
        createNewSetButton.layer.cornerRadius = 18
       
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: Any?.self, action: nil)
        
        
        if defaults?.bool(forKey: "premium") == false{
            bannerView.rootViewController = self
            bannerView.adUnitID = "ca-app-pub-1093493132842059~4613068867"
            bannerView.load(GADRequest())
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       self.hidesBottomBarWhenPushed = true
    }
   
    
    
    
}
