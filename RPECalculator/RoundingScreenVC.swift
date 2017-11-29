//
//  SettingsScreenVC.swift
//  RPECalculator
//
//  Created by michele Miller on 21/11/17.
//

import UIKit

class RoundingScreenVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var roundTo: UITextField!
    @IBOutlet weak var roundingUnitPicker: UIPickerView!
    
    let pickerData = ["CLOSEST", "UP", "DOWN"]

    override func viewDidLoad() {
        super.viewDidLoad()
        roundingUnitPicker.delegate = self
        roundingUnitPicker.dataSource = self
        roundTo.text = UserDefaults.standard.string(forKey: "rounding")
        let currentIndex = pickerData.index(of: UserDefaults.standard.string(forKey: "roundingDirection")!)
        roundingUnitPicker.selectRow(currentIndex!, inComponent: 0, animated: false)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RoundingScreenVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    

    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        UserDefaults.standard.set(pickerData[roundingUnitPicker.selectedRow(inComponent: 0)], forKey: "roundingDirection")
        let roundingTo = roundTo.text
        
        if (roundingTo != ""){
            print(roundingTo)
            UserDefaults.standard.set(roundingTo, forKey: "rounding")
        }
        dismiss(animated: true, completion: nil)
    }
    

}
