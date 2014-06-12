//
//  Db.swift
//  ShoppingCart
//
//  Created by Jose Gustavo Rodriguez Baldera on 6/10/14.
//  Copyright (c) 2014 Jose Gustavo Rodriguez Baldera. All rights reserved.
//

import Foundation

class Db
{
    class func getDatabasePath() -> String
    {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return delegate.databasePath!
    }
}
