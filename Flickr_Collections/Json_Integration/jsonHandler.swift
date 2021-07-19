//
//  jsonHandler.swift
//  Flickr_Collections
//
//  Created by Sivakumar on 19/07/21.
//

import Foundation
import Alamofire

class jsonHandler {
    static let sharedInstance: jsonHandler = jsonHandler()
    
    func makeGetCall(url: String, completionHandler: @escaping (_ responseObject: DataResponse<Any>?,_ error:Error?  ) -> ()) {
        
        let params = ["api_key": AppInfo.API_Key,
                      "gallery_id":AppInfo.gallery_id,
                      "format":AppInfo._format,
                      "nojsoncallback":AppInfo.nojsoncallback]
        
        Alamofire.request(url, method: .get, parameters: nil ,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            switch response.result {
            case .success:
                
                let jsonDict = response.result.value as? [String:Any] ?? [:]
                print("hitted---->",jsonDict)
                
                completionHandler (response ,response.result.error)
                break
            case .failure(let error):
                
                print("OMG---->",error)
                completionHandler(nil,error)
                
                break
            }
        }
    }

}
