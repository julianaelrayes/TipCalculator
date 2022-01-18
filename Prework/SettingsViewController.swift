//
//  SettingsViewController.swift
//  Prework
//
//  Created by Juliana El Rayes on 5/1/22.
//

import UIKit


class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var defaultTipTextField: UITextField!
    
    let currency = ["$","€","£","¥"]
    let defaultTip = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"]
    
    
    var currencyPickerView = UIPickerView()
    var defaultTipPickerView = UIPickerView()
    var defaultTipAssigned = ""
    
    
    // Creating 2 picker views
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return currency.count
        case 2:
            return defaultTip.count
        default:
            return 1
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return currency[row]
        case 2:
            return defaultTip[row] + "%"
        default:
            return "Data not found."
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            // Updates the global variable _currencyLabel with the default currency selected by the user
            _currencyLabel = currency[row]
            
            currencyTextField.text = currency[row]
            currencyTextField.resignFirstResponder()
        case 2:
            // Updates the default tip variable (does not include "%") with the default tip selected by the user
            defaultTipAssigned = defaultTip[row]
            
            defaultTipTextField.text = defaultTip[row] + "%"
            defaultTipTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    
    @IBAction func SaveChanges(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
        
        // Resets the values of bill amount and party size to default when the user saves changes
        _bill = 0
        _partySize = 1
        
        // Set user defaults
        if (currencyTextField.text != "" || defaultTipTextField.text == "") {
            UserDefaults.standard.set(currencyTextField.text, forKey: "myDefaultCurrency")
        }
        if (defaultTipTextField.text != "" || currencyTextField.text == "") {
            UserDefaults.standard.set(defaultTipAssigned, forKey: "myDefaultTip")
        }
        if (defaultTipTextField.text == "" || currencyTextField.text == "") {
            _currencyLabel = "$"
        }
        else
        {
            UserDefaults.standard.set(currencyTextField.text, forKey: "myDefaultCurrency")
            UserDefaults.standard.set(defaultTipAssigned, forKey: "myDefaultTip")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondController = segue.destination as! ViewController
        secondController.currencylabel = currencyTextField.text!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyTextField.inputView = currencyPickerView
        defaultTipTextField.inputView = defaultTipPickerView
        
        currencyTextField.placeholder = _currencyLabel
        defaultTipTextField.placeholder = String(_tipPercentage) + "%"
        
        currencyTextField.textAlignment = .center
        defaultTipTextField.textAlignment = .center
        
        currencyPickerView.delegate = self
        defaultTipPickerView.delegate = self
        
        currencyPickerView.tag = 1
        defaultTipPickerView.tag = 2
        
        // Sets the title in the Navigation Bar on white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.title = "Settings"
    }
    
    

}
