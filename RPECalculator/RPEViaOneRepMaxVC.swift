//
//  RPEViaOneRepMaxVC.swift
//  RPECalculator
//
//  Created by michele Miller on 11/07/17.
//
//

import UIKit

class RPEViaOneRepMaxVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK - Outlets
    @IBOutlet weak var weightDisplay: UILabel!
    @IBOutlet weak var repsAndRpePicker: UIPickerView!
    @IBOutlet weak var oneRepMax: UITextField!
    
    //MARK - Variables
    var userRpe = rpeMax()
    let pickerData = [["1","2","3","4","5","6","7","8"],
                      ["10","9.5","9","8.5","8","7.5","7"]]
    let rpeComponent = 1
    let repComponent = 0
    let identifier = UserDefaults.standard.string(forKey: "identifier")
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.view.endEditing(true)
        runCalculate()
    }
    
    @IBAction func textChange(_ sender: Any) {
        self.view.endEditing(true)
        runCalculate()
    }
    //Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDoneOnKeyboard()
        repsAndRpePicker.delegate = self
        repsAndRpePicker.dataSource = self
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGestures))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGestures(gesture: UISwipeGestureRecognizer){
        if(gesture.direction == UISwipeGestureRecognizerDirection.right){
            print("Swipe working")
            self.dismissDetail()
        }
    }
    
    @IBAction func tapGesture(_ sender: Any) {
        dismissKeyboard()
    }
    
    //Mark - Instance Methods
    func runCalculate(){
        guard let oneRepMaxWeight = Double(oneRepMax.text!) else{
            print("Executing Gaurd")
            userRpe.oneRepMax = 0.0
            return
        }
        let tempReps = pickerData[repComponent][repsAndRpePicker.selectedRow(inComponent: repComponent)]
        let tempRpe = pickerData[rpeComponent][repsAndRpePicker.selectedRow(inComponent: rpeComponent)]
        userRpe.reps = Double(tempReps)!
        userRpe.rpe = Double(tempRpe)!
        userRpe.oneRepMax = oneRepMaxWeight
        weightDisplay.text = ("\(userRpe.calculateDesiredWeight())\(identifier!)")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        oneRepMax.inputAccessoryView = keyboardToolbar

    }
    
    
}
