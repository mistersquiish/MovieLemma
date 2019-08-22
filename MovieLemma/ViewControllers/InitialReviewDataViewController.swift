//
//  InitialReviewDataViewController.swift
//  MovieLemma
//
//  Created by Henry Vuong on 8/22/19.
//  Copyright © 2019 Henry Vuong. All rights reserved.
//

import UIKit
import AlamofireImage

class InitialReviewDataViewController: UIViewController {
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var displayText: String!
    var imageURL: URL!
    var dateText: String!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieLabel.text = displayText
        imageView.af_setImage(withURL: imageURL)
        dateLabel.text = dateText
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ratingsButton(_ sender: Any) {
        dateLabel.textColor = .green
    }
    

}
