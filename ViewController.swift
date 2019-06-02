//
//  ViewController.swift
//  UICollectionViewWithAnimationRows
//
//  Created by Артём Кармазь on 5/31/19.
//  Copyright © 2019 Artem Karmaz. All rights reserved.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}

struct Item {
    var color: UIColor
}

var items = [Item]()


class ViewController: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0...10 {
            addItem()
        }
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.setCollectionViewLayout(CustomFlowLayout(), animated: false)
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        addItem()
        let indexPath = IndexPath(item: items.count - 1, section: 0)
        print("Index path is - \(indexPath)")
        myCollectionView.performBatchUpdates({
            self.myCollectionView.insertItems(at: [indexPath])
        }, completion: nil)
    }
    
    
    private func addItem() {
        items.append(Item(color: .random()))
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath)
        cell.contentView.backgroundColor = items[indexPath.item].color
        return cell
    }
    
    
}

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    var insertingIndexPaths = [IndexPath]()
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        insertingIndexPaths.removeAll()
        
        for update in updateItems {
            if let indexPath = update.indexPathAfterUpdate, update.updateAction == .insert {
                insertingIndexPaths.append(indexPath)
            }
        }
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        
        insertingIndexPaths.removeAll()
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        
        if insertingIndexPaths.contains(itemIndexPath) {
            attributes?.alpha = 0.0
//            attributes?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1) // respawn inside of cell
            attributes?.transform = CGAffineTransform(translationX: 0, y: 500) // drop from bottom
        }
        
        return attributes
    }
}
