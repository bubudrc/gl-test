//
//  LoadItemsPresenter.swift
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

protocol LoadItemsPresentationLogic
{
  func presentItems(response: LoadItems.Data.Response)
}

class LoadItemsPresenter: LoadItemsPresentationLogic
{
  weak var viewController: LoadItemsDisplayLogic?
  
  // MARK: Do something
  
  func presentItems(response: LoadItems.Data.Response)
  {
    let viewModel = LoadItems.Data.ViewModel(items: response.items)
    viewController?.displayItems(viewModel: viewModel)
  }
}