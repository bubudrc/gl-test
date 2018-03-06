//
//  ItemDetailViewController.swift
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

protocol ItemDetailDisplayLogic: class
{
  func displaySomething(viewModel: ItemDetail.Something.ViewModel)
}

class ItemDetailViewController: UIViewController, ItemDetailDisplayLogic
{
  var interactor: ItemDetailBusinessLogic?
  var router: (NSObjectProtocol & ItemDetailRoutingLogic & ItemDetailDataPassing)?

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    var itemSelected: Item?
    
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = ItemDetailInteractor()
    let presenter = ItemDetailPresenter()
    let router = ItemDetailRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    if let item = itemSelected {
        if let imageURL = item.imageURL {
            itemImageView.downloadedFrom(link: imageURL)
        }
        
        itemTitleLabel.text = item.title
        itemDescriptionTextView.text = item.itemDescription ?? ""
    }
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething()
  {
    let request = ItemDetail.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: ItemDetail.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}