//
//  AppointmentDateSelectionDatePickerView.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 15.07.2022.
//

import UIKit

class AppointmentDateSelectionDatePickerView: UIStackView {

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .init(name: ApplicationFonts.bold.rawValue, size: 16)
        label.textColor = .white
        return label
    }()
    
    fileprivate lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        let maxDate = dateFormatter.date(from: "31-12-2022")!
        print("Max Date: \(maxDate)")
        datePicker.maximumDate = dateFormatter.date(from: "31-12-2022")
    
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged), for: .valueChanged)
        return datePicker
    }()
    
    private(set) lazy var textDatePicker: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .init(name: ApplicationFonts.regular.rawValue, size: 16)
        textField.tintColor = .clear
        textField.textColor = .white
        textField.inputView = datePicker
        textField.textAlignment = .right
        return textField
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.spacing = 15
        self.distribution = .fillEqually
        self.alignment = .center
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(textDatePicker)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("Touched")
        self.endEditing(true)
    }
    
    @objc private func datePickerValueChanged(sender: UIDatePicker){
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .long
        dateFormat.timeStyle = .none
        self.textDatePicker.text = dateFormat.string(from: sender.date)
    }
    

}
