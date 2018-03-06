//
//  Item.swift
//  GL-Test
//
//  Created by Marcelo Perretta on 06/03/2018.
//  Copyright © 2018 MAWAPE. All rights reserved.
//

import UIKit

///Protocol for objects retrieved by the server.
protocol ServerObject {
    init?(json:[String:Any])
}

class Item: NSObject, ServerObject {
    var title: String?
    var itemDescription: String?
    var imageURL: String?
    
    required init?(json: [String : Any]) {
        
        super.init()
        
        guard let dataJson = json as [String:Any]? else { return nil }
        
        
        self.title = dataJson["title"] as? String
        self.itemDescription = dataJson["description"] as? String
        self.imageURL = dataJson["image"] as? String
    }
}
