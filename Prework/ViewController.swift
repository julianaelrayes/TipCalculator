//
//  ViewController.swift
//  Prework
//
//  Created by Juliana El Rayes on 26/12/21.
//

import UIKit

var _total = 0.0
var _bill = 0.0

var _indBill = 0.0
var _partySize = 1

var _currencyLabel = "$"

var _tipValue = 0.0
var _tipPercentage = 0

class ViewController: UIViewController {

    
    @IBOutlet weak var currencyLabel_1: UILabel!
    @IBOutlet weak var BillAmountTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var TipAmount: UILabel!
    @IBOutlet weak var TipPercentageLabel: UILabel!
    @IBOutlet weak var PartySizeLabel: UILabel!
    @IBOutlet weak var AmountPerPerson: UILabel!
    
    var currencylabel = _currencyLabel
    var defaultTipPercentage = 0

    
    func recalculateAmounts(){
        // Recalculate values of either bill amount, or tip %, or party size
        _tipValue = 0.01 * Double(_tipPercentage) * _bill
        _total = _bill + _tipValue
        _indBill = _total/Double(_partySize)
        
        // Set labels to the current values of either bill amount, or tip %, or party size
        TipAmount.text = String(_currencyLabel) + String(format: "%.2f", _tipValue)
        totalLabel.text = String(_currencyLabel) + String(format: "%.2f", _total)
        AmountPerPerson.text = String(_currencyLabel) + String(format: "%.2f", _indBill)
    }
    
    
    func recalculateCurrency() {
        // Updates labels to the current currency
        currencyLabel_1.text = _currencyLabel
        totalLabel.text = _currencyLabel + String(format: "%.2f", _total)
        AmountPerPerson.text = _currencyLabel + String(format: "%.2f", _indBill)
        TipAmount.text = _currencyLabel + String(format: "%.2f", _tipValue)
    }
    
    
    @IBAction func BillAmount(_ sender: UITextField) {
        // Sets the value of the bill amount and a default value to 0
        _bill = Double(BillAmountTextField.text!) ?? 0
        // Updates the values and labels
        recalculateAmounts()
    }
    

    
    // Stepper for the Tip Percentage
    @IBAction func TipPercentageStepper(_ sender: UIStepper) {
        // if the user enters a default value for the tip percentage, this will be added to the current value of the stepper.
        if defaultTipPercentage > 0 {
            sender.value += Double(defaultTipPercentage)
            // The value of the global variable tip percentage will be updated with this new value
            _tipPercentage = Int(sender.value)
            // the temporarily variable will be set back to zero
            defaultTipPercentage = 0
        }
        // This stepper can have values between -100 and 100.
        if sender.value < 0 {
            // The global variable of tip percentage is set to 0 if the stepper holds a negative number
            _tipPercentage = 0
            // The stepper is set to 0
            sender.value = 0
        }
        else {
            // The global variable of tip percentage is set to the current value of the stepper
            _tipPercentage = Int(sender.value)
        }
        // Updates the Tip Percentage Amount Label
        TipPercentageLabel.text = String(_tipPercentage) + "%"
        // Updates the values and labels
        recalculateAmounts()
    }
    
    
    //Stepper for the Party Size
    @IBAction func PartySizeStepper(_ sender: UIStepper) {
        // Updates the value of global variable Party Size
        _partySize = Int(sender.value)
        // Updates the Party Size Label
        PartySizeLabel.text = String(_partySize)
        // Updates the values and labels
        recalculateAmounts()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the title in the Navigation Bar on white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.title = "Tip Calculator"
        
        // Sets the global variable of Default Tip to the user default of Tip Percentage
        _tipPercentage = UserDefaults.standard.integer(forKey: "myDefaultTip")
        // Sets the global variable of Currency Label to the user default of Currency
        _currencyLabel = UserDefaults.standard.string(forKey: "myDefaultCurrency") ?? "$"
        
        // Updates the values and labels
        recalculateAmounts()
        // Updates the labels with the current currency
        recalculateCurrency()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        // Sets the default of Tip Percentage
        if let x = UserDefaults.standard.integer(forKey: "myDefaultTip") as? Int {
            // Updates the temp variable of the default value for the tip percentage
            defaultTipPercentage = Int(x)
            // Updates the label of the tip percentage to the default value
            TipPercentageLabel.text = String(x) + "%"
            // Updates the values and labels
            recalculateAmounts()
        }
        
        // Sets the default of Currency
        if let y = UserDefaults.standard.string(forKey: "myDefaultCurrency") {
            // Updates the currency label
            if _currencyLabel != "" {
               _currencyLabel = String(y)
            }
            else {
               _currencyLabel = "$"
            }
            // Updates the labels with the current currency
            recalculateCurrency()
        }
    
    }
}
