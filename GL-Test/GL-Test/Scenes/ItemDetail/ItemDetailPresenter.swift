//
//  ItemDetailPresenter.swift
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

protocol ItemDetailPresentationLogic
{
  func presentSomething(response: ItemDetail.Something.Response)
}

class ItemDetailPresenter: ItemDetailPresentationLogic
{
  weak var viewController: ItemDetailDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: ItemDetail.Something.Response)
  {
    let viewModel = ItemDetail.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
