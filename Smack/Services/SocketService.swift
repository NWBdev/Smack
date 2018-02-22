//
//  SocketService.swift
//  Smack
//
//  Created by Nathaniel Burciaga on 2/21/18.
//  Copyright © 2018 Nathaniel Burciaga. All rights reserved.
// https://github.com/socketio/socket.io-client-swift

import UIKit
import SocketIO
class SocketService: NSObject {

    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    
    func establishConnection() {
        manager.defaultSocket.connect()
    }
    
    func closeConnection() {
        manager.defaultSocket.disconnect()
    }
    
    func addChannel(name: String, channelDescription: String, completion: @escaping CompletionHandler) {
        manager.defaultSocket.emit("newChannel", name, channelDescription)
        completion(true)
    }
 
    
    func getChannel(completion: @escaping CompletionHandler) {
        manager.defaultSocket.on("channelCreated") { (dataArray, ack) in
        guard let name = dataArray[0] as? String else { return }
        guard let description = dataArray[1] as? String else { return }
        guard let id = dataArray[2] as? String else { return }
        let newChannel = Channel(channelTitle: name, channelDescription: description, id: id)
        MessageService.instance.channels.append(newChannel)
        completion(true)
        }
    }
    
    
    
    
}
