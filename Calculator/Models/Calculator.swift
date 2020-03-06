import Foundation

struct Calculator {
    
    private let DEFAULT_NUMBER: Double = 0.0
        
    var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func calculate(_ symbol: String, number: Double) -> Double {
        switch symbol {
            case "AC":
                intermediateCalculation = nil
                return DEFAULT_NUMBER
            case "+/-":
                return number * -1
            case "%":
                return number * 0.01
            case "÷", "×", "-", "+":
                intermediateCalculation = (n1: number, calcMethod: symbol)
                return number
            case "=":
                return calculate(number)
            default:
                fatalError("Invalid symbol: \(symbol)")
        }
    }
    
    mutating private func calculate(_ n2: Double) -> Double {
        if let calculation = intermediateCalculation {
            intermediateCalculation = nil
            let n1 = calculation.n1
            switch calculation.calcMethod {
                case "÷":
                    return n1 / n2
                case "×":
                    return n1 * n2
                case "-":
                    return n1 - n2
                case "+":
                    return n1 + n2
                default:
                    fatalError("Invalid calculation symbol: \(calculation.calcMethod)")
            }
        }
        return n2
    }
}
