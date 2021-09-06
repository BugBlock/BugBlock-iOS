//
//  UIDevice+Device.swift
//  BugBlock
//
//  Created by Vadym Kozak on 06.09.2021.
//

import UIKit
import SystemConfiguration
import CoreTelephony
import Foundation

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    
    class func getConnectionType() -> String? {
            guard let reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, "www.google.com") else {
                return "NO INTERNET"
            }

            var flags = SCNetworkReachabilityFlags()
            SCNetworkReachabilityGetFlags(reachability, &flags)

            let isReachable = flags.contains(.reachable)
            let isWWAN = flags.contains(.isWWAN)

            if isReachable {
                if isWWAN {
                    let networkInfo = CTTelephonyNetworkInfo()
                    guard #available(iOS 12.0, *) else {
                        return nil
                    }
                    let carrierType = networkInfo.serviceCurrentRadioAccessTechnology
                    guard let carrierTypeName = carrierType?.first?.value else {
                        return "UNKNOWN"
                    }

                    switch carrierTypeName {
                    case CTRadioAccessTechnologyGPRS, CTRadioAccessTechnologyEdge, CTRadioAccessTechnologyCDMA1x:
                        return "2G"
                    case CTRadioAccessTechnologyLTE:
                        return "LTE"
                    default:
                        return "3G"
                    }
                } else {
                    return "WiFi"
                }
            } else {
                return "NO INTERNET"
            }
        }
}
