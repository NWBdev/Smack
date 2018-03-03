//
//  MessageService.swift
//  Smack
//
//  Created by Nathaniel Burciaga on 2/20/18.
//  Copyright © 2018 Nathaniel Burciaga. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    
    var messages = [Message]()
    
    var unreadChannels = [String]()
    
    //variable for selected channels
    var selectedChannel : Channel?
    
    func findAllChannel (completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                do{
                    guard let data = response.data else { return }
                        if let json = try JSON(data: data).array {
                            for item in json {
                                let name = item["name"].stringValue
                                let channelDescription = item["description"].stringValue
                                let id = item["_id"].stringValue
                        
                                let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                                self.channels.append(channel)
                            }
                            print("FindAllChannel:")
                           // print(self.channels[0].channelTitle) test if channels exist if none crashes program!
                            NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                            completion(true)
                        }
                } catch {
                    debugPrint(error)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    // Function to get all messages
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        print("Ran FindAllMessages")
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                do{
                    guard let data = response.data else { return }
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            self.messages.append(message)
                        }
                        print("MESSAGE QUEUE: \(self.messages)")
                        completion(true)
                    }
                } catch {
                    debugPrint(error)
                }
            }   else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
            
        }

        
        
    }
    
    
    
    
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    
    
    
    
    
    
    
}
