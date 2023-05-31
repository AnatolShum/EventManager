//
//  EventListCell.swift
//  EventViewer
//
//  Created by Anatolii Shumov on 30/05/2023.
//

import UIKit

class EventListCell: UITableViewCell {
    static let reuseIdentifier = "EventListCell"
    
    let identifierLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .left
        return label
    }()
    
    let dateLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .right
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        addSubview(identifierLabel)
        addSubview(dateLabel)
        
        identifierLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            identifierLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            identifierLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            identifierLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: identifierLabel.trailingAnchor)
        ])
    }
    
    func configureCell(identifier: String, date: String) {
        identifierLabel.text = identifier
        dateLabel.text = date
    }

}
