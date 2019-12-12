//
//  ViewController.swift
//  Demo
//
//  Created by TungKay on 2019/3/6.
//  Copyright © 2019 TungKay. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let Identifier: String = "Cell"
class ViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: Identifier)
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    }()
    var controllers: [IdentifyViewController] = [IdentifyViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        self.controllers.append(self.underlineInput())
        self.controllers.append(self.borderInput())
        self.controllers.append(self.backgroundInput())
        self.controllers.append(self.cursorInput())
        self.controllers.append(self.securityInput())
        self.controllers.append(self.customSecurityInput())
        self.controllers.append(self.customItemInput())
        tableView.reloadData()
    }
    
    func underlineInput() -> IdentifyViewController {
        let vc = IdentifyViewController()
        let input = TKIdentifyInputView.init(frame: .zero)
        input.itemCount = 6
        input.keyboardType = .default
        input.itemConfig = TKIdentifyInputItemConfig()
        let w = input.itemConfig!.itemSize.width
        input.itemConfig?.underlineSize = CGSize(width: w, height: 2)
        input.itemConfig?.selectedUnderlineColor = .black
        input.itemConfig?.normalUnderlineColor = .black
        vc.identifyInput = input
        vc.title = "下划线/underline"
        return vc
    }
    
    func borderInput() -> IdentifyViewController {
        let vc = IdentifyViewController()
        let input = TKIdentifyInputView.init(frame: .zero)
        input.itemConfig = TKIdentifyInputItemConfig()
        input.itemConfig?.borderWidth = 2.0
        input.itemConfig?.selectedBorderColor = .black
        input.itemConfig?.normalBorderColor = .black
        vc.identifyInput = input
        vc.title = "边框/border"
        return vc
    }
    
    func backgroundInput() -> IdentifyViewController {
        let vc = IdentifyViewController()
        let input = TKIdentifyInputView.init(frame: .zero)
        input.itemConfig = TKIdentifyInputItemConfig()
        input.itemConfig?.cornerRadius = 5.0
        input.itemConfig?.selectedBgColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        input.itemConfig?.normalBgColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        vc.identifyInput = input
        vc.title = "背景圆角/background&corner"
        return vc
    }
    
    func cursorInput() -> IdentifyViewController {
        let vc = IdentifyViewController()
        let input = TKIdentifyInputView.init(frame: .zero)
        input.itemConfig = TKIdentifyInputItemConfig()
        let w = input.itemConfig!.itemSize.width
        input.itemConfig?.underlineSize = CGSize(width: w, height: 2)
        input.itemConfig?.selectedUnderlineColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        input.itemConfig?.normalUnderlineColor = .black
        input.itemConfig?.needCursor = true
        input.itemConfig?.cusorWidth = 1
        input.itemConfig?.cusorVerticalMargin = 10
        input.itemConfig?.cusorColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        vc.identifyInput = input
        vc.title = "光标/cursor"
        return vc
    }
    
    func securityInput() -> IdentifyViewController {
        let vc = IdentifyViewController()
        let input = TKIdentifyInputView.init(frame: .zero)
        input.itemConfig = TKIdentifyInputItemConfig()
        input.itemConfig?.borderWidth = 2.0
        input.itemConfig?.selectedBorderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        input.itemConfig?.normalBorderColor = .black
        input.itemConfig?.needCursor = true
        input.itemConfig?.isSecurity = true
        input.itemConfig?.securitySymbol = "*"
        vc.identifyInput = input
        vc.title = "密文/security"
        return vc
    }
    
    func customSecurityInput() -> IdentifyViewController {
        let vc = IdentifyViewController()
        let input = TKIdentifyInputView.init(frame: .zero)
        input.itemConfig = TKIdentifyInputItemConfig()
        input.itemConfig?.borderWidth = 2.0
        input.itemConfig?.selectedBorderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        input.itemConfig?.normalBorderColor = .black
        input.itemConfig?.needCursor = true
        input.itemConfig?.isSecurity = true
        input.itemConfig?.showSecurityDelay = 0.0
        input.itemConfig?.securityView = {
            let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            img.image = UIImage.init(named: "shoucang")
            return img
        }
        vc.identifyInput = input
        vc.title = "自定义密文/custom security"
        return vc
    }
    
    func customItemInput() -> IdentifyViewController {
        let vc = IdentifyViewController()
        let input = TKIdentifyInputView.init(frame: .zero)
        input.itemConfig = TKIdentifyInputItemConfig()
        input.itemConfig?.cornerRadius = 5.0
        input.itemConfig?.selectedBgColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        input.itemConfig?.normalBgColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        input.itemConfig?.itemSize = CGSize(width: 65, height: 65)
        input.itemConfig?.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        input.itemConfig?.font = UIFont.boldSystemFont(ofSize: 40)
        vc.identifyInput = input
        vc.title = "自定义大小，字体，字体大小/item size&font&text color"
        return vc
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath)
        let vc = self.controllers[indexPath.row]
        cell.textLabel?.text = vc.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = self.controllers[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
