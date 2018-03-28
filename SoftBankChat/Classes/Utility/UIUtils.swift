//
//  UIUtils.swift
//  SoftBankChat
//
//  Created by NguyenVanChien on 3/13/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

class UIUtils: NSObject {
    
    class func viewControllerWithIndentifier(identifier: String, storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    class func storeObjectToUserDefault(_ object: AnyObject, key: String) {
        let dataSave = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults.standard.set(dataSave, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getObjectFromUserDefault(_ key: String) -> AnyObject? {
        if let object = UserDefaults.standard.object(forKey: key) {
            return NSKeyedUnarchiver.unarchiveObject(with: object as! Data) as AnyObject?
        }
        
        return nil
    }
    
    class func removeObjectForKey(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}
