//
//  IdentifierScreenVC.swift
//  RPECalculator
//
//  Created by michele Miller on 27/11/17.
//

import UIKit

class IdentifierScreenVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let pickerData = ["kg", "lbs", "st"]
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(pickerData[row], forKey: "identifier")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentIndex = pickerData.index(of: UserDefaults.standard.string(forKey: "identifier")!)
        picker.selectRow(currentIndex!, inComponent: 0, animated: false)

        // Do any additional setup after loading the view.
    }



}
