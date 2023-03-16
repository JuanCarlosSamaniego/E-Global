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

    var dataReceived: [DataReceived] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        
        setupTableViewForDataReceived()
    }
}

extension DetailDataReceivedViewController {
    // MARK: - CoreData
    func getAllGoals() {
        do {
            dataReceived = try context.fetch(DataReceived.fetchRequest())
            DispatchQueue.main.async {
                self.tableViewDataReceived.reloadData()
            }
        }
        catch {}
    }
    
    /// Crear un folio compartido por algun usuario.
    func createNewGoal(titleGoals: String) {
        let newitem = DataReceived(context: context)
        newitem.respuesta = titleGoals
        newitem.clave = ""
        do {
            try context.save()
            self.tableViewDataReceived.reloadData()
        }
        catch{ }
    }
    /// Permite eliminar un folio de la lista de folios.
    func deleteFolioPorCompartir(folio: DataReceived  ) {
        context.delete(folio)
        do {
            try context.save()
            getAllGoals()
        }
        catch {}
    }
}


extension DetailDataReceivedViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableViewForDataReceived() {
        tableViewDataReceived.delegate = self
        tableViewDataReceived.dataSource = self
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "mycell")
             //  let data = filterData[indexPath.row]
               cell.textLabel?.text = "respuesta"
               cell.detailTextLabel?.text = "clave"
               cell.imageView?.image = UIImage(systemName: "square.and.arrow.down.on.square")
               cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline).withSize(18)
               return cell
    }
    
    
}

