//
//  ViewController.swift
//  CalculatorApp
//
//  Created by t2023-m0072 on 11/14/24.
//

import UIKit
import SnapKit

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
    
    /// 연산 기호가 연속으로 눌리는 것을 막기 위한 메서드
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
    /// - Returns: 마지막 글자가 연산기호면 true, 아니면 false 반환
    func isOperator(_ character: Character?) -> Bool {
        return character == "+" || character == "-" || character == "*" || character == "/"
    }
}

class LabelMaker {
    static func makeLabel() -> UILabel {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 60)
        
        return label
    }
}

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

class UIConfigurator {
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

class ViewController: UIViewController {
    
    var labelManager: LabelManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIConfigurator.settingUI(self)
    }
    
    /// 버튼이 눌렸을 때 호출되는 메서드
    /// - Parameter sender: 클릭 이벤트를 발생시킨 UIButton 객체
    @objc func clickButton(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            labelManager.changeLabelText(title)
        }
    }
}
