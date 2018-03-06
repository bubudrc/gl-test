//
//  ItemDetailRouter.swift
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

@objc protocol ItemDetailRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ItemDetailDataPassing
{
  var dataStore: ItemDetailDataStore? { get }
}

class ItemDetailRouter: NSObject, ItemDetailRoutingLogic, ItemDetailDataPassing
{
  weak var viewController: ItemDetailViewController?
  var dataStore: ItemDetailDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: ItemDetailViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ItemDetailDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
