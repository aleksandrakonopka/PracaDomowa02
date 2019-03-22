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
    
    
    func loadBuildings(){
        var moveBy = 0.0
        var allBuildingsWidth = 0.0
        // dodaje tyle budynków ile będzie widoczne na ekranie device
        while allBuildingsWidth < Double(UIScreen.main.bounds.width)
        {
            let building = BuildingView.randomBuilding()
            building.center = CGPoint(x: CGFloat(moveBy) + (self.view.bounds.width * 1.5) + (building.frame.width/2), y: self.view.bounds.height - (building.frame.height/2))

            moveBy = moveBy + Double(building.frame.width)
            scrollView.addSubview(building)
            visibleBuildings.append(building)
            allBuildingsWidth = allBuildingsWidth + Double(building.frame.width)
        }
    }
    func addNewBuilding(x: CGFloat, side: String)
    {
        print("Dodaje element")
        let building = BuildingView.randomBuilding()
        if side == "Right"
        {
        building.center = CGPoint(x: x + (building.frame.width/2), y: self.view.bounds.height - (building.frame.height/2))
        }
        else
        {
          building.center = CGPoint(x: x - (building.frame.width/2), y: self.view.bounds.height - (building.frame.height/2))
        }
        scrollView.addSubview(building)
        visibleBuildings.append(building)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: self.view.bounds.width * 3.0, height: self.view.bounds.height)
        scrollView.bounds = .zero
        scrollView.isPagingEnabled = true
        scrollView.contentOffset.x = 1.5 * self.view.bounds.width
        loadBuildings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        if visibleBuildings.count > 0{
            var distanceFromCenter = 0.0
            for element in visibleBuildings
            {
//                if element == visibleBuildings.first
//                {
//                    distanceFromCenter = distanceFromCenter + Double((1/2) * element.frame.width)
//                }
//            else{
             distanceFromCenter = distanceFromCenter +  Double(element.frame.width)
//                }
            }
        addNewBuilding(x: CGFloat(distanceFromCenter) + self.view.bounds.width * 1.5  , side: "Right")
//        if scrollView.contentOffset.x < 200
//        {
//        //usuwanie ostatniego budynku ( po prawej stronie )
//        visibleBuildings[visibleBuildings.count-1].removeFromSuperview()
//        visibleBuildings.remove(at: visibleBuildings.count-1)
//            print("Ostatni usuniety")
//        }
//        if scrollView.contentOffset.x > 700
//        {
//            //usuwanie pierwszego budynku ( po lewej stronie )
//        visibleBuildings[0].removeFromSuperview()
//        visibleBuildings.remove(at:0)
//            print("Pierwszy usuniety")
//        }
            
        }
    }
    
}

