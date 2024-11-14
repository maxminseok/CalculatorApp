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
        configureUI()
        
        // 버튼 배열 생성
        let buttons = makeButtons()
        let selectedButtons = Array(buttons[0..<4])
    
        // 스택뷰 생성
        let horizontalStackView = makeHorizontalStackView(selectedButtons)

    }
    
    private func configureUI() {
        view.backgroundColor = .black
        
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
    
    func makeButtons() -> [UIButton] { // 버튼 배열 반환하는 메서드 -> makeHorizontalStackView에 사용 예정
        let buttonTitles = ["7", "8", "9", "+", "4", "5", "6", "-", "1", "2", "3", "*", "AC", "0", "=", "/"]
        //let buttonTitles = ["7", "8", "9", "+"]
        return buttonTitles.map { title in // buttonTitles를 순회하며 클로저가 반환한 버튼으로 새로운 버튼 배열 만들어 반환
            let button = UIButton() // 반환할 버튼 만들기
            button.setTitle(title, for: .normal) // 7,8,9,...=,/ 까지 매개변수로 전달받아서 버튼 타이틀로 사용
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30) // 모든 버튼의 글자를 Bold폰트 크기 30으로 통일
            button.setTitleColor(.white, for: .normal) // 모든 버튼의 글자색 흰색으로 통일
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0) // 배경색 통일
            button.layer.cornerRadius = 40 // 모든 버튼 원형으로 설정
            return button // buttonTitles의 요소 하나를 적용한 버튼 하나 반환
        }
    }
    
    func makeHorizontalStackView(_ views: [UIView]) -> UIStackView { // 버튼을 배열로 입력 받아서 스택뷰를 반환..?
        let horizontalStackView = UIStackView(arrangedSubviews: views) // 버튼 배열 스택뷰에 추가
        horizontalStackView.axis = .horizontal // 수직 스택뷰로 설정
        horizontalStackView.backgroundColor = .black // 배경 색 설정
        horizontalStackView.spacing = 10 // 버튼끼리 간격 10으로 설정
        horizontalStackView.distribution = .fillEqually // 모든 버튼 일정한 간격으로 배치시키기

        // 스택뷰 뷰에 추가
        view.addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.top.equalTo(label.snp.bottom).offset(60) // label과 간격 20으로 설정
            $0.leading.trailing.equalToSuperview().inset(20) // 좌우 간격 20으로 설정
        }
        
        return horizontalStackView
    }
    
    /*
     private func stackViewUI() {
     buttonSeven.setTitle("7", for: .normal)
     buttonEight.setTitle("8", for: .normal)
     buttonNine.setTitle("9", for: .normal)
     buttonPlus.setTitle("+", for: .normal)
     
     [buttonSeven, buttonEight, buttonNine, buttonPlus]
     .forEach {
     $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
     $0.setTitleColor(.white, for: .normal)
     $0.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
     $0.layer.cornerRadius = 40
     }
     
     let horizontalStackView = UIStackView(arrangedSubviews: [buttonSeven, buttonEight, buttonNine, buttonPlus])
     horizontalStackView.axis = .horizontal          // horizontal 스택뷰로 설정
     horizontalStackView.backgroundColor = .black
     horizontalStackView.spacing = 10
     horizontalStackView.distribution = .fillEqually // 모든 요소가 동일한 크기로 분배됨
     
     view.addSubview(horizontalStackView)
     
     horizontalStackView.snp.makeConstraints {
     $0.height.equalTo(80)
     $0.top.equalTo(label.snp.bottom).offset(20) // label과 간격 20으로 설정
     $0.trailing.equalToSuperview().offset(-20)
     $0.leading.equalToSuperview().offset(20)
     
     }
     
     }
     */
    
    
}

#Preview {
    ViewController()
}
