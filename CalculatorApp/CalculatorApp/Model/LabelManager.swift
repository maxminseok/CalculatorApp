//
//  LabelManager.swift
//  CalculatorApp
//
//  Created by t2023-m0072 on 11/21/24.
//

import UIKit

class LabelManager {
    var inputText: String
    var label: UILabel
    
    init(label: UILabel) {
        self.label = label
        inputText = "0"
    }
    
    /// label.text를 변경하기 위해 호출되는 메서드
    /// - Parameter input: UIButton의 title
    func changeLabelText(_ input: String) {
        if let _ = Int(input) {
            handleNumberInput(input)
        }
        else {
            handleOperationInput(input)
        }
    }
    
    /// label.text의 첫 글자가 0인지 판단 후 label.text 값 변경
    /// - Parameter input: UIButton의 title
    func handleNumberInput(_ input: String) {
        if inputText == "0" {
            inputText = input
        }
        else {
            inputText.append(input)
        }
        label.text = inputText
    }
    
    /// 누른 버튼이 기호일 때 호출되는 메서드
    /// - Parameter input: UIButton의 title
    func handleOperationInput(_ input: String) {
        switch input {
        case "=":
            performCalculation()
        case "AC":
            resetLabel()
        default:
            updateLastChar(input)
        }
    }
    
    /// 연산 기호 연속 입력 방지 메서드
    /// - Parameter input: UIButton의 title
    func updateLastChar(_ input: String) {
        let last = inputText.last
        
        if isOperator(last) {
            inputText.removeLast()
        }
        inputText.append(input)
        label.text = inputText
    }
    
    /// "=" 버튼이 눌렸을 때 동작하는 메서드
    func performCalculation() {
        if let result = Calculatation.calculate(expression: inputText) {
            inputText = String(result)
        } else {
            inputText = "Error"
        }
        label.text = inputText
    }
    
    /// "AC" 버튼이 눌렸을 때 동작하는 메서드
    func resetLabel() {
        inputText = "0"
        label.text = inputText
    }
    
    /// 연산 기호가 눌렸을 때 마지막 글자를 체크하는 메서드
    /// - Parameter character: label의 마지막 글자
    /// - Returns: 마지막 글자가 연산기호면 true, 아니면 false
    func isOperator(_ character: Character?) -> Bool {
        return character == "+" || character == "-" || character == "*" || character == "/"
    }
}
