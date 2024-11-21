//
//  ViewController.swift
//  CalculatorApp
//
//  Created by t2023-m0072 on 11/14/24.
//

import UIKit

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
