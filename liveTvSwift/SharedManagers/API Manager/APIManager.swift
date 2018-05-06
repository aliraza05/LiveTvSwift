//
//  APIManager.swift
//  RESTAPIManager
//
//  Created by Petros Demetrakopoulos on 21/12/2016.
//  Copyright © 2016 Petros Demetrakopoulos. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    let baseURL     = "https://live-sports-tv.herokuapp.com/api/applications/details"
    let AUTH_TOKEN  = "6d0c0cdc967caa3731516a7b6b6ebd33c64c92ac"
    
    //For app id 5
//    let AUTH_TOKEN  = "b50a576a7e6f77eb0c7b431f81f1b69771e7b409"

    let APP_ID = 6
    
    
    static let sharedInstance = APIManager()
    static let getPostsEndpoint = "/posts/"
    
    func fetchDataWithAppID(appID: Int, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
    let url : String = baseURL
    let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let params = ["id"        : String(APP_ID),
                  "auth_token": AUTH_TOKEN]

    let session = URLSession.shared
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                if(error != nil){
                    onFailure(error!)
                } else{
                    let result = JSON(data: data!)
                    print(result)
                    onSuccess(result)
                }
            })
            task.resume()
        } catch _ {
            print ("Oops something happened buddy")
            let errorTemp = NSError(domain:"Oops something happened buddy", code:404, userInfo:nil)
            onFailure(errorTemp)

        }
}

}
