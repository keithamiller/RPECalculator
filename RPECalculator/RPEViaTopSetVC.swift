//
//  PREViaTopSetVC.swift
//  RPECalculator
//
//  Created by michele Miller on 11/07/17.
//
//

import UIKit

class RPEViaTopSetVC: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    //MARK: - Outlets
    @IBOutlet weak var completedWeight: UITextField!
    @IBOutlet weak var weightToUseLbl: UILabel!
    @IBOutlet weak var repsAndRpePicker: UIPickerView!
    @IBOutlet weak var completedRepsAndRpePicker: UIPickerView!
    
    
    //MARK: - Variables
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
        calculateOneRepMax()
        calculateDesiredWeight()

    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDoneOnKeyboard()
        repsAndRpePicker.delegate = self
        repsAndRpePicker.dataSource = self
        completedRepsAndRpePicker.delegate = self
        completedRepsAndRpePicker.dataSource = self
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGestures))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        print("Identifier = \(identifier)")
    }
    @IBAction func EdittingEnd(_ sender: Any) {
        print("End Editting")
        if(completedWeight.text != ""){
            calculateOneRepMax()
            calculateDesiredWeight()
        }
    }
    
    @objc func handleGestures(gesture: UISwipeGestureRecognizer){
        if(gesture.direction == UISwipeGestureRecognizerDirection.right){
            print("Swipe working")
            self.dismissDetail()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func calculateDesiredWeight(){
        let tempReps = pickerData[repComponent][repsAndRpePicker.selectedRow(inComponent: repComponent)]
        let tempRpe = pickerData[rpeComponent][repsAndRpePicker.selectedRow(inComponent: rpeComponent)]
        userRpe.reps = Double(tempReps)!
        userRpe.rpe = Double(tempRpe)!
        self.view.endEditing(true)
        weightToUseLbl.text = ("\(userRpe.calculateDesiredWeight())\(identifier!)")
        print(weightToUseLbl.text)
        
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        completedWeight.inputAccessoryView = keyboardToolbar
        
    }
    
    
    //MARK: - Actions
    @IBAction func tapGesture(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    //MARK: - Instance Methods
    func calculateOneRepMax(){
        guard let weight = completedWeight.text, weight != "" else{
            userRpe.oneRepMax = 0.0
            print("In Guard")
            return
        }
        let completedReps = pickerData[repComponent][completedRepsAndRpePicker.selectedRow(inComponent: repComponent)]
        let completedRpe = pickerData[rpeComponent][completedRepsAndRpePicker.selectedRow(inComponent: rpeComponent)]
        userRpe.calculateOneRepMax(weight: Double(weight)!, completedReps: Double(completedReps)!, atRpe: Double(completedRpe)!)
        
        
        //use Calculate one rep max from userRpe section
        
    }
}
