//
//  MenuDataSource.swift
//  SPA
//
//  Created by Coder on 2/2/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import Foundation

class StatusChecker{
    
    var ordersForStatus:Array<[String]>
    
    init(){
        
        ordersForStatus = []
        
        
    }
    
    func fetchingFirstPage(userId: String) -> Array<[String]>{
        var ordersForStatus:Array<[String]> = []
        
        var menuItems = backendless.data.of(toApprove.ofClass()).find(BackendlessDataQuery())
        
        var currentPage = menuItems.getCurrentPage()
        
        for object in currentPage as! [toApprove] {
            if userId == object.ownerId{
                let item = object.item
                ordersForStatus.append([item!, "Approving"])

            }
            
        }
        
        menuItems = backendless.data.of(toCharge.ofClass()).find(BackendlessDataQuery())
        
        currentPage = menuItems.getCurrentPage()
        
        for object in currentPage as! [toCharge] {
            if userId == object.ownerId{
                let item = object.item
                ordersForStatus.append([item!, "Charging"])
                
            }
            
        }
        
        menuItems = backendless.data.of(toCook.ofClass()).find(BackendlessDataQuery())
        
        currentPage = menuItems.getCurrentPage()
        
        for object in currentPage as! [toCook] {
            if userId == object.ownerId{
                let item = object.item
                ordersForStatus.append([item!, "Cooking"])
                
            }
            
        }
        
        menuItems = backendless.data.of(toPickup.ofClass()).find(BackendlessDataQuery())
        
        currentPage = menuItems.getCurrentPage()
        
        for object in currentPage as! [toPickup] {
            if userId == object.ownerId{
                let item = object.item
                ordersForStatus.append([item!, "Ready for Pickup"])
                
            }
            
        }
        
        return ordersForStatus
        
    }
    
}