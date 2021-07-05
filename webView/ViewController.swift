//
//  ViewController.swift
//  webView
//
//  Created by soron2 on 30/6/21.
//

import UIKit
import WebKit
import SVGKit


class ViewController: UIViewController, WKUIDelegate, UITabBarDelegate {
    var actionNavtab = [String]()
    var drawerOpen = false
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var _drawer: UIView!
    
    
    
    @IBOutlet weak var _webView: WKWebView!
    @IBOutlet weak var _navTab: UITabBar!

    @IBAction func _homeBtnTapped(_ sender: Any) {
        
        if drawerOpen == false {
            print("false")
            //leading.constant = -_drawer.bounds.width
            trailing.constant = 5000
            drawerOpen = true
        } else {
            print("true")
            //leading.constant = 0
            trailing.constant = 250
            drawerOpen = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _navTab.delegate = self
        
        let myURL = URL(string:"https://pre.lafinestrasulcielo.es?customapp=1")
        let myRequest = URLRequest(url: myURL!)
        
        _webView.load(myRequest)
        
        let _api = API()
        
        _api.getNavBar() { result in

            switch result {
                case .success(let data):
                    self.setNavTabs(items: data)
                case .failure(let error):
                    print(error)
            }

        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Test")
    
        guard let indexOfTab = tabBar.items?.firstIndex(of: item) else { return }
        
        goTo(url: actionNavtab[indexOfTab])
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        
        if selectedIndex == 0 {
            print("0")

        }
        else if selectedIndex == 1{
            self.title = "Measure"
        }
        else if selectedIndex == 2 {
            self.title = "Setting"
        } else {
            //do whatever
        }
    }
    
    func setNavTabs(items: [API.NavTabsData]){
        var tabBarList = [UITabBarItem]()
        
        for item in items{
            actionNavtab.append(item.url!)
            
            let newItem = UITabBarItem()
            newItem.title = item.label
        
            /*do {
                let url = URL(string: item.icon!)!
                let data = try Data(contentsOf: url)
                let anSVGImage: SVGKImage = SVGKImage(data: data)
                
            
                newItem.image = anSVGImage.uiImage
            }
            catch{
                print(error)
            }*/
            
            
            /*let svg = URL(string: item.icon ?? "https://openclipart.org/download/181651/manhammock.svg")!
            let data = try? Data(contentsOf: svg)
            
            print(item.icon)
            print(data)
            
            let receivedimage: SVGKImage = SVGKImage(data: data)*/
            
            
            
            
    
            //newItem.at(, forUndefinedKey:     )
            
/*
            let urlImage = URL(string: item.icon!)!
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: urlImage) {
                    if let image = UIImage(systemName: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }*/
            
            //newItem.badgeValue = "2"
            //newItem.image
            //newItem.selectedImage
            tabBarList.append(newItem)
            
        }
        
        
        
        
        
        DispatchQueue.main.async {
            self._navTab.items = tabBarList
        }
    }
        
       
    func goTo(url: String){
        let url = URL(string:url)
        let myRequest = URLRequest(url: url!)
        
        _webView.load(myRequest)
    }
    
}


