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
        
        // 버튼을 배열로 저장할 빈 배열 선언
        var buttons: [UIButton] = []
        
        // 버튼 배열 생성
        buttonTitles.forEach {
            buttons.append(makeButtons($0))
        }
        
        // 버튼 4개씩 자르기
        let selectedButtons1 = Array(buttons[0..<4])
        let selectedButtons2 = Array(buttons[4..<8])
        let selectedButtons3 = Array(buttons[8..<12])
        let selectedButtons4 = Array(buttons[12..<16])
        
        // 4개씩 자른 버튼을 가로 스택뷰에 넣기
        let horizontalStackView1 = makeHorizontalStackView(selectedButtons1)
        let horizontalStackView2 = makeHorizontalStackView(selectedButtons2)
        let horizontalStackView3 = makeHorizontalStackView(selectedButtons3)
        let horizontalStackView4 = makeHorizontalStackView(selectedButtons4)
        
        // 가로 스택뷰 배열로 만들기
        let stackViewList = [horizontalStackView1, horizontalStackView2, horizontalStackView3, horizontalStackView4]
        
        // 가로 스택뷰 배열을 세로 스택뷰에 넣기
        let verticalStackView = makeVerticalStackView(stackViewList)
    }
    
    // 라벨 만들기
    private func makeLabel() {
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
        button.addTarget(self, action: #selector(clickButton), for: .touchDown) // 버튼이 눌렸을 때 clickButton 메서드 호출, 매개변수로 titleValues를 넘김
        
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
    @objc func clickButton(_ sender: UIButton) {
        if let title = sender.title(for: .normal) { // 타이틀 값은 옵셔널 타입이라 옵셔널 바인딩
            if let number = Int(title) {    // 숫자 버튼 눌렀을 때
                if let first = label.text?.first, first == "0" { // 라벨 첫 글자가 0이면
                    label.text = String(number) // 입력한 숫자로 라벨 값 바꾸기
                }
                else {
                    label.text?.append(title)   // 첫글자가 0이 아니면 버튼의 타이틀 값을 라벨 값 뒤에 추가하기
                }
            }
            else {  // 기호 버튼 눌렀을 때
                if title == "AC" {  // AC를 눌렀으면
                    label.text = "0"    // 라벨 값 0으로 초기화
                }
                else if title == "=" {
                    
                }
                else {  // AC나 =이 아니라면 버튼의 타이틀 값을 라벨 값 뒤에 추가하기
                    label.text?.append(title)
                }
                
            }
        }
    }
}

//#Preview {
//    ViewController()
//}
