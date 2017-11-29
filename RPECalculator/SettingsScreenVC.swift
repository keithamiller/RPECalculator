//
//  SettingsScreenVC.swift
//  RPECalculator
//
//  Created by michele Miller on 25/11/17.
//

import UIKit

class SettingsScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let settingsList = ["Rounding", "Weight Identifier(kg/lbs/st)"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = settingsList[indexPath.row]
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.performSegue(withIdentifier: ("\(settingsList[indexPath.row])"), sender: self)
    }
}
