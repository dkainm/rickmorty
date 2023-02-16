//
//  UIColor + Ext.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import UIKit

extension UIColor {
    
    ///#000000
    static var shadow: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 1.00)
    }
    
    static var white: UIColor {
        return UIColor.init { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                ///#000000
                return UIColor(red: 0, green: 0, blue: 0, alpha: 1.00)
            } else {
                ///#FFFFFF
                return UIColor(red: 1, green: 1, blue: 1, alpha: 1.00)
            }
        }
    }
    
    static var black: UIColor {
        return UIColor.init { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                ///#FFFFFF
                return UIColor(red: 1, green: 1, blue: 1, alpha: 1.00)
            } else {
                ///#000000
                return UIColor(red: 0, green: 0, blue: 0, alpha: 1.00)
            }
        }
    }
    
    static var main: UIColor {
        return UIColor.init { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                ///#9595FE
                return UIColor(red: 0.58, green: 0.58, blue: 1, alpha: 1.00)
            } else {
                ///#0000FF
                return UIColor(red: 0, green: 0, blue: 1, alpha: 1.00)
            }
        }
    }
    
    static var background: UIColor {
        return UIColor.init { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                ///#181819
                return UIColor(red: 0.09, green: 0.09, blue: 0.1, alpha: 1.00)
            } else {
                ///#F4F4F9
                return UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.00)
            }
        }
    }
    
    static var card: UIColor {
        return UIColor.init { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                ///#2E2E2F
                return UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
            } else {
                ///#FFFFFF
                return UIColor(red: 1, green: 1, blue: 1, alpha: 1.00)
            }
        }
    }
    
    static var dark: UIColor {
        return UIColor.init { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                ///#FFFFFF
                return UIColor(red: 1, green: 1, blue: 1, alpha: 1.00)
            } else {
                ///#474748
                return UIColor(red: 0.28, green: 0.28, blue: 0.28, alpha: 1.00)
            }
        }
    }
    
    static var placeholder: UIColor {
        return UIColor.init { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                ///#8B8B8C
                return UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1.00)
            } else {
                ///#666666
                return UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.00)
            }
        }
    }
    
    static var gray: UIColor {
        return UIColor.init { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                ///#474747
                return UIColor(red: 0.28, green: 0.28, blue: 0.28, alpha: 1.00)
            } else {
                ///#E7E7EC
                return UIColor(red: 0.91, green: 0.91, blue: 0.93, alpha: 1.00)
            }
        }
    }
    
    static var icon: UIColor {
        return UIColor.init { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                ///#8B8B8C
                return UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1.00)
            } else {
                ///#D9D9D9
                return UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
            }
        }
    }
    
    static var unselected: UIColor {
        return UIColor.init { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                ///#6E6E71
                return UIColor(red: 0.43, green: 0.43, blue: 0.44, alpha: 1.00)
            } else {
                ///#B3B3B3
                return UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.00)
            }
        }
    }
    
    static var divider: UIColor {
        return UIColor.init { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                ///#474749
                return UIColor(red: 0.28, green: 0.28, blue: 0.29, alpha: 1.00)
            } else {
                ///#F0F0F0
                return UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00)
            }
        }
    }
}
