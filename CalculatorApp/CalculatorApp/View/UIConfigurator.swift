//
//  UIConfigurator.swift
//  CalculatorApp
//
//  Created by t2023-m0072 on 11/21/24.
//

import UIKit
import SnapKit

class UIConfigurator {
    /// UI 생성 메서드
    /// - Parameter viewController: UI를 설정 받을 ViewController의 객체
    static func settingUI(_ viewController: ViewController ) {
        viewController.view.backgroundColor = .black
        
        // 라벨 생성
        let label = LabelMaker.makeLabel()
        viewController.view.addSubview(label)
        label.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.top.equalToSuperview().offset(200)
            $0.trailing.equalToSuperview().offset(-30)
        }
        // 라벨 업데이트
        viewController.labelManager = LabelManager(label: label)
        
        // 버튼의 타이틀 배열
        let buttonTitles = ["7", "8", "9", "+", "4", "5", "6", "-", "1", "2", "3", "*", "AC", "0", "=", "/"]
        // 버튼 생성
        let buttons = buttonTitles.map { title in
            let button = ButtonMaker.makeButtons(title)
            button.addTarget(viewController, action: #selector(viewController.clickButton), for: .touchDown)
            return button
        }
        
        // 수평 스택 뷰 배열
        var horizontalStackViews: [UIStackView] = []
        for index in stride(from: 0, to: buttons.count, by: 4) {
            let selectedButton = Array(buttons[index..<index+4])
            let horizontalStackView = StackViewMaker.makeHorizontalStackView(selectedButton)
            horizontalStackViews.append(horizontalStackView)
        }
        
        // 수평 스택뷰 배열을 수직 스택뷰에 넣기
        let verticalStackView = StackViewMaker.makeVerticalStackView(horizontalStackViews)
        viewController.view.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
