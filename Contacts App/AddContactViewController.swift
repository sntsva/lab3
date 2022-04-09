//
//  AddContactViewController.swift
//  Contacts App
//
//  Created by Alua Santassova on 06.04.2022.
//

import UIKit

class AddContactViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    var pickerData: [String] = [String]()
    var pickerView = UIPickerView()
    var gender = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.genderPicker.delegate = self
        self.genderPicker.dataSource = self
        title = "New Contact"
        pickerData = [" ", "male", "female"]
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
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

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender = pickerData[row]
        genderPicker.resignFirstResponder()
    }
    @IBAction func deleteCont(_ sender: UIButton) {
        
    }
    
}
