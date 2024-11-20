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
        let expression = NSExpression(format: expression)   // 입력받은 문자열로 NSExpression 클래스의 인스턴스
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            // 결과값 Int로 타입캐스팅, 성공시 반환
            return result
        } else {
            // 결과값이 Int로 변환 불가능 할 경우 nil 반환
            return nil
        }
    }
}

class LabelManager {
    var label: UILabel
    
    init(label: UILabel) {
        self.label = label        
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 60)
    }

    /// label.text를 변경하기 위해 호출되는 메서드
    /// - Parameter input: UIButton의 title
    func changeLabelText(_ input: String) {
        // 타이틀이 숫자일 때 handleNumberInput 메서드 호출
        if let number = Int(input) {
            handleNumberInput(input)
        }
        // 타이틀이 기호일 때 inputOperation 메서드 호출
        else {
            handleOperationInput(input)
        }
    }
    
    /// label.text의 첫 글자가 0인지 판단 후 label.text 값 변경
    /// - Parameter input: UIButton의 title
    func handleNumberInput(_ input: String) { // 매개변수로 버튼의 타이틀이 넘어옴
        let first = label.text ?? "0"
        print("handleNumberInput 메서드 호출됨")
        first == "0" ? label.text = input : label.text?.append(input)
    }
    
    /// 누른 버튼이 기호일 때 호출되는 메서드
    /// - Parameter input: UIButton의 title
    func handleOperationInput(_ input: String) {
        // 기호가 "=" 일 때
        if input == "=" {
            if let validResult = Calculatation.calculate(expression: label.text ?? "0") {
                label.text = String(validResult)
            }
        }
        // 기호가 "AC" 또는 연산 기호일때
        else {
            input == "AC" ? label.text = "0" : updateLastChar(input)
        }
    }
    
    /// 연산 기호가 연속으로 눌리는 것을 막기 위한 메서드
    /// - Parameter input: UIButton의 title
    func updateLastChar(_ input: String) {
        let last = label.text?.last
        // label.text의 마지막 입력이 연산 기호일 때
        if last == "+" || last == "-" || last == "*" || last == "/" {
            var text = label.text   // label.text의 값 text에 저장
            text?.removeLast()  // 마지막 기호 제거
            text?.append(input) // 새로 입력한 연산 기호 버튼의 타이틀을 마지막에 추가
            label.text = text   // label.text의 값을 새로운 문자열로 교체
        }
        // label.text의 마지막 문자가 연산기호가 아닐때
        else {
            label.text?.append(input)
        }
    }
    func printLabel() { print("LabelManager의 label.text = \(label.text)") }
}

class ButtonManager {
    let labelManager: LabelManager
    
    init(labelManager: LabelManager) {
        self.labelManager = labelManager
    }
    
    /// UIButton을 생성하는 메서드
    /// - Parameter titleValues: UIButton의 title이 될 문자열
    /// - Returns: UIButton
    func makeButtons(_ titleValues: String) -> UIButton {
        let button = UIButton()
        button.setTitle(titleValues, for: .normal) // 모든 버튼의 타이틀을 입력받은 titleValues로 설정
        button.setTitleColor(.white, for: .normal)  // 모든 버튼의 title 색을 하얀색으로 설정
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30) // 모든 버튼의 폰트를 bold, 크기 30으로 설정
        button.layer.cornerRadius = 40 // 모든 버튼의 모서리를 40으로 설정
        
        button.addTarget(self, action: #selector(clickButton), for: .touchDown) // 버튼이 눌렸을 때 clickButton 메서드 호출
        
        if let _ = Int(titleValues) {
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0) // 숫자 버튼의 배경색 설정
            return button
        }
        else {
            button.backgroundColor = .orange // title이 숫자가 아닐 경우 배경을 오랜지색으로 설정
            return button
        }
    }
    
    /// 버튼이 눌렸을 때 동작 하는 메서드
    /// - Parameter sender: 클릭 이벤트를 발생시킨 UIButton 객체
    @objc func clickButton(_ sender: UIButton) {
        if let title = sender.title(for: .normal) { // 타이틀 값은 옵셔널 타입이라 옵셔널 바인딩
            print("\(title) 버튼이 눌림")
            labelManager.changeLabelText(title)  // 버튼의 타이틀을 매개변수로 전달
            labelManager.printLabel()
        }
    }
}

class StackViewMaker {
    /// horizontal Stack View를 생성하는 메서드
    /// - Parameter views:horizontal Stack View에 들어갈 UIButton 배열
    /// - Returns: horizontal UIStackView
    static func makeHorizontalStackView(_ views: [UIView]) -> UIStackView { // 버튼을 배열로 입력 받아서 스택뷰를 반환
        let horizontalStackView = UIStackView(arrangedSubviews: views)
        horizontalStackView.axis = .horizontal
        horizontalStackView.backgroundColor = .black
        horizontalStackView.spacing = 10
        horizontalStackView.distribution = .fillEqually
        
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(80)   // 스택 뷰 높이 80으로 설정
        }
        
        return horizontalStackView
    }
    
    /// vertical Stack View를 생성하는 메서드
    /// - Parameter stackViewList: vertical Stack View에 들어갈 horizontal UIStackView 배열
    static func makeVerticalStackView(_ stackViewList: [UIStackView]) -> UIStackView {    // 스택뷰를 배열로 받아서 세로로 쌓는 스택뷰
        let verticalStackView = UIStackView(arrangedSubviews: stackViewList)
        verticalStackView.axis = .vertical  // 세로 스택뷰로 설정
        verticalStackView.backgroundColor = .black
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        
        return verticalStackView
    }
}

class ViewController: UIViewController {
    
    var labelManager: LabelManager!
    var buttonManager: ButtonManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // 라벨 생성
        var label = UILabel()
        labelManager = LabelManager(label: label)
        buttonManager = ButtonManager(labelManager: labelManager)
        view.addSubview(label) // 라벨을 뷰에 추가
        
        label.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.top.equalToSuperview().offset(200)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        // 버튼의 타이틀 배열
        let buttonTitles = ["7", "8", "9", "+", "4", "5", "6", "-", "1", "2", "3", "*", "AC", "0", "=", "/"]
        // 버튼 생성
        let buttons = buttonTitles.map { buttonManager.makeButtons($0) }
        
        // 수평 스택 뷰 배열
        var horizontalStackViews: [UIStackView] = []
        
        for index in stride(from: 0, to: buttons.count, by: 4) {
            let selectedButton = Array(buttons[index..<index+4])
            let horizontalStackView = StackViewMaker.makeHorizontalStackView(selectedButton)
            horizontalStackViews.append(horizontalStackView)
        }
        
        // 수평 스택뷰 배열을 수직 스택뷰에 넣기
        let verticalStackView = StackViewMaker.makeVerticalStackView(horizontalStackViews)
        
        view.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
