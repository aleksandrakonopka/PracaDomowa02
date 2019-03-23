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
    var visibleBuildings = [BuildingView]()
    var buildingsOnTheLeft = [BuildingView]()
    var myMoon = UIView()
    var moonX : CGFloat = 0.0
    var moonY : CGFloat = 0.0
    
    func loadBuildings(){
        var moveBy = 0.0
        var allBuildingsWidth = 0.0
        // dodaje tyle budynków ile będzie widoczne na ekranie device
        while allBuildingsWidth - 250 < Double(UIScreen.main.bounds.width)
        {
            let building = BuildingView.randomBuilding()
            building.center = CGPoint(x: CGFloat(moveBy) + (self.view.bounds.width * 1.5) + (building.frame.width/2) - 100, y: self.view.bounds.height - (building.frame.height/2))

            moveBy = moveBy + Double(building.frame.width)
            scrollView.addSubview(building)
            visibleBuildings.append(building)
            allBuildingsWidth = allBuildingsWidth + Double(building.frame.width)
        }
    }
    func addNewBuilding(side: String)
    {
        print("Dodaje element")
        let building = BuildingView.randomBuilding()
        if side == "Right"
        {
        building.center = CGPoint(x: visibleBuildings.last!.frame.maxX + (building.frame.width/2), y: self.view.bounds.height - (building.frame.height/2))
            visibleBuildings.append(building)
        }
        else
        {
            building.center = CGPoint(x:  visibleBuildings[0].frame.minX - (building.frame.width/2), y: self.view.bounds.height - (building.frame.height/2))
            visibleBuildings.insert(building, at: 0)
        }
        scrollView.addSubview(building)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: self.view.bounds.width * 3.0, height: 1.1 * self.view.bounds.height)
        scrollView.bounds = .zero
        scrollView.isPagingEnabled = true
        scrollView.contentOffset.x = 1.5 * self.view.bounds.width
        scrollView.backgroundColor = UIColor.darkGray
        loadBuildings()
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGestureFunc))
        let moon = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        moon.center.x = (self.view.bounds.width * 1.5) + 100
        moon.center.y = 100
        moon.backgroundColor = UIColor.red
        moon.layer.cornerRadius = 100 * 0.5
        moon.alpha = 1.0
        myMoon = moon
        scrollView.addSubview(moon)
        moon.addGestureRecognizer(longGesture)
    }
    
    @objc func longGestureFunc(_ tap: UILongPressGestureRecognizer) {
        if let kulka = tap.view
        {
            if tap.state == .began
            {
                animation(myBall: kulka, scale: 1.2, alpha: 0.6 ,duration: 0.3)
            }
            
            if tap.state == .changed
            {
                kulka.center.x =  tap.location(in: scrollView).x - tap.location(in: kulka).x + (1/2)*kulka.bounds.height
                kulka.center.y =  tap.location(in: scrollView).y - tap.location(in: kulka).y + (1/2)*kulka.bounds.height
                view.bringSubviewToFront(kulka)
                moonX = tap.location(in: view).x
                moonY = tap.location(in: view).y
            }
            if tap.state == .ended
            {
                animation(myBall: kulka, scale: 1 , alpha: 1.0, duration: 0.3)
            }
        }
    }
    private func animation(myBall : UIView, scale: CGFloat, alpha: CGFloat, duration: TimeInterval)
    {
        UIView.animate(withDuration: duration, animations: {
            myBall.alpha = alpha
            myBall.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        if visibleBuildings.count > 0{

            var firstBuildingWidth = visibleBuildings[0].frame.width
            if scrollView.contentOffset.x >= self.view.bounds.width * 1.5 + firstBuildingWidth
            {
             addNewBuilding(side: "Right")
             visibleBuildings[0].removeFromSuperview()
             visibleBuildings.remove(at:0)
             for building in visibleBuildings
             {
                building.center.x = building.center.x - firstBuildingWidth
            }
            scrollView.contentOffset.x = self.view.bounds.width * 1.5
            }
            
            var lastBuildingWidth = visibleBuildings.last!.frame.width
            if scrollView.contentOffset.x <= self.view.bounds.width * 1.5 - lastBuildingWidth
            {
                addNewBuilding(side: "Left")
                visibleBuildings.last!.removeFromSuperview()
                visibleBuildings.removeLast()
                for building in visibleBuildings
                {
                    building.center.x = building.center.x + lastBuildingWidth
                }
                scrollView.contentOffset.x = self.view.bounds.width * 1.5
            }
        }
        print(visibleBuildings.count)
        if moonX != 0.0 && moonY != 0.0
        {
         myMoon.center.x = scrollView.contentOffset.x + moonX
         myMoon.center.y = scrollView.contentOffset.y + moonY
        }
        else
        {
            myMoon.center.x = scrollView.contentOffset.x + 100
            myMoon.center.y = scrollView.contentOffset.y + 100
        }
        

            
        }
    }
    


