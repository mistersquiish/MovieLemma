//
//  InitialReviewDataViewController.swift
//  MovieLemma
//
//  Created by Henry Vuong on 8/22/19.
//  Copyright © 2019 Henry Vuong. All rights reserved.
//

import UIKit
import AlamofireImage

protocol updateReview {
    func updateReview(index: Int, rating: Int)
}

class InitialReviewDataViewController: UIViewController {
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var updateReviewDelegate: updateReview?
    var displayText: String!
    var imageURL: URL!
    var dateText: String!
    var index: Int!
    var ratingText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieLabel.text = displayText
        imageView.af_setImage(withURL: imageURL)
        dateLabel.text = dateText!
        ratingLabel.text = ratingText!
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ratingsButton(_ sender: UIButton) {
        ratingLabel.text = String(describing: sender.tag)
        updateReviewDelegate?.updateReview(index: index, rating: sender.tag)
    }
    

}
