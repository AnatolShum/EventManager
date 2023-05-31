//
//  EventsListViewController.swift
//  EventViewer
//
//  Created by Ilya Kharlamov on 1/26/23.
//

import UIKit

class EventsListViewController: UITableViewController, UISearchResultsUpdating {
    
    // MARK: - Outlets
    
    private lazy var logoutBarButtonItem = UIBarButtonItem(
        title: "Logout",
        style: .plain,
        target: self,
        action: #selector(EventsListViewController.logout)
    )
    
    private lazy var addItem = UIBarButtonItem(
        image: UIImage(systemName: "plus"),
        style: .plain,
        target: self,
        action: #selector(addNewItem)
        )
    
    // MARK: - Variables
    
    private let eventManager: EventManager
    let searchController = UISearchController()
    
    var items: [Event] = []
    var filteredItems: [Event] = []
    
    // MARK: - Lifecycle
    
    init(eventManager: EventManager) {
        self.eventManager = eventManager
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EventListCell.self, forCellReuseIdentifier: EventListCell.reuseIdentifier)
        items = eventManager.fetchEvents()
        configureUI()
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        filteredItems = items
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        items = eventManager.fetchEvents()
        filteredItems = items
        tableView.reloadData()
    }
    
    // MARK: - Configuration
    
    private func configureUI() {
        navigationItem.title = "Events List"
        navigationItem.rightBarButtonItem = self.logoutBarButtonItem
        navigationItem.leftBarButtonItem = self.addItem
    }
    
    // MARK: - Actions
    
    @objc
    private func logout() {
        eventManager.capture(.logout)
        let vc = LoginViewController(eventManager: eventManager)
        let navVc = UINavigationController(rootViewController: vc)
        present(navVc, animated: true)
    }
    
    @objc
    private func addNewItem() {
        pushToNewEventController()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventListCell.reuseIdentifier, for: indexPath) as! EventListCell
        let item = filteredItems[indexPath.row]
        if #available(iOS 15.0, *) {
            let date = item.createdAt.formatted(date: .numeric, time: .shortened)
            cell.configureCell(identifier: item.id, date: date)
        } else {
            let date = "\(item.createdAt)"
            cell.configureCell(identifier: item.id, date: date)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = filteredItems[indexPath.row]
            
            eventManager.deleteEvent(event: item)
            items.remove(at: indexPath.row)
            filteredItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filteredItems[indexPath.row]
        
        pushToDetailController(item)
    }
    
    private func pushToNewEventController() {
        let newEvent = NewEventViewController(eventManager: eventManager)
        navigationController?.pushViewController(newEvent, animated: true)
    }
    
    private func pushToDetailController(_ event: Event) {
        let detailEvents = DetailEventsViewController(eventManager: eventManager)
        detailEvents.event = event
        navigationController?.pushViewController(detailEvents, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchingString = searchController.searchBar.text,
           searchingString.isEmpty == false {
            filteredItems = items.filter({ (item) -> Bool in
                item.id.localizedCaseInsensitiveContains(searchingString)
            })
        } else {
            filteredItems = items
        }
        tableView.reloadData()
    }
    
}
