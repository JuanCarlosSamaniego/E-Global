//
//  LoginViewController.swift
//  E-Global
//
//  Created by Juan Carlos on 15/03/23.
//

import UIKit

class LoginViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
    }
    func setupLoginView() {
        title = "E-Global Login"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    @IBAction func didTapGoToHomeView(sender:Any) {
        goToHomeView()
    }
    
    func goToHomeView() {
        let home = HomeViewController()
        let navigation = UINavigationController(rootViewController: home)
        view.window?.windowScene?.keyWindow?.rootViewController = navigation
        view.window?.windowScene?.keyWindow?.makeKeyAndVisible()
    }
}
