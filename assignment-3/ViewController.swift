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

    private var leftPlusOrMinus: Int = PositiveNegative.negative.rawValue
    private var rightPlusOrMinus: Int = PositiveNegative.negative.rawValue

    private var leftAbsValue: Int = 0
    private var rightAbsValue: Int = 0
            
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
        if sender == numberTextField1 {
            leftAbsValue = Int(numberTextField1.text ?? "") ?? 0
            leftNumberLabel.text = "\(leftAbsValue * leftPlusOrMinus)"
        } else {
            rightAbsValue = Int(numberTextField2.text ?? "") ?? 0
            rightNumberLabel.text = "\(rightAbsValue * rightPlusOrMinus)"
        }
    }
    
    // SwitchのOn/OffによってPlusまたはMinusを切り替える。
    @objc private func switchValueChanged(sender: UISwitch) {
        // スイッチがOnのときNegativeにする。
        if sender == leftSwitch {
            leftPlusOrMinus = (sender.isOn ? PositiveNegative.negative : PositiveNegative.positive).rawValue
            leftNumberLabel.text = "\(leftAbsValue * leftPlusOrMinus)"
        } else {
            rightPlusOrMinus = (sender.isOn ? PositiveNegative.negative : PositiveNegative.positive).rawValue
            rightNumberLabel.text = "\(rightAbsValue * rightPlusOrMinus)"
        }
    }

    // Calculate Buttonを押したときに左ラベルと右ラベルの値を単純計算して結果ラベルに表示する
    @IBAction func tapCalculateButton(_ sender: UIButton) {
        resultLabel.text = "\(leftAbsValue * leftPlusOrMinus + rightAbsValue * rightPlusOrMinus)"
    }
}
