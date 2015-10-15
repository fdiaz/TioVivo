//
//  ViewController.swift
//  Tiovivo
//
//  Created by Francisco Díaz on 10/15/15.
//  Copyright © 2015 Francisco Díaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            tiovivo = Tiovivo(scrollView: scrollView, images: images)
        }
    }
    
    private var tiovivo: Tiovivo!
    private let images = [UIImage(named: "valdivia01")!, UIImage(named: "valdivia02")!]
    
}

