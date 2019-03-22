//
//  ViewController.swift
//  PracaDomowa02
//
//  Created by Aleksandra Konopka on 22/03/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    let buildings = [BuildingView]()
    
    func loadBuildings(){
        var moveBy = 0.0
        for _ in 0...5{
            let building = BuildingView.randomBuilding()
            building.center = CGPoint(x: CGFloat(moveBy) + (building.frame.width/2), y: self.view.bounds.height - (building.frame.height/2))
            moveBy = moveBy + Double(building.frame.width)
            scrollView.addSubview(building)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: self.view.bounds.width * 10.0, height: self.view.bounds.height)
        scrollView.bounds = .zero
        scrollView.isPagingEnabled = true
        loadBuildings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
    
}

