//
//  TKIdentifyInputItem.swift
//  TKIdentifyingInputView
//
//  Created by TungKay on 2019/3/2.
//  Copyright © 2019 TungKay. All rights reserved.
//

import UIKit

final class TKIdentifyInputItem: UIView {
    public var config: TKIdentifyInputItemConfig?
    public var selected: Bool = false {
        didSet {
            self.refreshCursor()
            self.refreshSetlectedState()
        }
    }
    
    private var securityView: UIView? = nil
    private lazy var cursorAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 0.65
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        return animation
    }()
    private var textValue: String =  ""
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cursor: CAShapeLayer = {
        let layer = CAShapeLayer.init()
        layer.fillColor = UIColor.black.cgColor
        layer.strokeColor = UIColor.black.cgColor
        return layer
    }()
    
    private lazy var underlineView: UIView = {
        return UIView()
    }()
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setup()
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public func clear() {
        self.textValue = ""
        self.label.text = ""
        self.refreshLabel()
    }
    
    public func setText(text: String) {
        self.label.isHidden = false
        self.textValue = text
        self.label.text = text
        self.delayRefreshLabel()
    }
    
    public func refresh() {
        guard let config = self.config else {
            return
        }
        self.layer.borderWidth = config.borderWidth
        self.layer.cornerRadius = config.cornerRadius
        
        self.refreshLabel()
        self.refreshCursor()
        self.refreshSetlectedState()
        self.refreshUnderlineView()
    }
    
    private func setup() {
        self.label.frame = self.bounds
        self.addSubview(self.label)
        
        self.cursor.frame = CGRect(x: (bounds.width - CGFloat(2)) / 2, y: 5, width: 2, height: bounds.height - 10)
        self.cursor.path = UIBezierPath.init(rect: self.cursor.bounds).cgPath
        self.label.layer.addSublayer(self.cursor)
        
        self.addSubview(self.underlineView)
    }
    
    private func refreshCursor() {
        guard let config = self.config else {
            return
        }
        self.cursor.fillColor = config.cusorColor?.cgColor ?? UIColor.black.cgColor
        self.cursor.strokeColor = config.cusorColor?.cgColor ?? UIColor.black.cgColor
        let w = config.cusorWidth
        let h = self.bounds.height - config.cusorVerticalMargin * 2
        self.cursor.frame = CGRect(x: (bounds.width - w) / 2, y: (bounds.height - h) / 2, width: w, height: h)
        self.cursor.path = UIBezierPath.init(rect: self.cursor.bounds).cgPath
        
        let CursorAnimKey = "CursorAnimKey"
        if config.needCursor && selected {
            self.cursor.isHidden = false
            self.cursor.add(self.cursorAnimation, forKey: CursorAnimKey)
        }
        else {
            self.cursor.isHidden = true
            self.cursor.removeAnimation(forKey: CursorAnimKey)
        }
    }
    
    private func refreshLabel() {
        
        guard let config = self.config else {
            return
        }
        self.label.font = config.font ?? UIFont.systemFont(ofSize: 28.0)
        self.label.textColor = config.textColor ?? UIColor.black
        
        if config.isSecurity {
            if config.securityView == nil {
                self.label.text = self.textValue == "" ? "" : self.config?.securitySymbol
                self.label.isHidden = false
                self.securityView?.removeFromSuperview()
            }
            else {
                if self.securityView == nil {
                    self.securityView = config.securityView!()
                    self.securityView?.center = self.label.center
                    self.addSubview(self.securityView!)
                }
                self.securityView?.isHidden = self.textValue == "" ? true : false
                self.label.isHidden = !self.securityView!.isHidden
            }
        }
        else {
            self.securityView?.isHidden = true
            self.label.isHidden = false
            self.label.text = self.textValue
        }
    }
    
    private func refreshSetlectedState() {
        guard let config = self.config else {
            return
        }
        
        if selected {
            self.layer.borderColor = config.selectedBorderColor?.cgColor
            self.backgroundColor = config.selectedBgColor
            self.underlineView.backgroundColor = config.selectedUnderlineColor ?? UIColor.black
        }
        else {
            
            self.layer.borderColor = config.normalBgColor?.cgColor
            self.backgroundColor = config.normalBgColor
            self.underlineView.backgroundColor = config.normalUnderlineColor ?? UIColor.black
        }
    }
    
    func refreshUnderlineView() {
        guard let config = self.config else {
            return
        }
        
        let w = config.underlineSize.width
        let h = config.underlineSize.height
        self.underlineView.frame = CGRect(x: (self.bounds.width - w) / 2, y: self.bounds.height - h, width: w, height: h)
    }
    
    private func delayRefreshLabel() {
        guard let config = self.config else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + config.showSecurityDelay) {
            self.refreshLabel()
        }
    }
}
