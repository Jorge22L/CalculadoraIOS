//
//  ViewController.swift
//  Calculadora
//
//  Created by jorge on 27/7/21.
//

import UIKit

enum Operation: String{
    case addition = "+"
    case substract = "-"
    case multiplication = "*"
    case division = "/"
    case equal = "="
}

class CalculadoraViewController: UIViewController {
    
    private var leftOperating : Double?
    private var operation : Operation?
    private var hasFinishEntering = false

    @IBOutlet weak var entryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchNumber(_ sender: UIButton) {
        var currentValue = self.entryLabel.text ?? ""
        let enterValue = sender.title(for: .normal)!
        
        if ("0" == currentValue || hasFinishEntering) {
            currentValue = ""
            hasFinishEntering = false
        }
        self.entryLabel.text = "\(currentValue)\(enterValue)"
    }
    
    private func performOperation(_ operation: Operation, withOperando operando: Double) {
           if (leftOperating == nil) {
               if (operation == .equal || operando == 0) {
                   return;
               }

               leftOperating = operando;
               self.operation = operation;
               hasFinishEntering = true
           } else {
               guard let leftOperating = self.leftOperating, let establishedOperation = self.operation else {
                   return;
               }

               let result: Double;
               switch establishedOperation {
               case .addition:
                   result = leftOperating + operando
               case .substract:
                   result = leftOperating - operando
               case .multiplication:
                   result = leftOperating * operando
               case .division:
                   result = leftOperating / operando
               default:
                   result = 0
                   print("\(establishedOperation) is not supported")
               }
               
               self.leftOperating = nil
               self.operation = nil
               if (operation != .equal) {
                   performOperation(operation, withOperando: result)
               }
            entryLabel.text = result.clean
        }
    }
    
    
    @IBAction func touchOperator(_ sender: UIButton) {
        let operando = Double(self.entryLabel.text!)!
        let operation = Operation(rawValue: sender.title(for: .normal)!)!
                
        performOperation(operation, withOperando: operando)
    }
    
    
    @IBAction func clean() {
        self.entryLabel.text = "0"
        self.leftOperating = nil
        self.operation = nil
        self.hasFinishEntering = false
    }
    
}

