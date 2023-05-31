//
//  NewEvent.swift
//  EventViewer
//
//  Created by Anatolii Shumov on 30/05/2023.
//

import UIKit

class NewEventViewController: UITableViewController {
    
    private let eventManager: EventManager
    
    private lazy var saveBarButtonItem = UIBarButtonItem(
        title: "Save",
        style: .plain,
        target: self,
        action: #selector(saveNewEvent)
    )
    
    init(eventManager: EventManager) {
        self.eventManager = eventManager
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(NewEventCell.self, forCellReuseIdentifier: NewEventCell.reuseIdentifier)
        configureUI()
    }

    @objc func saveNewEvent() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! NewEventCell
        let id = cell.identifierTextField.text ?? ""
        let date = cell.datePicker.date
        let parametrs = cell.parametrsTextView.text ?? ""
        
        eventManager.capture(.saveNewEvent(id: id, parametrs: parametrs, date: date))
        popToRootViewController()
    }
    
    private func popToRootViewController() {
            navigationController?.popToRootViewController(animated: true)
    }
    
    private func configureUI() {
        navigationItem.title = "New Event"
        saveBarButtonItem.isEnabled = false
        navigationItem.rightBarButtonItem = self.saveBarButtonItem
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
        let cell = tableView.dequeueReusableCell(withIdentifier: NewEventCell.reuseIdentifier, for: indexPath) as! NewEventCell
        
        cell.selectionStyle = .none
        cell.delegate = self
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension NewEventViewController: NewEventCellDelegate {
    func saveButtonIsEnable(isNotEmpty: Bool) {
        switch isNotEmpty {
        case true:
            saveBarButtonItem.isEnabled = true
        case false:
            saveBarButtonItem.isEnabled = false
        }
    }
    
    
}
