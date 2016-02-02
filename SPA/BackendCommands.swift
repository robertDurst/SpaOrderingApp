//
//  BackendCommands.swift
//  SPA
//
//  Created by Coder on 2/1/16.
//  Copyright © 2016 OWA. All rights reserved.
//



/*

How to create an order object and create the object in backendless

let order = Order()
order.item = "Dilla"
backendless.persistenceService.of(Order.ofClass()).save(order)

How To get an object

func fetchingFirstPageAsync() {


backendless.persistenceService.of(Restaurant.ofClass()).find(
BackendlessDataQuery(),
response: { (var restaurants : BackendlessCollection!) -> () in
var currentPage = restaurants.getCurrentPage()
print("Loaded \(currentPage.count) restaurant objects")
print("Total restaurants in the Backendless starage - \(restaurants.totalObjects)")

for restaurant in currentPage {
print("Restaurant name = \(restaurant.name)")
}
error: { (var fault : Fault!) -> () in
println("Server reported an error: \(fault)")
})
}



*/