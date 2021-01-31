//
//  UIViewController+SetNavigationBar.swift
//  Scherzo
//
//  Created by Mike Shevelinsky on 31.01.2021.
//

import UIKit

extension UIViewController {
    func setNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = Colors.pink
    }
}
