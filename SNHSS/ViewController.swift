//
//  ViewController.swift
//  SNHSS
//
//  Created by dlabbe on 9/1/17.
//  Copyright © 2017 Southern NH Snow Slickers. All rights reserved.
//

import UIKit

var urlSA = ["http://snowmobile-nh.com/trail-reports/bear-brook-state-park",
            "http://snowmobile-nh.com/trail-reports/tower-hill",
            "http://snowmobile-nh.com/trail-reports/pawtuckaway-state-park",
            "https://www.facebook.com/snhss/",
            "http://snowmobile-nh.com/trail-reports/pawtuckaway-state-park",
            "http://snhss:snhss@50.245.37.138:8092/cgi-bin/mjpg/video.cgi",
            "https://www.wunderground.com/q/zmw:03034.1.99999",
            "http://snowmobile-nh.com/our-club/join-the-club"
]
var urlS = ["http://snowmobile-nh.com/index.php/trail-reports/bear-brook-state-park",
            "http://snowmobile-nh.com/index.php/trail-reports/tower-hill",
            "http://snowmobile-nh.com/index.php/trail-reports/pawtuckaway-state-park",
            "https://www.facebook.com/snhss/",
            "http://snowmobile-nh.com/trail-reports/pawtuckaway-state-park",
            "http://snhss:snhss@50.245.37.138:8092/cgi-bin/mjpg/video.cgi",
            "https://www.wunderground.com/q/zmw:03034.1.99999",
            "http://snowmobile-nh.com/index.php/our-club/join-the-club"
]
var urlString = ["Trail Conditions",
            "Trail Conditions",
            "Trail Conditions",
            "Facebook Group",
            "Points of Interest",
            "Web Camera",
            "Candia Weather",
            "Join the Club!"
]
var urlSel: Int? = Int()
var counter: Int? = Int()
var imgNum = 1

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var coolImg: UIImageView!
    @IBOutlet weak var snhssRight: UIImageView!
    @IBOutlet weak var MyCollectionView: UICollectionView!
    @IBOutlet weak var snhssLeft: UIImageView!
    @IBAction func unwindSegue(unwindSegue:UIStoryboardSegue){
        let hh = self.MyCollectionView
        hh?.dataSource = self
        hh?.delegate = self
        setBackground()
    }

    let btnImgs = ["imgBB", "imgTH", "imgPW", "imgFB", "imgPOI", "imgWebcam", "imgWeather", "imgJoinus"]
    let btnTxts = ["Bear Brook", "Tower Hill", "Pawtuckaway", "facebook", "POI", "WebCam", "Weather","Join Us"]
    var numCols = 3
    var initialLoad = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        shieldSpacing()
        
        self.automaticallyAdjustsScrollViewInsets = true
        
        setBackground()
        self.navigationController?.isNavigationBarHidden = true;
        self.navigationController?.navigationBar.isHidden = true;
        
        self.MyCollectionView.delegate = self
        self.MyCollectionView.dataSource = self
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return btnImgs.count
    }
    
    func setBackground(){
        MyCollectionView.backgroundColor = UIColor.lightGray
        if imgNum == 1{
            MyCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bSnow")!)
            imgNum = imgNum + 1
        }else if imgNum == 2{
            MyCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bGroomer110")!)
            imgNum = imgNum + 1
        }else if imgNum == 3{
            MyCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bSledding")!)
            imgNum = imgNum - 2
        }
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //       layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        let containerHeight = MyCollectionView.bounds.height
        print("containerHeight \(containerHeight)")
        var minLineSpace = (containerHeight-(4*120))/5
        print("minLineSpace \(minLineSpace)")
        
        if minLineSpace <= 9 {
            minLineSpace = 10
        }
        
        layout.minimumLineSpacing = minLineSpace
        layout.itemSize = CGSize(width: 120, height: 120)
        MyCollectionView.collectionViewLayout = layout

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! myCollectionViewCell
        cell.myImageCell.image = UIImage(named: btnImgs[indexPath.row])
        cell.cellLabel.text = (btnTxts[indexPath.row])
        cell.layer.cornerRadius = 6
        cell.layer.shadowRadius = 4
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shieldSpacing(){
        let containerWidth = MyCollectionView.bounds.width
 //       let containerHeight = MyCollectionView.bounds.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        var ttt: CGFloat
        var tt: CGFloat
        let imgL = snhssLeft
        let imgR = snhssRight
        if UIDevice.current.orientation.isLandscape == false{
            let containerWidth = self.view.bounds.width
            let containerHeight = self.view.bounds.height
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            var minLineSpace = (containerWidth-(4*120))/5

            if minLineSpace <= 9 {
                minLineSpace = 10
            }
            
            layout.minimumLineSpacing = minLineSpace
            layout.itemSize = CGSize(width: 120, height: 120)
            MyCollectionView.collectionViewLayout = layout
            MyCollectionView.collectionViewLayout = layout
            
            if(initialLoad==1){
                ttt = ((containerHeight/2)-90)/3
                tt = (containerWidth/8)*7
            }else{
                ttt = ((containerWidth/2)-90)/3
                tt = (containerWidth/8)*6.2
                initialLoad=1
            }
            UIImageView.animate(withDuration: 0.5, animations: {
                imgR?.frame = CGRect(x: tt, y: 0, width: 50, height: 50)
                imgL?.frame = CGRect(x: ttt, y: 0, width: 50, height: 50)
            })
            MyCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
            
        }else {
            let x = (containerWidth-(2*120))/2
            layout.minimumLineSpacing = x
            layout.itemSize = CGSize(width: 120, height: 120)
            MyCollectionView.collectionViewLayout = layout
            let y = (containerWidth/5)

            let u = (y * 4)-70

            let a = (((containerWidth - coolImg.frame.width)/2)-25)
            
            UIImageView.animate(withDuration: 1.0, animations: {
                imgL?.frame = CGRect(x: a+20, y: 0, width: 50, height: 50)
                imgR?.frame = CGRect(x: u, y: 0, width: 50, height: 50)
                
            })
            MyCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var numCols: Int
        var numRows: Float
        if (UIApplication.shared.statusBarOrientation.isLandscape){
            numCols = 5
            numRows = 2.5
        }else{
            numCols = 3
            numRows = 4.5
        }
        print(collectionView.layer.frame.size.height)
        let iconWidths = 120 * (numCols-1)
        let iconHeights = 120 * (numRows)
        var topBorder = (collectionView.layer.frame.size.height - CGFloat(iconHeights)) / CGFloat(numRows)
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(iconWidths)) / CGFloat(numCols)
        if topBorder<=9{
            topBorder = 10
        }
        
        return UIEdgeInsetsMake(topBorder, leftInset, topBorder, leftInset)
    }
 
    
    @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected row is: ", indexPath.row)
        urlSel = indexPath.row
        if urlSel == 4{
            performSegue(withIdentifier: "toMapPage", sender: self)
        }else{
            performSegue(withIdentifier: "toWebPage", sender: self)
        }
        loadView()
        
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        shieldSpacing()
        super.viewWillLayoutSubviews()
        MyCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.MyCollectionView.setNeedsLayout()
        
    }

}

