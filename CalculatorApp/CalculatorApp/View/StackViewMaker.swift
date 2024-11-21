//
//  StackViewMaker.swift
//  CalculatorApp
//
//  Created by t2023-m0072 on 11/21/24.
//

import UIKit


class StackViewMaker {
    /// horizontal Stack View를 생성하는 메서드
    /// - Parameter views:horizontal Stack View에 들어갈 UIButton 배열
    /// - Returns: horizontal UIStackView
    static func makeHorizontalStackView(_ views: [UIView]) -> UIStackView {
        let horizontalStackView = UIStackView(arrangedSubviews: views)
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.backgroundColor = .black
        horizontalStackView.spacing = 10
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        return horizontalStackView
    }
    
    /// vertical Stack View를 생성하는 메서드
    /// - Parameter stackViewList: vertical Stack View에 들어갈 horizontal UIStackView 배열
    static func makeVerticalStackView(_ stackViewList: [UIStackView]) -> UIStackView {
        let verticalStackView = UIStackView(arrangedSubviews: stackViewList)
        
        verticalStackView.axis = .vertical
        verticalStackView.backgroundColor = .black
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        
        return verticalStackView
    }
}
