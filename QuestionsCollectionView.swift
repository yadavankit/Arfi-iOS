//
//  QuestionsCollectionView.swift
//  Udiva
//
//  Created by Ankit Yadav on 02/07/16.
//  Copyright © 2016 Udiva. All rights reserved.
//

import UIKit
import CircleSlider

class QuestionsCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate
{
    var modelSize = [1: "", 2: "", 3: "", 4: ""]
    override func awakeFromNib()
    {
        self.dataSource = self
        self.delegate = self
        print(self.modelSize)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let bustNib = UINib(nibName: "BustCell", bundle: nil)
        self.registerNib(bustNib, forCellWithReuseIdentifier: "bustCell")
        
        let waistNib = UINib(nibName: "WaistCell", bundle: nil)
        self.registerNib(waistNib, forCellWithReuseIdentifier: "waistCell")

        let hipNib = UINib(nibName: "HipCell", bundle: nil)
        self.registerNib(hipNib, forCellWithReuseIdentifier: "hipCell")
        
        let heightNib = UINib(nibName: "HeightCell", bundle: nil)
        self.registerNib(heightNib, forCellWithReuseIdentifier: "heightCell")
        
        let submitNib = UINib(nibName: "submitCell", bundle: nil)
        self.registerNib(submitNib, forCellWithReuseIdentifier: "submitCell")
        
        let complexionNib = UINib(nibName: "complexionCell", bundle: nil)
        self.registerNib(complexionNib, forCellWithReuseIdentifier: "complexionCell")
        

        if indexPath.row == 0
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("bustCell", forIndexPath: indexPath) as! BustCell
            self.modelSize[1] = cell.valueLabel.text
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("waistCell", forIndexPath: indexPath) as! WaistCell
            self.modelSize[2] = cell.valueLabel.text
            return cell
        }
        else if indexPath.row == 2
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("hipCell", forIndexPath: indexPath) as! HipCell
            self.modelSize[3] = cell.valueLabel.text
            return cell
        }
        else if indexPath.row == 3
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("heightCell", forIndexPath: indexPath) as! HeightCell
            self.modelSize[4] = cell.valueLabel.text
            return cell
        }
        else if indexPath.row == 4
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("complexionCell", forIndexPath: indexPath) as! complexionCell
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("submitCell", forIndexPath: indexPath)
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 500, 100)
            print(modelObject.bust)
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        if indexPath.row == 5
        {
            return CGSize(width: 500, height: 9)
        }
        else if indexPath.row == 4
        {
            return CGSize(width: 500, height: 250)
        }
        return CGSize(width: 500, height:300)
    }
}