//
//  OkCancelAlert.swift
//  WorkOut
//
//  Created by d vasylenko on 18.05.2022.
//

import UIKit

extension UIViewController {
    
    func alertOkCancel(title: String, message: String?, completionHandler: @escaping() -> Void ) {
        
        let allertContrller = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert )
        
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        allertContrller.addAction(ok)
        allertContrller.addAction(cancel)
        present(allertContrller, animated: true )
    }
}
