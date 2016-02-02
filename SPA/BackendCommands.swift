//
//  BackendCommands.swift
//  SPA
//
//  Created by Coder on 2/1/16.
//  Copyright © 2016 OWA. All rights reserved.
//



/* 
How to signup

func registerUserAsync() {

let user = BackendlessUser()
user.email = "james.bond@mi6.co.uk"
user.password = "iAmWatchingU"

backendless.userService.registering(user,
response: { (registeredUser : BackendlessUser!) -> () in
print("User has been registered (ASYNC): \(registeredUser)")
},
error: { ( fault : Fault!) -> () in
print("Server reported an error: \(fault)")
}
)
}


How to create an order object and create the object in backendless

let order = Order()
order.item = "Dilla"
backendless.persistenceService.of(Order.ofClass()).save(order)


login function that will print the error

func loginUserAsync() {
backendless.userService.login(
"hockey7722@yahoo.com", password:"my_super_password",
response: { (var registeredUser : BackendlessUser!) -> () in
print("User has been logged in (ASYNC): \(registeredUser)")
},
error: { (var fault : Fault!) -> () in
print("Server reported an error: \(fault.detail)")
}
)
}


*/