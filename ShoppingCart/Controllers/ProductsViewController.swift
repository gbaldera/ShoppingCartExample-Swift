//
//  ProductsViewController.swift
//  ShoppingCart
//
//  Created by Jose Gustavo Rodriguez Baldera on 6/5/14.
//  Copyright (c) 2014 Jose Gustavo Rodriguez Baldera. All rights reserved.
//

import UIKit

class ProductsViewController: UITableViewController {

    var products = Product[]()
    
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibName, bundle: nibBundle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        self.navigationItem.title = "Products"
        self.loadProducts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.products.count
    }
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell?
    {
        let cell = tableView!.dequeueReusableCellWithIdentifier("ProductCell") as ProductCell
        let product: Product = self.products[indexPath!.row]

        // Configure the cell...
        cell.productImage.image = UIImage(named: product.image)
        cell.productImage.contentMode = UIViewContentMode.ScaleAspectFit
        cell.productTitle.text = product.name
       
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = NSNumberFormatterRoundingMode.RoundDown
        let price = formatter.stringFromNumber(NSNumber.numberWithDouble(product.price))
        cell.productPrice.text = "$\(price)"
        
        cell.addToCartButton.addTarget(self, action: "addToCart:", forControlEvents: UIControlEvents.TouchUpInside)

        return cell
    }
    
    // #pragma mark - Utilities methods
    
    func loadProducts()
    {
        self.products = Product.listProducts()
        self.tableView.reloadData()
    }

    func addToCart(sender: UIButton!)
    {
        let alert = UIAlertView(title: "Prueba", message: "Hola klk", delegate: self, cancelButtonTitle: "Cancel")
        alert.show()
    }
    
}
