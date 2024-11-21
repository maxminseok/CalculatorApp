//
//  Calculatation.swift
//  CalculatorApp
//
//  Created by t2023-m0072 on 11/21/24.
//

import UIKit

class Calculatation {
    /// label.text에 저장된 문자열을 연산할 때 호출되는 메서드
    /// - Parameter expression: 연산을 진행할 문자열 ex."1+2+3"
    /// - Returns: Optional Int 타입의 연산 결과 값
    static func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
}
