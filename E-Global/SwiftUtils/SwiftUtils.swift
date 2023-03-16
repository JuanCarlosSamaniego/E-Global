//
//  SwiftUtils.swift
//  E-Global
//
//  Created by Juan Carlos on 16/03/23.
//

import Foundation
import UIKit
import CryptoKit
import CryptoSwift
import CommonCrypto

class SwiftUtils {
    static func showAlertDefaultAction(title:String,message:String,inController:UIViewController,style:UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "Aceptar", style: .default) { action in }
        alertController.addAction(okAction)
        inController.present(alertController, animated: true, completion: nil)
    }
    
   static func PresentNavigationToLargeView(viewController: UIViewController, fromView: UIViewController) {
       viewController.sheetPresentationController?.detents = [.medium(), .large()]
           viewController.sheetPresentationController?.largestUndimmedDetentIdentifier = .medium
           viewController.sheetPresentationController?.prefersGrabberVisible = true
            fromView.present(viewController, animated: true, completion: nil)
       }
}


    extension String {
        func aesEncrypt(key:String, iv:String, options:Int = kCCOptionPKCS7Padding) -> String? {
            if let keyData = key.data(using: String.Encoding.utf8),
                let data = self.data(using: String.Encoding.utf8),
                let cryptData    = NSMutableData(length: Int((data.count)) + kCCBlockSizeAES128) {

                let keyLength              = size_t(kCCKeySizeAES128)
                let operation: CCOperation = UInt32(kCCEncrypt)
                let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
                let options:   CCOptions   = UInt32(options)

                var numBytesEncrypted :size_t = 0
                let cryptStatus = CCCrypt(operation,
                                          algoritm,
                                          options,
                                          (keyData as NSData).bytes, keyLength,
                                          iv,
                                          (data as NSData).bytes, data.count,
                                          cryptData.mutableBytes, cryptData.length,
                                          &numBytesEncrypted)

                if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                    cryptData.length = Int(numBytesEncrypted)
                    let base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
                    return base64cryptString
                }
                else {
                    return nil
                }
            }
            return nil
        }


        func aesDecrypt(key:String, iv:String, options:Int = kCCOptionPKCS7Padding) -> String? {
            if let keyData = key.data(using: String.Encoding.utf8),
                let data = NSData(base64Encoded: self, options: .ignoreUnknownCharacters),
                let cryptData    = NSMutableData(length: Int((data.length)) + kCCBlockSizeAES128) {

                let keyLength              = size_t(kCCKeySizeAES128)
                let operation: CCOperation = UInt32(kCCDecrypt)
                let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
                let options:   CCOptions   = UInt32(options)
                var numBytesEncrypted :size_t = 0
                let cryptStatus = CCCrypt(operation,
                                          algoritm,
                                          options,
                                          (keyData as NSData).bytes, keyLength,
                                          iv,
                                          data.bytes, data.length,
                                          cryptData.mutableBytes, cryptData.length,
                                          &numBytesEncrypted)

                if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                    cryptData.length = Int(numBytesEncrypted)
                    let unencryptedMessage = String(data: cryptData as Data, encoding:String.Encoding.utf8)
                    return unencryptedMessage
                }
                else {
                    return nil
                }
            }
            return nil
        }
    }


