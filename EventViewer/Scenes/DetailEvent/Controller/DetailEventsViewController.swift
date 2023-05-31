//
//  DetailEvents.swift
//  EventViewer
//
//  Created by Anatolii Shumov on 30/05/2023.
//

import UIKit

class DetailEventsViewController: UITableViewController {
    
    private let eventManager: EventManager
    
    var event: Event?
    
    init(eventManager: EventManager) {
        self.eventManager = eventManager
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(DetailEventsCell.self, forCellReuseIdentifier: DetailEventsCell.reuseIdentifier)
        configureUI()
    }
    
    private func configureUI() {
        title = event?.id
        tableView.separatorStyle = .none
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailEventsCell.reuseIdentifier, for: indexPath) as! DetailEventsCell
        
        if #available(iOS 15.0, *) {
            let date = event?.createdAt.formatted(date: .numeric, time: .shortened) ?? ""
            cell.configureCell(identifier: event?.id ?? "", date: date, parametrs: parametersString())
        } else {
            let date = String(describing: event?.createdAt)
            cell.configureCell(identifier: event?.id ?? "", date: date, parametrs: parametersString())
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
        
        let deleteButton: UIButton = {
           let button = UIButton()
            button.backgroundColor = .red.withAlphaComponent(0.7)
            button.setTitle("Delete", for: .normal)
            button.setTitleColor(.white, for: .normal)
            return button
        }()
        
        deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        
        footerView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 2),
            deleteButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -2),
            deleteButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 2),
            deleteButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -2)
        ])
        
        return footerView
    }
    
    
    @objc func deleteItem() {
        eventManager.deleteEvent(event: event!)
        
        popToRootViewController()
    }
    
    private func popToRootViewController() {
            navigationController?.popToRootViewController(animated: true)
    }
    
    typealias FormattedString = String
    private func parametersString() -> FormattedString {
        let key = event?.parameters.map { $0.key }.first
        let value = event?.parameters.map { $0.value.asString }.first
        
        return  """
                \(key ?? "Empty")\t
                \(value ?? "")
                """
    }

}
