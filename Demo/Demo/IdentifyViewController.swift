//
//  IdentifyViewController.swift
//  Demo
//
//  Created by TungKay on 2019/3/6.
//  Copyright © 2019 TungKay. All rights reserved.
//

import UIKit
import SnapKit

class IdentifyViewController: UIViewController {
    
    var identifyInput: TKIdentifyInputView?
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("Clear", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        btn.addTarget(self, action: #selector(btnClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.width.equalTo(130)
            make.height.equalTo(60)
            make.center.equalToSuperview()
        }
        guard let input = identifyInput else {
            return
        }
        self.view.addSubview(input)
        input.snp.makeConstraints { [weak self] (make) in
            guard let sSelf = self else {
                return
            }
            make.height.equalTo(80)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(sSelf.btn.snp.top).offset(-50)
        }
        input.reload()
        input.textDidChangeBlock = {text, finished in
            print("text = \(text), finished = \(finished), text = \(input.textValue)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    @objc func btnClicked(sender: UIButton) {
        guard let input = identifyInput else {
            return
        }
        input.clearAll()
    }
}
