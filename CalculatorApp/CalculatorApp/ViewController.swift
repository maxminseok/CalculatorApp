//
//  ViewController.swift
//  CalculatorApp
//
//  Created by t2023-m0072 on 11/14/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // 라벨 생성
        makeLabel()
        
        // 버튼의 타이틀 배열
        let buttonTitles = ["7", "8", "9", "+", "4", "5", "6", "-", "1", "2", "3", "*", "AC", "0", "=", "/"]
        
        // 버튼 생성
        let buttons = buttonTitles.map { makeButtons($0) }
        
        // 수평 스택 뷰 배열
        var horizontalStackViews: [UIStackView] = []
        
        for index in stride(from: 0, to: buttons.count, by: 4) {
            let selectedButton = Array(buttons[index..<index+4])
            let horizontalStackView = makeHorizontalStackView(selectedButton)
            horizontalStackViews.append(horizontalStackView)
        }
        
        // 가로 스택뷰 배열을 세로 스택뷰에 넣기
        let verticalStackView = makeVerticalStackView(horizontalStackViews)
    }
    
    // 라벨 만들기
    func makeLabel() {
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 60)
        
        view.addSubview(label) // 라벨을 뷰에 추가
        
        label.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.top.equalToSuperview().offset(200)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
    
    // 버튼 만들기
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
    
    // 가로 스택뷰 만들기
    func makeHorizontalStackView(_ views: [UIView]) -> UIStackView { // 버튼을 배열로 입력 받아서 스택뷰를 반환
        let horizontalStackView = UIStackView(arrangedSubviews: views) // 버튼 배열 스택뷰에 추가
        horizontalStackView.axis = .horizontal // 수직 스택뷰로 설정
        horizontalStackView.backgroundColor = .black // 배경 색 설정
        horizontalStackView.spacing = 10 // 버튼끼리 간격 10으로 설정
        horizontalStackView.distribution = .fillEqually // 모든 버튼 일정한 간격으로 배치시키기
        
        view.addSubview(horizontalStackView)    // 스택뷰를 뷰에 추가
        
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(80)   // 스택 뷰 높이 80으로 설정
        }
        
        return horizontalStackView
    }
    
    // 세로 스택 뷰 만들기
    func makeVerticalStackView(_ stackViewList: [UIStackView]) {    // 스택뷰를 배열로 받아서 세로로 쌓는 스택뷰
        let verticalStackView = UIStackView(arrangedSubviews: stackViewList)
        verticalStackView.axis = .vertical  // 세로 스택뷰로 설정
        verticalStackView.backgroundColor = .black
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        
        view.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    // 버튼이 눌렸을 때 동작 하는 메서드
    @objc func clickButton(_ sender: UIButton) {
        if let title = sender.title(for: .normal) { // 타이틀 값은 옵셔널 타입이라 옵셔널 바인딩
            changeLabelText(title)  // 버튼의 타이틀을 매개변수로 전달
        }
    }
    
    // 라벨의 텍스트를 변경하기 위해 호출되는 메서드
    func changeLabelText(_ input: String) { // 매개변수로 버튼의 타이틀이 넘어옴
        // 타이틀이 숫자일 때 handleNumberInput 메서드 호출
        if let number = Int(input) {
            handleNumberInput(input)
        }
        // 타이틀이 기호일 때 inputOperation 메서드 호출
        else {
            handleOperationInput(input)
        }
    }
    
    // 라벨의 텍스트 첫 글자가 0인지 판단 후 라벨 값 변경
    func handleNumberInput(_ input: String) { // 매개변수로 버튼의 타이틀이 넘어옴
        let first = label.text?.first
        first == "0" ? label.text = input : label.text?.append(input)
    }
    
    // 누른 버튼이 기호일 때 호출되는 메서드
    func handleOperationInput(_ input: String) {
        // 기호가 "=" 일 때
        if input == "=" {
            if let validResult = calculate(expression: label.text ?? "0") {
                label.text = String(validResult)
            }
        }
        // 기호가 "AC" 또는 연산 기호일때
        else {
            input == "AC" ? label.text = "0" : checkLabelLastText(input)
        }
    }
    
    // 연산 기호가 연속으로 눌리는 것을 막기 위한 메서드
    func checkLabelLastText(_ input: String) {
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
    
    // 숫자와 연산 기호로 이루어진 문자열을 연산할 때 호출되는 메서드
    func calculate(expression: String) -> Int? {
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

//#Preview {
//    ViewController()
//}
