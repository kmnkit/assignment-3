//
//  ViewController.swift
//  assignment-3
//
//  Created by Sungwoong Kang on 2022/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var numberTextField1: UITextField!
    @IBOutlet private weak var numberTextField2: UITextField!
    
    @IBOutlet private weak var leftSwitch: UISwitch!
    @IBOutlet private weak var rightSwitch: UISwitch!
    
    @IBOutlet private weak var leftNumberLabel: UILabel!
    @IBOutlet private weak var rightNumberLabel: UILabel!
        
    @IBOutlet private weak var resultLabel: UILabel!
            
    override func viewDidLoad() {
        super.viewDidLoad()

        let numberTextFields: [UITextField] = [numberTextField1, numberTextField2]
        numberTextFields.forEach { textField in
            textField.keyboardType = .numberPad
            textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        }

        let switches: [UISwitch] = [leftSwitch, rightSwitch]
        switches.forEach { negativeSwitch in
            negativeSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        }
    }
    
    // UITextFieldの値を変更したときの処理
    @objc private func textChanged(sender: UITextField) {
        updateResultLabel()
    }
    
    // SwitchのOn/OffによってPlusまたはMinusを切り替える。
    @objc private func switchValueChanged(sender: UISwitch) {
        updateResultLabel()
    }
    
    // Calculate Buttonを押したときに左ラベルと右ラベルの値を単純計算して結果ラベルに表示する
    @IBAction func tapCalculateButton(_ sender: UIButton) {
        updateResultLabel()
    }

    private func updateResultLabel() {
        let leftValue = Int(numberTextField1.text ?? "") ?? 0
        let rightValue = Int(numberTextField2.text ?? "") ?? 0

        let signedLeftValue = leftSwitch.isOn ? -leftValue : leftValue
        let signedRightValue = rightSwitch.isOn ? -rightValue : rightValue

        leftNumberLabel.text = String(signedLeftValue)
        rightNumberLabel.text = String(signedRightValue)

        resultLabel.text = String(signedLeftValue + signedRightValue)
    }
}
