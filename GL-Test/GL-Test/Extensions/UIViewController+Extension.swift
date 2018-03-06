//
//  UIViewController+Extension.swift
//  GL-Test
//
//  Created by Marcelo Perretta on 06/03/2018.
//  Copyright © 2018 MAWAPE. All rights reserved.
//

import UIKit

import Foundation
import UIKit

public  extension UIViewController {
    
    /**
     Creates an intance of `UIViewController` based in a storyboard file name
     - returns: An instance of `UIViewController`
     */
    class func create() -> UIViewController {
        if let name = NSStringFromClass(self).components(separatedBy: ".").last {
            return UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        }
        return UIViewController()
    }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "ACCEPT", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

