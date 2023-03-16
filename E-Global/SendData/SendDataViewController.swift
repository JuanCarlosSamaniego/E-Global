//
//  SendDataViewController.swift
//  E-Global
//
//  Created by Juan Carlos on 16/03/23.
//

import UIKit

class SendDataViewController: UIViewController {
    
    @IBOutlet weak var txtClave: UITextField!
    @IBOutlet weak var lblShowData: UILabel!
    @IBOutlet weak var lblEncryp: UILabel!
    let iv = "gqLOHUioQ0QjhuvI" // length == 16
    let KeyEncryp = "AES"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func didTapEncrypData(sender:Any) {
        if txtClave.text == "" {
            SwiftUtils.showAlertDefaultAction(title: "campo vacio", message: "el campo no debe estar vacio.", inController: self, style: .alert)
        } else {
            let data = txtClave.text
            lblEncryp.text = data?.aesEncrypt(key: KeyEncryp, iv: iv)
            let dataEncryp = lblEncryp.text
            lblShowData.text = dataEncryp?.aesDecrypt(key: KeyEncryp, iv: iv)
        }
    }
    
    
    @IBAction func didTapShowDataReceived(sender:Any) {
        let  detailView = DetailDataReceivedViewController()
        present(detailView, animated: true)
        
    }
}
