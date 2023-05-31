//
//  DetailEventsCell.swift
//  EventViewer
//
//  Created by Anatolii Shumov on 30/05/2023.
//

import UIKit

class DetailEventsCell: UITableViewCell {
    static let reuseIdentifier = "DetailEventsCell"
    
    let identifierLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemGray6.cgColor
        label.layer.cornerRadius = 10
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemGray6.cgColor
        label.layer.cornerRadius = 10
        return label
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
    
    let verticalStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        return stackView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStackView.addArrangedSubview(identifierLabel)
        verticalStackView.addArrangedSubview(dateLabel)
        verticalStackView.addArrangedSubview(parametrsTextView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            identifierLabel.heightAnchor.constraint(equalToConstant: 30),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            parametrsTextView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func configureCell(identifier: String, date: String, parametrs: String) {
        identifierLabel.text = identifier
        dateLabel.text = date
        parametrsTextView.text = parametrs
    }

}
