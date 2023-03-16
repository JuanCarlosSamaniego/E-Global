//
//  HomeViewController.swift
//  E-Global
//
//  Created by Juan Carlos on 15/03/23.
//
import UIKit
import CoreBluetooth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableViewDevices: UITableView!
    
    let spinnerView: UIActivityIndicatorView = {
        let loginSpinner = UIActivityIndicatorView(style: .medium)
        loginSpinner.translatesAutoresizingMaskIntoConstraints = false
        loginSpinner.hidesWhenStopped = true
        return loginSpinner
    }()
    
    //MARK: -  Central Manager for CoreBluetooth
    var centralManager: CBCentralManager?
    var CBPeripherals = Array<CBPeripheral>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = "E-Global"
        navigationController?.navigationBar.prefersLargeTitles = true
        settupTableView()
        setupBlueToothConfig()
    }
    
    @IBAction func didTapScanDevices(sender: Any) {
        print("Start Scan.")
        startScan()
    }
    
    @IBAction func didTapSendRequest(sender: Any) {
        let vc = SendDataViewController()
        SwiftUtils.PresentNavigationToLargeView(viewController: vc, fromView: self)
    }
}


extension HomeViewController: CBCentralManagerDelegate {
    private func setupBlueToothConfig() {
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        centralManager?.delegate = self
    }
    
   private func startScan() {
        self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
        spinnerView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) {
            self.stopScan()
        }
    }
   private func stopScan() {
        self.centralManager?.stopScan()
        spinnerView.stopAnimating()
        spinnerView.isHidden = true
        print("Stop scan")
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if (central.state == .poweredOn) {
            startScan()
        }
        else {
            SwiftUtils.showAlertDefaultAction(title: "Bluetooth Apagado", message: "Es necesario encender el Bluetooth del dispositivo para ver los dispositivos cercanos.", inController: self, style: .alert)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if (!CBPeripherals.contains(peripheral)) {
            if peripheral.name == nil { }
            else {
                CBPeripherals.append(peripheral)
                tableViewDevices.reloadData()
            }
        }
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func settupTableView() {
        tableViewDevices.delegate = self
        tableViewDevices.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CBPeripherals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "mycell")
        let peripherals = CBPeripherals[indexPath.row]
        cell.textLabel?.text = peripherals.name
        cell.imageView?.image = UIImage(systemName: "airtag.radiowaves.forward.fill")
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline).withSize(18)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .clear
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = "otros dispositivos:"
        label.font = .boldSystemFont(ofSize: 18)
        headerView.addSubview(label)
        spinnerView.frame = CGRect.init(x: 170, y: 15, width: 20, height: 20)
        headerView.addSubview(spinnerView)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}



