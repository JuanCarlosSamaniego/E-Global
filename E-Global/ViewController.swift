//
//  ViewController.swift
//  E-Global
//
//  Created by Juan Carlos on 15/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
