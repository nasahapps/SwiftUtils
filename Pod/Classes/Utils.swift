//
//  Utils.swift
//
//  Created by Hakeem on 8/19/15.
//  Copyright (c) 2015 Nasah Apps. All rights reserved.
//

import UIKit

public class Utils {
    
    public struct ScreenSize {
        public static let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
        public static let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height
        public static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        public static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        public static let IPHONE_WIDTH_35_4_PORT = CGFloat(320.0)
        public static let IPHONE_WIDTH_47_PORT = CGFloat(375.0)
        public static let IPHONE_WIDTH_55_PORT = CGFloat(414.0)
        public static let IPHONE_WIDTH_35_LAND = CGFloat(480.0)
        public static let IPHONE_WIDTH_4_LAND = CGFloat(568.0)
        public static let IPHONE_WIDTH_47_LAND = CGFloat(667.0)
        public static let IPHONE_WIDTH_55_LAND = CGFloat(736.0)
        public static let IPAD_MINIMUM_WIDTH = CGFloat(768.0)
        public static let IPAD_MAXIMUM_WIDTH = CGFloat(1024.0)
        public static let IPAD_MINIMUM_WIDTH_LARGE = CGFloat(1024.0)
        public static let IPAD_MAXIMUM_WIDTH_LARGE = CGFloat(1366.0)
    }
    
    public struct DeviceType {
        public static let IS_PHONE_DEVICE = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
        public static let IS_IPHONE_4 = ScreenSize.SCREEN_MAX_LENGTH < 568.0
        public static let IS_IPHONE_5 = ScreenSize.SCREEN_MAX_LENGTH < 667.0
        public static let IS_IPHONE_6 = ScreenSize.SCREEN_MAX_LENGTH < 736.0
        public static let IS_IPHONE_6P = ScreenSize.SCREEN_MAX_LENGTH < 768.0
        public static let IS_IPAD_DEVICE = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
        public static let IS_IPAD = ScreenSize.SCREEN_MAX_LENGTH < 1366.0
        public static let IS_IPAD_PRO = ScreenSize.SCREEN_MAX_LENGTH >= 1366.0
    }
    
    public static func isPortrait(bounds: CGRect) -> Bool {
        return bounds.width < bounds.height
        //        return UIDevice.currentDevice().orientation.isPortrait
        //        return UIDevice.currentDevice().orientation == UIDeviceOrientation.Portrait || UIDevice.currentDevice().orientation == UIDeviceOrientation.PortraitUpsideDown
    }
    
    public static func showAlert(vc: UIViewController, title: String?, message: String?, buttonTitle: String?, action: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.Default, handler: action)
        alert.addAction(defaultAction)
        vc.presentViewController(alert, animated: true, completion: nil)
    }    
}

infix operator ~> {}

/** Serial dispatch queue used by the ~> operator. */
private let queue = dispatch_queue_create("serial-worker", DISPATCH_QUEUE_SERIAL)

/** 
Executes the left-hand closure on a background thread and, upon completion,
the right-hand closure on the main thread.
*/
public func ~> <R> (backgroundClosure: () -> R, mainClosure: (result: R) -> ()) {
    dispatch_async(queue) { () -> Void in
        let result = backgroundClosure()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            mainClosure(result: result)
        })
    }
}
