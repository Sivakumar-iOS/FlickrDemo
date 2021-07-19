//
//  ViewController.swift
//  Flickr_Collections
//
//  Created by Sivakumar on 19/07/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    let handler = jsonHandler()
    var photoDetails: Models!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        readURL()
    }
    
    func readURL() {
        handler.makeGetCall(url: base_URL) { (response, error) in
            //check for errors
            if error == nil  {
                //Parse JSON
                let decoder = JSONDecoder()
                
                do {
                    let jsonData = try decoder.decode(Models.self, from: (response?.data)!)
                    self.photoDetails = jsonData
                    
                    DispatchQueue.main.async {
                        self.imageCollectionView.reloadData()
                    }
                } catch {
                    print("Error in Json Parsing == \(error)")
                }
                
            }
        }
    }
}



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == imageCollectionView {
            if photoDetails == nil {
                return 0
            } else {
                return photoDetails.photos.photo.count
            }
        }
      return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionViewCell
        cell.designCell()
        let responseDetails = photoDetails.photos.photo[indexPath.row]
        
       // https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
       // https://farm4.staticflickr.com/3754/9422871791_db45e0b7ed.jpg
        
        
        let photoPath = "https://farm" + "\(responseDetails.farm)" + ".staticflickr.com/" + "\(responseDetails.server)/" + "\(responseDetails.id)" + "_\(responseDetails.secret)" + ".jpg"
        
        print("URL------>",photoPath)
        
            cell.photoImage.sd_setImage(with: URL(string: photoPath), placeholderImage: UIImage(named: ""))
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10) / 2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.selectOrDeselectItem()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.designCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.selectOrDeselectItem()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.designCell()
        }
    }
}

extension UIView {
    func designCell() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.masksToBounds = true
        
    }
    
    func selectOrDeselectItem() {
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.blue.cgColor
    }
}

