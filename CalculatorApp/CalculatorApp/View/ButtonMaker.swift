//
//  ButtonMaker.swift
//  CalculatorApp
//
//  Created by t2023-m0072 on 11/21/24.
//

import UIKit

class ButtonMaker {
    /// UIButton을 생성하는 메서드
    /// - Parameter titleValues: UIButton의 title이 될 문자열
    /// - Returns: UIButton
    static func makeButtons(_ titleValues: String) -> UIButton {
        let button = UIButton()
        
        button.setTitle(titleValues, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.layer.cornerRadius = 40
        
        if let _ = Int(titleValues) {
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            return button
        }
        else {
            button.backgroundColor = .orange
            return button
        }
    }
    
}
