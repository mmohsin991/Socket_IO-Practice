//
//  ViewController.swift
//  Socket_IO Practice
//
//  Created by Mohsin on 21/03/2016.
//  Copyright © 2016 Mohsin. All rights reserved.
//

import UIKit



class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
        
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.1.XXX:3000")!)

    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
}


class ViewController: UIViewController {
//    let socket = SocketIOClient(socketURL: NSURL(string: "http://sharedride.softlume.com/:8000")!, options: [.Reconnects(false), .ReconnectAttempts(0), .Log(true), .ForceWebsockets(true)])
    let socket = SocketIOClient(socketURL: NSURL(string: "http://sharedride.softlume.com/:8000")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.socket.connect()

        
//        self.socket.on("connected") {data, ack in
//            print("socket connected")
//            print(data)
//            
//            self.socket.emit("send", ["name": "foo"])
//
//        }
//        
//        self.socket.on("received") {data, ack in
//            print("received :")
//            print(data)
//            self.showAlert(data.description)
//        }
//
       
        
        
        self.socket.on("login_complete") {data, ack in
            print("login_complete :")
            print(data)
            self.showAlert(data.description)
        }
        

        self.socket.on("register_complete") {data, ack in
            print("login_complete :")
            print(data)
            self.showAlert(data.description)
        }
        
        
//        socket.on("currentAmount") {data, ack in
//            if let cur = data[0] as? Double {
//                self.socket.emitWithAck("canUpdate", cur)(timeoutAfter: 0) {data in
//                    self.socket.emit("update", ["amount": cur + 2.50])
//                }
//                
//                ack.with("Got your currentAmount", "dude")
//            }
//        }
        
        self.socket.connect()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func showAlert(message : String){
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let alert = UIAlertView(title: "Alert", message: message, delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
        }
    }
    
    
    @IBAction func send(sender: UIButton) {
//        self.socket.emit("send", ["name": "foo"])

//        let loginParameters = ["email": "abc@gmail.com" , "password" : "12345678"]
//        self.socket.emit("login", loginParameters)

        
        
        let registerParameters = ["username": "abc123" , "password" : "12345678"]
        self.socket.emit("register", registerParameters)
        
        
    }
}

