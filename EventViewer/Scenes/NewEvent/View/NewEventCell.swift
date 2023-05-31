//
//  NewEventCell.swift
//  EventViewer
//
//  Created by Anatolii Shumov on 30/05/2023.
//

import UIKit

protocol NewEventCellDelegate: AnyObject {
    func saveButtonIsEnable(isNotEmpty: Bool)
}

class NewEventCell: UITableViewCell {
    static let reuseIdentifier = "NewEventCell"
    
    weak var delegate: NewEventCellDelegate?
    
    let identifierTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.placeholder = "Enter identifier"
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray6.cgColor
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let datePicker: UIDatePicker = {
       let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 1
        datePicker.date = Date()
        datePicker.timeZone = TimeZone.current
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = UIColor.systemGray6.cgColor
        datePicker.layer.cornerRadius = 10
        return datePicker
    }()
    
    let parametrsTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = .justified
        textView.isScrollEnabled = true
        textView.textColor = .black
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray6.cgColor
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    let VerticalStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        identifierTextField.addTarget(self, action: #selector(textFieldValueChanged), for: .allEvents)

        addSubview(VerticalStackView)
        VerticalStackView.addArrangedSubview(identifierTextField)
        VerticalStackView.addArrangedSubview(datePicker)
        VerticalStackView.addArrangedSubview(parametrsTextView)
        
        VerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            VerticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            VerticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            VerticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            VerticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            identifierTextField.heightAnchor.constraint(equalToConstant: 30),
            parametrsTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func textFieldValueChanged() {
        if identifierTextField.text == "" {
            delegate?.saveButtonIsEnable(isNotEmpty: false)
        } else {
            delegate?.saveButtonIsEnable(isNotEmpty: true)
        }
    }

}
