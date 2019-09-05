//
//  LFScreenAdaptor.swift
//  SwiftData
//
//  Created by LeonDeng on 2019/9/2.
//  Copyright © 2019 tcl. All rights reserved.
//

import UIKit

enum ScreenType {
    case Unknown /// DeviceScreenTypeUnknown: Unknown screenType, maybe a new iPhone or simulator
    case Type3_5 /// DeviceScreenType3_5: 1, 3G, 3Gs, 4, 4s
    case Type4_0 /// DeviceScreenType4_0: 5, 5s, 5c, se, iPod Touch 5, iPod Touch 6
    case Type4_7 /// DeviceScreenType4_7: 6, 6s, 7, 8
    case Type5_5 /// DeviceScreenType5_5: 6Plus, 6sPlus, 7Plus, 8Plus
    case Type5_8 /// DeviceScreenType5_8: X, Xs
    case Type6_1 /// DeviceScreenType6_1: XR
    case Type6_5 /// DeviceScreenType6_5: Xs Max
    case Type9_7 /// DeviceScreenType9_7: iPad Pro, iPad Air, iPad Air 2, iPad 4, iPad 3
    case Type10_5 ///  DeviceScreenType10_5: iPad Pro
    case Type11 /// DeviceScreenType11: iPad Pro
    case Type12_9 /// DeviceScreenType12_9: iPad Pro
}

extension ScreenType {
    var statusBarHeight: CGFloat {
        switch self {
        case .Type5_8, .Type6_1, .Type6_5:
            return 44
        default:
            return 20
        }
    }
    
    var navigationBarHeight: CGFloat {
        switch self {
        case .Type5_8, .Type6_1, .Type6_5:
            return 88
        default:
            return 64
        }
    }
    
    var buttonIndicatorHeight: CGFloat {
        switch self {
        case .Type5_8, .Type6_1, .Type6_5:
            return 34
        default:
            return 0
        }
    }
    
    var screenWidth: CGFloat {
        switch self {
        case .Type3_5:
            return 320
        case .Type4_0:
            return 320
        case .Type4_7:
            return 375
        case .Type5_5:
            return 414
        case .Type5_8:
            return 375
        case .Type6_5, .Type6_1:
            return 414
            
        default:
            return 0
        }
    }
    
    var screenHeight: CGFloat {
        switch self {
        case .Type3_5:
            return 480
        case .Type4_0:
            return 568
        case .Type4_7:
            return 667
        case .Type5_5:
            return 736
        case .Type5_8:
            return 812
        case .Type6_5, .Type6_1:
            return 896
            
        default:
            return 0
        }
    }
}

enum DeviceType: Int {
    case Unknown = 0 /// Unknown: unknown type, maybe new iphone or simulator
    case Simulator = 1 /// Simulator: simulator, not supported for most functions of this frameWork
    case IPhone_1G = 2 /// IPhone_1G: Not supported
    case IPhone_3G = 3 /// IPhone_3G: Not supported
    case IPhone_3GS = 4 /// IPhone_3GS: Not supported
    case IPhone_4 = 5 /// IPhone_4:  supported
    case IPhone_4S = 6 /// IPhone_4S: supported
    case IPhone_5 = 7 /// IPhone_5: supported
    case IPhone_5C = 8 /// IPhone_5C: supported
    case IPhone_5S = 9 /// IPhone_5S: supported
    case IPhone_SE = 10 /// IPhone_SE: supported
    case IPhone_6 = 11 /// IPhone_6: supported
    case IPhone_6P = 12 /// IPhone_6P: supported
    case IPhone_6S = 13 /// IPhone_6S: supported
    case IPhone_6S_P = 14 /// IPhone_6S_P: supported
    case IPhone_7 = 15 /// IPhone_7: supported
    case IPhone_7P = 16 /// IPhone_7P: supported
    case IPhone_8 = 17 /// IPhone_8: supported
    case IPhone_8P = 18 /// IPhone_8P: supported
    case IPhone_X = 19 /// IPhone_X: supported
    case IPhone_XS = 20 /// IPhone_XS: supported
    case IPhone_XSMax = 21 /// IPhone_XSMax: supported
    case IPhone_XR = 22 /// IPhone_XR: supported
}

extension DeviceType {
    var screenType: ScreenType {
        switch self {
        case .Unknown:
            return .Unknown
            
        case .IPhone_1G, .IPhone_3G, .IPhone_3GS:
            return .Type3_5
            
        case .IPhone_4, .IPhone_4S:
            return .Type3_5
            
        case .IPhone_5, .IPhone_5C, .IPhone_5S, .IPhone_SE:
            return .Type4_0
            
        case .IPhone_6, .IPhone_6S, .IPhone_7, .IPhone_8:
            return .Type4_7
            
        case .IPhone_6P, .IPhone_7P, .IPhone_8P:
            return .Type5_5
            
        case .IPhone_X, .IPhone_XS:
            return .Type5_8
            
        case .IPhone_XR:
            return .Type6_1
            
        case .IPhone_XSMax:
            return .Type6_5
            
        default:
            return .Unknown
        }
    }
    
    var name: String {
        switch self {
        case .Unknown:
            return "Unknown"
        case .IPhone_1G:
            return "iPhone_1G"
            
        case .IPhone_3G:
            return "iPhone_3G"
            
        case .IPhone_3GS:
            return "iPhone_3GS"
            
        case .IPhone_4:
            return "iPhone_4"
            
        case .IPhone_4S:
            return "iPhone_4S"
            
        case .IPhone_5:
            return "iPhone_5"
            
        case .IPhone_5C:
            return "iPhone_5C"
            
        case .IPhone_5S:
            return "iPhone_5S"
            
        case .IPhone_6:
            return "iPhone_6"
            
        case .IPhone_6P:
            return "iPhone_6Plus"
            
        case .IPhone_6S:
            return "iPhone_6S"
            
        case .IPhone_6S_P:
            return "iPhone_6SPlus"
            
        case .IPhone_7:
            return "iPHone_7"
            
        case .IPhone_7P:
            return "iPhone_7Plus"
            
        case .IPhone_8:
            return "iPhone_8"
            
        case .IPhone_8P:
            return "iPhone_8Plus"
            
        case .IPhone_X:
            return "iPhone_X"
            
        case .IPhone_XS:
            return "iPhone_XS"
            
        case .IPhone_XSMax:
            return "iPhone_XSMax"
            
        case .IPhone_XR:
            return "iPhone_XR"
            
        default:
            return "Unknown"
        }
    }
}

class LFScreenAdaptor {
    
    static let sharedAdaptor: LFScreenAdaptor = LFScreenAdaptor(designScreenType: DeviceType.IPhone_6.screenType)
    
    var designScreen: ScreenType
    
    let currentDevice: DeviceType = {
        var systemInfo: utsname = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
//        let identifier = machineMirror.children.reduce("") { identifier, elementin
//
//            guardletvalue = element.valueas?Int8wherevalue !=0else{returnidentifier }
//
//            returnidentifier +String(UnicodeScalar(UInt8(value)))
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
//            if ([platform isEqualToString:@"iPhone1,1"])     return IPhone_1G;
//            if ([platform isEqualToString:@"iPhone1,2"])     return IPhone_3G;
//            if ([platform isEqualToString:@"iPhone2,1"])     return IPhone_3GS;
        case "iPhone1,1":                               return .IPhone_1G
        case "iPhone1,2":                               return .IPhone_3G
        case "iPhone2,1":                               return .IPhone_3GS
        case "iPhone3,1":                               return .IPhone_4
        case "iPhone4,1":                               return .IPhone_4S
        case "iPhone5,1", "iPhone5,2":                  return .IPhone_5
        case "iPhone5,3", "iPhone5,4":                  return .IPhone_5C
        case "iPhone6,1", "iPhone6,2":                  return .IPhone_5S
        case "iPhone7,2":                               return .IPhone_6
        case "iPhone7,1":                               return .IPhone_6P
        case "iPhone8,1":                               return .IPhone_6S
        case "iPhone8,2":                               return .IPhone_6S_P
        case "iPhone8,4":                               return .IPhone_SE
        case "iPhone9,1":                               return .IPhone_7
        case "iPhone9,2":                               return .IPhone_7P
        // case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        // case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        // case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        // case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        // case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        // case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        // case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        // case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        // case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        // case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        // case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return .Simulator
        default:                                        return .Unknown
        }
        
    }()
    
    var currentScreen: ScreenType {
        return self.currentDevice.screenType
    }
    
    public func adaptedHeight(height: CGFloat) -> CGFloat {
        let deviceHeight = self.currentScreen.screenHeight
        let standardHeight = self.designScreen.screenHeight
        return standardHeight * (deviceHeight / standardHeight)
    }
    
    public func adaptedWidth(width: CGFloat) -> CGFloat {
        let deviceWidth = self.currentScreen.screenWidth
        let standardWidth = self.designScreen.screenWidth
        return standardWidth * (deviceWidth / standardWidth)
    }
    
    init(designScreenType: ScreenType) {
        designScreen = designScreenType
    }
    
    
}
