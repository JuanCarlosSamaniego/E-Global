//
//  DetailDataReceivedViewController.swift
//  E-Global
//
//  Created by Juan Carlos on 16/03/23.
//

import UIKit
import CoreData

class DetailDataReceivedViewController: UIViewController {
    
    @IBOutlet weak var tableViewDataReceived: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var dataReceivedArray: [ReceivedData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        setupTableViewForDataReceived()
        getAllDataReceived()
    }
}

extension DetailDataReceivedViewController {
    // MARK: - CoreData
    func getAllDataReceived() {
        do {
            dataReceivedArray = try context.fetch(ReceivedData.fetchRequest())
            DispatchQueue.main.async {
                self.tableViewDataReceived.reloadData()
            }
        }
        catch {}
    }
    
    func createdataReceived(clave: String, respuesta: String) {
        let newItem = ReceivedData(context: context)
        newItem.clave = clave
        newItem.respuesta = respuesta
        do {
            try context.save()
            self.tableViewDataReceived.reloadData()
        } catch { print("error") }
    }
    
    func deleteItemDataReceived(id: ReceivedData  ) {
        context.delete(id)
        do {
            try context.save()
            getAllDataReceived()
        }
        catch { }
    }
}

extension DetailDataReceivedViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableViewForDataReceived() {
        tableViewDataReceived.delegate = self
        tableViewDataReceived.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataReceivedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "mycell")
        let dataModel = dataReceivedArray[indexPath.row]
        cell.textLabel?.text = dataModel.respuesta
        cell.detailTextLabel?.text = dataModel.clave
        cell.imageView?.image = UIImage(systemName: "square.and.arrow.down.on.square")
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline).withSize(18)
        return cell
    }
}

