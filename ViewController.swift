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


class ViewController: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    private var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0...19 {
            addItem()
        }
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
    }
    
    
    private func addItem() {
        items.append(Item(color: .random()))
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath)
        cell.contentView.backgroundColor = items[indexPath.item].color
        return cell
    }
    
    
}
