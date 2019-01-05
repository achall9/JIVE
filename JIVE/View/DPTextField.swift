//
//  DPTextField.swift
//  JIVE
//
//  Created by Lee Sheng Jin on 2018/12/2.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class DPTextField: UITextField {
    func initField() {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        self.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.handleDatePicker), for: .valueChanged)
    }
    @objc func handleDatePicker(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.text = dateFormatter.string(from: sender.date)
    }
}
