//
//  SimpleAlert.swift
//  WorkOut
//
//  Created by d vasylenko on 21.04.2022.
//

import UIKit

extension UIViewController {
    
   func alertOk(title: String, message: String? ) {
       let allertContrller = UIAlertController(title: title, message: message, preferredStyle: .alert )
       let ok = UIAlertAction(title: "OK", style: .default)
       allertContrller.addAction(ok)
       present(allertContrller, animated: true )
    }
}
