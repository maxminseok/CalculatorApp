//
//  ViewController.swift
//  CalculatorApp
//
//  Created by t2023-m0072 on 11/14/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let label = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        makeLabel()
        
        let buttonTitles = ["7", "8", "9", "+", "4", "5", "6", "-", "1", "2", "3", "*", "AC", "0", "=", "/"]
        var buttons: [UIButton] = []
        
        // 버튼 배열 생성
        buttonTitles.forEach {
            buttons.append(makeButtons($0))
        }
        
        let selectedButtons1 = Array(buttons[0..<4])
        let selectedButtons2 = Array(buttons[4..<8])
        let selectedButtons3 = Array(buttons[8..<12])
        let selectedButtons4 = Array(buttons[12..<16])
        
        // 가로 스택뷰 생성
        let horizontalStackView1 = makeHorizontalStackView(selectedButtons1)
        let horizontalStackView2 = makeHorizontalStackView(selectedButtons2)
        let horizontalStackView3 = makeHorizontalStackView(selectedButtons3)
        let horizontalStackView4 = makeHorizontalStackView(selectedButtons4)
        
        let stackViewList = [horizontalStackView1, horizontalStackView2, horizontalStackView3, horizontalStackView4]
        
        // 세로 스택뷰 생성
        let verticalStackView = makeVerticalStackView(stackViewList)
    }
    
    private func makeLabel() {
        label.text = "12345"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 60)
        
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.top.equalToSuperview().offset(200)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
    
    func makeButtons(_ titleValues: String) -> UIButton {
        let button = UIButton()
        button.setTitle(titleValues, for: .normal) // 모든 버튼의 타이틀을 입력받은 titleValues로 설정
        button.setTitleColor(.white, for: .normal)  // 모든 버튼의 title 색을 하얀색으로 설정
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30) // 모든 버튼의 폰트를 bold, 크기 30으로 설정
        button.layer.cornerRadius = 40 // 모든 버튼의 모서리를 40으로 설정
        
        if let _ = Int(titleValues) {
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0) // 숫자 버튼의 배경색 설정
            return button
        }
        else {
            button.backgroundColor = .orange // title이 숫자가 아닐 경우 배경을 오랜지색으로 설정
            return button
        }
    }
    
    func makeHorizontalStackView(_ views: [UIView]) -> UIStackView { // 버튼을 배열로 입력 받아서 스택뷰를 반환
        let horizontalStackView = UIStackView(arrangedSubviews: views) // 버튼 배열 스택뷰에 추가
        horizontalStackView.axis = .horizontal // 수직 스택뷰로 설정
        horizontalStackView.backgroundColor = .black // 배경 색 설정
        horizontalStackView.spacing = 10 // 버튼끼리 간격 10으로 설정
        horizontalStackView.distribution = .fillEqually // 모든 버튼 일정한 간격으로 배치시키기
        
        // 스택뷰 뷰에 추가
        view.addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        return horizontalStackView
    }
    
    func makeVerticalStackView(_ stackViewList: [UIStackView]) {
        let verticalStackView = UIStackView(arrangedSubviews: stackViewList) // 4개의 스택뷰를 수직으로 쌓는 스택뷰
        verticalStackView.axis = .vertical
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
     
}

//#Preview {
//    ViewController()
//}
