//
//  ViewController.swift
//  SMUIK_7
//
//  Created by Andrei Kovryzhenko on 21.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.frame = view.bounds
        scrollView.scrollIndicatorInsets = UIEdgeInsets(
            top: 270 - view.safeAreaInsets.top ,
            left: 0,
            bottom: 0,
            right: 0
        )
        scrollView.contentSize = CGSize(
            width: view.bounds.width,
            height: view.bounds.height + 600
        )
        return scrollView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "marathonImage")
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: 270
        )
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        croppingImage(imageView: &imageView)
        scrollView.addSubview(imageView)
    }
    
    private func croppingImage( imageView: inout UIImageView) {
        if let croppedImage = imageView.croppedImage() {
            let newImageView = UIImageView(image: croppedImage)
            newImageView.contentMode = .scaleAspectFill
            imageView = newImageView
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < 0 {
            imageView.frame = CGRect(
                x: 0,
                y: offsetY,
                width: view.bounds.width,
                height: 270 - offsetY
            )
            scrollView.scrollIndicatorInsets = UIEdgeInsets(
                top: 270 - offsetY - view.safeAreaInsets.top ,
                left: 0,
                bottom: 0,
                right: 0
            )
        }
    }
}

extension UIImageView {
    func croppedImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return image
    }
}
