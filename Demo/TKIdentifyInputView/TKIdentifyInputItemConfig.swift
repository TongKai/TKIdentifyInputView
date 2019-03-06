//
//  TKIdentifyInputItemConfig.swift
//  TKIdentifyingInputView
//
//  Created by TungKay on 2019/3/2.
//  Copyright © 2019 TungKay. All rights reserved.
//

import UIKit

public typealias TKInputItemCustomSecurityView = () -> UIView

public struct TKIdentifyInputItemConfig {
    public var normalBgColor: UIColor? = nil
    public var selectedBgColor: UIColor? = nil
    public var normalBorderColor: UIColor? = nil
    public var selectedBorderColor: UIColor? = nil
    public var borderWidth: CGFloat = 0
    public var cornerRadius: CGFloat = 0
    
    public var font: UIFont? = nil
    public var textColor: UIColor? = nil
    
    public var needCursor: Bool = false // show cursor
    public var cusorColor: UIColor? = nil
    public var cusorVerticalMargin: CGFloat = 5
    public var cusorWidth: CGFloat = 2
    
    public var itemSize: CGSize = CGSize(width: 50, height: 50)
    
    public var underlineSize: CGSize = CGSize.zero // if zero, means hide underline
    public var normalUnderlineColor: UIColor? = nil
    public var selectedUnderlineColor: UIColor? = nil
    
    public var securitySymbol: String? = nil
    public var securityView: TKInputItemCustomSecurityView? = nil
    public var isSecurity: Bool = false
    public var showSecurityDelay: TimeInterval = 0.25 // the time from content to security symbol or security view
    
    
}
