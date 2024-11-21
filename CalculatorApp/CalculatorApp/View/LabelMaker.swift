//
//  LabelMaker.swift
//  CalculatorApp
//
//  Created by t2023-m0072 on 11/21/24.
//

import UIKit

class LabelMaker {
    /// UILabel 생성 메서드
    /// - Returns: UILabel
    static func makeLabel() -> UILabel {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 60)
        
        return label
    }
}
