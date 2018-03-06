//
//  LoadItemsRouter.swift
//  GL-Test
//
//  Created by Marcelo Perretta on 06/03/2018.
//  Copyright (c) 2018 MAWAPE. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol LoadItemsRoutingLogic
{
  func navigateToItemDetail(withItem item: Item)
}

protocol LoadItemsDataPassing
{
  var dataStore: LoadItemsDataStore? { get }
}

class LoadItemsRouter: NSObject, LoadItemsRoutingLogic, LoadItemsDataPassing
{
  weak var viewController: LoadItemsViewController?
  var dataStore: LoadItemsDataStore?
  
  // MARK: Routing
    func navigateToItemDetail(withItem item: Item) {
        if let itemDetailVC = ItemDetailViewController.create() as? ItemDetailViewController{
            itemDetailVC.itemSelected = item
            self.viewController?.navigationController?.pushViewController(itemDetailVC, animated: true)
        }
    }
}