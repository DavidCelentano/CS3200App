//
//  DBAPIService.swift
//  GovData
//
//  Created by David Celentano on 4/18/18.
//  Copyright © 2018 David Celentano. All rights reserved.
//

import SwiftyJSON
import RxCocoa
import RxSwift

class DBAPIService {

    var senNames: Variable<[String]> = Variable([])
    var senBody: Variable<[String]> = Variable([])
    
    func getSenators() {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "https://cs3200-currancelentanobenham.herokuapp.com/api/senators")!)
        request.httpMethod = "GET"
        // send request
        let task = session.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            // parse data
            if let data = data {
                let jsonData = JSON(data)
                let senList = jsonData["data"]
                for entry in senList {
                    self?.senNames.value.append((entry.1["fname"].string ?? " ") + " " + (entry.1["lname"].string ?? " "))
                    let state = entry.1["state"].string ?? " "
                    let party = entry.1["party"].string ?? " "
                    let website = entry.1["website"].string ?? " "
                    self?.senBody.value.append("State: " + state + "\n\nParty: " + party + "\n\nWebsite: " + website)
                }
                print("Senators Retrieved")
            }
            if error != nil {
                print("Error while getting senators")
            }
        })
        task.resume()
    }
    
}
