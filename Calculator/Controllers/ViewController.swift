import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber: Bool = true
    private var calculator = Calculator()

    private var currentInput: String {
        get {
            return displayLabel.text!
        }
        set {
            displayLabel.text = newValue
        }
    }
    
    private var currentNumber: Double {
        get {
            guard let number = Double(currentInput) else {
                fatalError("Invalid input: \(currentInput) cannot be converted to a Double")
            }
            return number
        }
        set {
            let isInt = floor(newValue) == newValue
            currentInput = isInt ? String(Int(newValue)) : String(newValue)
        }
    }

    // TODO:
    // eg. when input is 85 and % is pressed multiple times (result will be 8.5e-05 for example). Then issues occur, like > numbers can be appended on numButtonPressed
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        if let symbol = sender.currentTitle {
            currentNumber = calculator.calculate(symbol, number: currentNumber)
            if symbol != "%" && symbol != "+/-" {
                isFinishedTypingNumber = true
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let newInput = sender.currentTitle {

//            if !(newInput == "0" && currentInput == "0") {
            
            if isFinishedTypingNumber { // Start with first input
                let optionalLeadingZero = newInput == "." ? "0" : ""
                currentInput = optionalLeadingZero + newInput
                isFinishedTypingNumber = false
            } else if newInput == "." {
                if !currentInput.contains(".") { // Only add the dot if there has none been added yet
                    currentInput += "."
                }
            }
            else {
                currentInput = currentInput + newInput
            }
        }
    }
}
