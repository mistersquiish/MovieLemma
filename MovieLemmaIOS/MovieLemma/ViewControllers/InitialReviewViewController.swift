//
//  InitialReviewViewController.swift
//  MovieLemma
//
//  Created by Henry Vuong on 8/22/19.
//  Copyright © 2019 Henry Vuong. All rights reserved.
//

import UIKit
import AlamofireImage
import Firebase

class InitialReviewViewController: UIViewController, didRate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var continueButtonOutlet: UIButton!
    
    var movies: [Movie] = []
    var reviews: [Review] = []
    var currentViewControllerIndex = 0
    var db: Firestore!
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        // configure database
        db = Firestore.firestore()
        
        // get current user
        currentUser = Auth.auth().currentUser
        
        // UI
        continueButtonOutlet.alpha = 0
    }
    
    @IBAction func continueButton(_ sender: Any) {
        // save all the reviews to database
        
        for review in reviews {
            var ref: DocumentReference? = nil
            ref = db.collection("reviews").addDocument(data: [
                "user_id": "\(currentUser.uid)",
                "user_email": "\(String(describing: currentUser.email!))",
                "movie_id": review.movie.movieId!,
                "movie_name": "\(String(describing: review.movie.title!))",
                "rating": review.rating!
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
        
        
    }
    
    
    func configurePageViewController() {
        movies = Movie.generateMovie()
        reviews = createReviews()
        
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: InitialReviewPageViewController.self)) as? InitialReviewPageViewController else {
            return
        }
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pageViewController.view)
        
        let views: [String: Any] = ["pageView": pageViewController.view!]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else {
            return
        }
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
    }
    
    func detailViewControllerAt(index: Int) -> InitialReviewDataViewController? {
        if index >= movies.count || movies.count == 0 {
            return nil
        }
        
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: InitialReviewDataViewController.self)) as? InitialReviewDataViewController else {
            return nil
        }
        // set values for pages
        dataViewController.index = index
        dataViewController.displayText = movies[index].title
        dataViewController.imageURL = movies[index].posterUrl
        dataViewController.dateText = String(describing: movies[index].releaseDate!)
        dataViewController.ratingText = String(describing: reviews[index].rating!)
        dataViewController.didRateDelegate = self
        
        return dataViewController
    }

    func createReviews() -> [Review] {
        var reviews: [Review] = []
        
        for movie in movies {
            reviews.append(Review(movie: movie, userId: "", rating: 0))
        }
        
        return reviews
    }
    
    // delegate method for when rating buttons are pushed
    func didRate(index: Int, rating: Int) {
        
        // update reviews
        reviews[index].rating = rating
        
        // check if all reviews are complete, if so then present the 'next' button
        var didFinishReviews = true
        for review in reviews {
            if review.rating == 0 {
                didFinishReviews = false
                break
            }
        }
        
        if didFinishReviews {
            continueButtonOutlet.alpha = 1
        }
    }
}

extension InitialReviewViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for InitialReviewPageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return movies.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? InitialReviewDataViewController
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        
        currentViewControllerIndex = currentIndex
        
        if currentIndex == 0 {
            return nil
        }
        
        currentIndex -= 1
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? InitialReviewDataViewController
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        // update ratings
        //reviews[currentViewControllerIndex].rating = Int((dataViewController?.ratingLabel.text)!)
        
        currentViewControllerIndex = currentIndex
        
        if currentIndex == movies.count {
            return nil
        }
        
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        
        return detailViewControllerAt(index: currentIndex)
    }
}
