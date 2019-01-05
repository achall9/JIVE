//
//  CustomTextField.swift
//  JIVE
//
//  Created by Lee Sheng Jin on 2018/12/2.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    var options: [String] = []
    let pickerView = UIPickerView()
    func initTextField() {
        pickerView.delegate = self
        self.inputView = pickerView
    }
}

extension CustomTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = options[row]
    }
}
