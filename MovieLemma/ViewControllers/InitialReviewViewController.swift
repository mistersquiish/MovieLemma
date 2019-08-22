//
//  InitialReviewViewController.swift
//  MovieLemma
//
//  Created by Henry Vuong on 8/22/19.
//  Copyright © 2019 Henry Vuong. All rights reserved.
//

import UIKit
import AlamofireImage

class InitialReviewViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    var movies: [Movie] = []
    var reviews: [Review] = []
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        // Do any additional setup after loading the view.
    }
    
    func configurePageViewController() {
        movies = Movie.generateMovie()
        reviews = createReviews()
        print(reviews)
        
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
        dataViewController.dateText = String(describing: movies[index].releaseDate)
        
        return dataViewController
    }

    func createReviews() -> [Review] {
        var reviews: [Review] = []
        
        for movie in movies {
            reviews.append(Review(movie: movie, userId: "", rating: 0))
        }
        
        return reviews
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
        
        currentViewControllerIndex = currentIndex
        
        if currentIndex == movies.count {
            return nil
        }
        
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        return detailViewControllerAt(index: currentIndex)
    }
}
