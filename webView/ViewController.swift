//
//  ViewController.swift
//  webView
//
//  Created by soron2 on 30/6/21.
//

import UIKit
import WebKit
import SVGKit



class ViewController: UIViewController, WKUIDelegate {
    @IBOutlet weak var _webView: WKWebView!
    
   
    @IBOutlet weak var _navTab: UITabBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.lafinestrasulcielo.es?customapp=1")
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
    
    
    
    func setNavTabs(items: [API.NavTabsData]){
        /*let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))*/
        
        var tabBarList = [UITabBarItem]()
        
        for item in items{
            let newItem = UITabBarItem()
            newItem.title = item.label
            
            
            let svg = URL(string: item.icon)!
            let data = try? Data(contentsOf: svg)
            let receivedimage: SVGKImage = SVGKImage(data: data)

            newItem.image = receivedimage.uiImage
            
            tabBarList.append(newItem)
            
        }
        
        
        
        
        
        DispatchQueue.main.async {
            self._navTab.items = tabBarList
        }
    }
        
       
    
    
}



