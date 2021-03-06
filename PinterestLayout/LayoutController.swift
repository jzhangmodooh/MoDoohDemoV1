//
//  LayoutController.swift
//  PinterestLayout
//
//  Created by Jeremy on 01/21/16.
//  Copyright (c) 2016 MoDooh Inc. All rights reserved.
//

import UIKit

let reuseIdentifier = "collCell"

class LayoutController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    let titles = ["Sand Harbor, Lake Tahoe - California","Beautiful View of Manhattan skyline.","Watcher in the Fog","Great Smoky Mountains National Park, Tennessee","Most beautiful place"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 50
    }


    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.title.text = self.titles[indexPath.row % 5]
        let curr = indexPath.row % 5  + 1
        let imgName = "pin\(curr).jpg"
        cell.pinImage.image = UIImage(named: imgName)

        return cell
    }
    


   
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
            return CGSize(width: 170, height: 300)
    }
    


    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier)
        print(sender)
        if(segue.identifier == "detail"){
            let cell = sender as! CollectionViewCell
            let indexPath = collectionView?.indexPathForCell(cell)
            let vc = segue.destinationViewController as! DetailViewController

            let curr = indexPath!.row % 5  + 1
            let imgName = "pin\(curr).jpg"
            
            print(vc)
            vc.currImage = UIImage(named: imgName)
            vc.textHeading = self.titles[indexPath!.row % 5]
//            
//            vc.heading.text = self.titles[0]
//            vc.imageView.image = UIImage(named: imgName)
        }
    }

    

}
