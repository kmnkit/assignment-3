//
//  ViewController.swift
//  assignment-3
//
//  Created by Sungwoong Kang on 2022/01/21.
//

import UIKit

enum PositiveNegative: Int {
    case positive = 1
    case negative = -1
}

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
        let switches: [UISwitch] = [leftSwitch, rightSwitch]
        numberTextFields.forEach { textField in
            textField.keyboardType = .numberPad
            textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        }
        switches.forEach { negativeSwitch in
            negativeSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        }
    }
    
    // UITextFieldの値を変更したときの処理
    @objc private func textChanged(sender: UITextField) {
        // Senderが左のUITextFieldなら左の数字ラベルの値を変更し、右の場合は右のラベルの値を変更する
        if sender == numberTextField1 { // When Left Text Field Text changed
            changeLabelValue(textField: numberTextField1, positiveSwitch: leftSwitch, numberLabel: leftNumberLabel)
        } else { // When Right Text Field Text changed
            changeLabelValue(textField: numberTextField2, positiveSwitch: rightSwitch, numberLabel: rightNumberLabel)
        }
    }
    
    // SwitchのOn/OffによってPlusまたはMinusを切り替える。
    @objc private func switchValueChanged(sender: UISwitch) {
        if sender == leftSwitch { // When Left Switch value changed
            changeLabelValue(textField: numberTextField1, positiveSwitch: leftSwitch, numberLabel: leftNumberLabel)
        } else { // When Right Switch value changed
            changeLabelValue(textField: numberTextField2, positiveSwitch: rightSwitch, numberLabel: rightNumberLabel)
        }
    }
    
    // 引数として受け取ったTextFieldの値とSwitchの値によって同じく引数のLabelの値を変更する。
    private func changeLabelValue(textField: UITextField, positiveSwitch: UISwitch, numberLabel: UILabel) {
        let value = Int(textField.text ?? "") ?? 0
        numberLabel.text = "\(positiveSwitch.isOn ? -value : value)"
    }

    // Calculate Buttonを押したときに左ラベルと右ラベルの値を単純計算して結果ラベルに表示する
    @IBAction func tapCalculateButton(_ sender: UIButton) {
        let leftValue = Int(numberTextField1.text ?? "") ?? 0
        let rightValue = Int(numberTextField2.text ?? "") ?? 0
        resultLabel.text = "\((leftSwitch.isOn ? -leftValue : leftValue) + (rightSwitch.isOn ? -rightValue : rightValue))"
    }
}
