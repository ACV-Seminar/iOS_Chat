//
//  ApiResponse.swift
//  SoftBankChat
//
//  Created by NguyenVanChien on 3/14/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit
import Alamofire

class ApiResponse: NSObject {
    var success: Bool? = false
    var data: Any? = nil
    var code: Int? = 0
    var message: String? = ""
    
    //some data
    var count:Int = 0
    var countRequest : Int = 0
    var countResponse : Int = 0
    var currentPage = 0
    var totalPage = 0
    var url = ""
    var img_url = ""
    
    override init(){
        
    }
    
    init(response: DataResponse<Any>) {
        
        // Create default value
        code = 0
        message = "";
        
        if(response.result.isFailure){
            if let error = response.result.error as NSError? {
                code = error.code
            }
            //-1009 no internet
            //-1001 timeout
            if CodeType.isCodeNoInternetOrTimeOut(code: code!){
                message = ERROR_MESSAGE.ERROR_NO_INTERNET
            }
            
            success = false
        }
        
        do {
            let responseData = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: AnyObject]
            code = responseData[API_KEY_STATUS_CODE] as? Int
            if let code = self.code, code == 200 {
                success = true
            }
            else {
                success = false
                
            }
            
            message = responseData[API_KEY_MESSAGE] as? String
            data = responseData[API_KEY_DATA]
        } catch {
            print("Error")
        }
        
        if code != 200 {
            if self.message!.isEmpty {
                self.message = ERROR_MESSAGE.ERROR_NO_INTERNET
            }
        }
    }
    
    //Check timeout
    func isNoInternetOrTimeOut() -> Bool {
        if code == -1009 {
            return true
        }
        
        if code == -1001 {
            return true
        }
        
        return false
    }
}
