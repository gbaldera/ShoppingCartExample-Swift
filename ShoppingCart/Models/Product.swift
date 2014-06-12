//
//  Product.swift
//  ShoppingCart
//
//  Created by Jose Gustavo Rodriguez Baldera on 6/10/14.
//  Copyright (c) 2014 Jose Gustavo Rodriguez Baldera. All rights reserved.
//

import Foundation

class Product : NSObject
{
    var id: CInt
    var name: String
    var image: String
    var price: Double
    
    convenience init()
    {
        self.init(id: 0, name: "", image: "", price: 0)
    }
    
    init(id: CInt, name: String, image: String, price: Double)
    {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
    }
    
    class func listProducts() -> Product[]
    {
        var products = Product[]()
        
        let db = FMDatabase(path:Db.getDatabasePath())
        
        db.open()
        
        var results = db.executeQuery("SELECT * FROM products", withArgumentsInArray: [])
        
        while results.next()
        {
            var product = Product()
            product.id = results.intForColumn("id")
            product.name = results.stringForColumn("name")
            product.image = results.stringForColumn("image")
            product.price = results.doubleForColumn("price")
            
            products.append(product)
        }
        
        db.close()
        
        return products
    }
}
