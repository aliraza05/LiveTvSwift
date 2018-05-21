//
//  APIManager.swift
//  RESTAPIManager
//
//  Created by Petros Demetrakopoulos on 21/12/2016.
//  Copyright © 2016 Petros Demetrakopoulos. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    
    static let sharedInstance = APIManager()
    static let getPostsEndpoint = "/posts/"
    
    func fetchDataWithAppID(onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
    let url : String = BASE_URL
    let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
    
    var appVersion = "1.0"
        
    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    {
        appVersion = version
    }
        
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let params = ["id"        : String(APP_ID),
                  "auth_token": AUTH_TOKEN,
                  "build_no": appVersion]

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
