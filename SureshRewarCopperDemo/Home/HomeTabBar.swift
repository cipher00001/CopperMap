//
//  HomeTabBar.swift
//  SureshRewarCopperDemo
//
//  Created by Suresh Rewar on 30/07/21.
//

import UIKit

class HomeTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTabBar), name: NSNotification.Name(rawValue: Constants.updateMarkerNotification.rawValue), object: nil)

    }
    
    @objc func updateTabBar(noftification:Notification){
        self.selectedIndex = 0
    }
}
