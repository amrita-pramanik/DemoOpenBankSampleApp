//
//  ApiNetworkManager.swift
//  OpenBankSampleProj
//
//  Created by Amrita on 01/02/22.
//

import Foundation

struct NetworkApiService {
    
    func getData(completion : @escaping (MarvelCharacterJsonData?) -> ())
    {
        let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=22-01-2022&apikey=139fe9a743907534db2b353d323352da&hash=7ab018948296c525bd3c037ca15baf4c")!
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error = \(error)")
            }
            
            else {
                
                do {
                    if let responseData = data {
                        
                        let decoder = JSONDecoder()
                                decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let responseData = try decoder.decode(MarvelCharacterJsonData.self, from: responseData)
                        completion(responseData)
                        
                    }
                    
                }
                catch {
                    print("Catch :", error.localizedDescription)
                }
                
            }
            
        }.resume()
        
        
        /*let dataTask = session.dataTask(with: serviceURL!) { (serviceData, serviceResponse, error) in
            
            if(error == nil)
            {
                let httpResponse = serviceResponse as! HTTPURLResponse
                if (httpResponse.statusCode == 200)
                {
                    let jsonData = try? JSONSerialization.jsonObject(with: serviceData!, options: .mutableContainers)
                    
                    print("Parse url=> \(jsonData!)")
//                    let resultDic = jsonData as! Dictionary<String, Any>
//                    print(resultDic["title"]!)
                }
            }
        }
        dataTask.resume()*/
    }

}
