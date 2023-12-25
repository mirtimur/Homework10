import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayResultLabel: UILabel!
    @IBOutlet weak var cButtonPressed: UIButton!
    
    var stillTiping = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign = ""
    var dotIsPlaced = false
    var currentInpunt: Double {
        get{
            return Double(displayResultLabel.text ?? "0") ?? 0
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            stillTiping = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    @IBAction func senderNumberButtonPressed(_ sender: UIButton) {
        guard let number = sender.titleLabel?.text else { return }
        
        if stillTiping{
            if displayResultLabel.text?.count ?? 0 < 9 {
                displayResultLabel.text = (displayResultLabel.text ?? "0") + number
            }
        } else {
            displayResultLabel.text = number
            stillTiping = true
        }
    }
    
    @IBAction func twoOperandSignButtonPressed(_ sender: UIButton) {
        operationSign = sender.titleLabel?.text ?? "0"
        firstOperand = currentInpunt
        stillTiping = false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double){
        currentInpunt = operation(firstOperand, secondOperand)
        stillTiping = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTiping{
            secondOperand = currentInpunt
        }
        dotIsPlaced = false
        
        switch operationSign {
        case "÷":
            operateWithTwoOperands{$0 / $1}
        case "×":
            operateWithTwoOperands{$0 * $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "+":
            operateWithTwoOperands{$0 + $1}
        default: break
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInpunt = 0
        displayResultLabel.text = "0"
        stillTiping = false
        dotIsPlaced = false
        operationSign = ""
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInpunt = -currentInpunt
    }
    
    @IBAction func presentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInpunt = currentInpunt / 100
        } else {
            secondOperand = firstOperand * currentInpunt / 100
        }
        stillTiping = false
    }
    
    @IBAction func commaButtonPressed(_ sender: UIButton) {
        if stillTiping && !dotIsPlaced {
            displayResultLabel.text = (displayResultLabel.text ?? "0") + "."
            dotIsPlaced = true
        } else if !stillTiping && !dotIsPlaced {
            displayResultLabel.text = "0."
        }
    }
}
