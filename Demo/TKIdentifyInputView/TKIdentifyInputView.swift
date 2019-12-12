//
//  TKIdentifyInputView.swift
//  TKIdentifyInputView
//
//  Created by TungKay on 2019/3/2.
//  Copyright © 2019 TungKay. All rights reserved.
//

import UIKit

fileprivate class DisablePastTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

public typealias TKInputViewTextDidChangeBlock = (String, Bool) -> Void
public typealias TKInputViewOnReturnKeyBlock = (String, Bool) -> Void
open class TKIdentifyInputView: UIView {
    
    open var keyboardType: UIKeyboardType = UIKeyboardType.numberPad {
        didSet {
            self.textField.keyboardType = keyboardType
        }
    } // set the keyboardType
    
    //  自动填充验证码，oneTimeCode是12之后才支持
    open var supportAutoFill: Bool = true {
        didSet {
            guard #available(iOS 12.0, *) else {
                return
            }
            if supportAutoFill {
                self.textField.textContentType = UITextContentType.oneTimeCode
            }
            else {
                self.textField.textContentType = nil
            }
        }
    }
    
    open var textDidChangeBlock: TKInputViewTextDidChangeBlock? // content change callback
    open var itemConfig: TKIdentifyInputItemConfig? // the config, aftet set it should call reload()
    open var textValue: String {
        return self.text
    } // current input content
    open var itemCount: Int = 4 // number of item, aftet set it should call reload()
    open var endEditOnReturn: Bool = true
    open var onReturnKeyBlock: TKInputViewOnReturnKeyBlock? // keyboard return key callback
    
    private lazy var textField: DisablePastTextField = {
        let textField = DisablePastTextField()
        textField.textColor = .clear
        textField.backgroundColor = .clear
        textField.tintColor = .clear
        textField.delegate = self
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = UIKeyboardType.numberPad
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private var oldLength: Int = 0
    private var text: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
        self.reload()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
        self.reload()
    }
    
    private func setup() {
        self.contentView.frame = self.bounds
        self.addSubview(self.contentView)
        
        self.textField.frame = self.bounds
        self.addSubview(self.textField)
    }
    
    private func beginEdit() {
        if self.textField.canBecomeFirstResponder {
            self.textField.becomeFirstResponder()
        }
    }
    
    private func endEdit() {
        if self.textField.canResignFirstResponder {
            self.textField.resignFirstResponder()
        }
    }

    private func triggerBlock() {
        guard let block = self.textDidChangeBlock else {
            return
        }
        block(self.text, self.text.count == self.itemCount)
    }
    
    private func item(withIndex idx: Int) -> TKIdentifyInputItem? {
        if idx >= self.contentView.subviews.count ||
            idx < 0 {
            return nil
        }
        let item = self.contentView.subviews[idx] as! TKIdentifyInputItem
        return item
    }
    
    private func selectItem(withItem idx: TKIdentifyInputItem) {
        for i in 0 ..< self.contentView.subviews.count {
            let item = self.contentView.subviews[i] as! TKIdentifyInputItem
            if item == idx {
                item.selected = true
            }
            else {
                item.selected = false
            }
        }
    }
    
    // after change itemConfig, itemCount, frame or layout should call this func
    open func reload() {
        guard let itemConfig = self.itemConfig else {
            return
        }
        layoutIfNeeded()
        self.contentView.frame = self.bounds
        self.textField.frame = self.bounds
        let w = itemConfig.itemSize.width
        let h = itemConfig.itemSize.height
        let gap = (frame.width - CGFloat(itemCount) * w) / CGFloat(itemCount - 1)
        contentView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        for i in 0 ..< self.itemCount {
            let item = TKIdentifyInputItem(frame: CGRect(x:CGFloat(i) * (w + gap) , y: (self.bounds.height - h) / 2, width: w, height: h))
            item.config = itemConfig
            item.selected = i == 0 ? true : false
            item.refresh()
            contentView.addSubview(item)
        }
    }
    
    // clear all input, and toggle keyboard
    open func clearAll() {
        self.oldLength = 0
        self.text = ""
        self.textField.text = ""
        for view in self.contentView.subviews {
            let item = view as! TKIdentifyInputItem
            item.clear()
        }
        if let item = self.item(withIndex: 0) {
            self.selectItem(withItem: item)
        }
        self.triggerBlock()
        self.beginEdit()
    }
}

extension TKIdentifyInputView: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.endEditOnReturn {
            self.endEdit()
        }
        guard let block = self.onReturnKeyBlock else {
            return true
        }
        block(self.text, self.text.count == self.itemCount)
        return true;
    }
}

extension TKIdentifyInputView {
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        guard let textFieldText = textField.text else {
            return
        }
        let str = textFieldText.filter { character in
            character != " "
        }

        self.text = str
        if self.text.count > self.itemCount {
            self.text = cut(string: self.text, onLength: self.itemCount)
        }
        
        if self.oldLength > self.text.count {
        
            guard let item = self.item(withIndex: self.oldLength - 1) else {
                return
            }
            item.clear()
            self.selectItem(withItem: item)
        }
        else if self.text.count <= itemCount {
            
            for i in 0 ..< self.text.count {
                guard let item = self.item(withIndex: i) else {
                    return
                }
                if !item.isEmpty {
                    continue
                }
                let idx = self.text.index(self.text.startIndex, offsetBy: i)
                item.setText(text: String(self.text[idx]))
                item.selected = false
            }
           
            if self.text.count == itemCount {
                self.endEdit()
            }
            else if let nextItem = self.item(withIndex: self.text.count) {
                nextItem.selected = true
                self.selectItem(withItem: nextItem)
            }
        }
        textField.text = self.text
        self.oldLength = self.text.count
        self.triggerBlock()
    }
    
    private func cut(string str: String, onLength length: Int) -> String {
        let idx = str.index(str.startIndex, offsetBy: length)
        return String(str[str.startIndex..<idx])
    }
}

