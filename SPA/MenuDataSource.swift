//
//  MenuDataSource.swift
//  SPA
//
//  Created by Coder on 2/2/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import Foundation

class MenuDataSource{

    var menu:Array<[String]>
    
    init(){

        menu = []

        
    }
    
    func fetchingFirstPage() -> Array<[String]>{
        var menu:Array<[String]> = []
        
        let menuItems = backendless.data.of(Menu.ofClass()).find(BackendlessDataQuery())
        
        let currentPage = menuItems.getCurrentPage()
        
        for object in currentPage as! [Menu] {
            let name = object.name
            let description = object.Description
            let price = object.Price
            
            menu.append([name,description,price])
        }
        
        return menu
        
    }
    
}