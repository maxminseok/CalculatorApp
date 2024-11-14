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
    let buttonSeven = UIButton()
    let buttonEight = UIButton()
    let buttonNine = UIButton()
    let buttonPlus = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        stackViewUI()
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


}

#Preview {
    ViewController()
}
