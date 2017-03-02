//
//  KDLoadingExtension.swift
//  KDLoadingView
//
//  Created by Rodrigo Soldi Lopes on 02/03/17.
//  Copyright © 2017 Kaique Damato. All rights reserved.
//

extension KDLoadingView {
    
    public class func animate(lineWidth: CGFloat = 2.0, size: CGFloat = 25, duration: CGFloat = 3.0, firstColor: UIColor? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), secondColor: UIColor? = nil, thirdColor: UIColor? = nil) {
        guard let window = UIApplication.shared.keyWindow,
            let topView = window.rootViewController?.view else {
                return
        }
        
        // Blur View
        let blurView = KDLoadingBlurView(effect: UIBlurEffect(style: .light))
        blurView.frame = topView.frame
        
        let frame = CGRect(x: 0, y: 0, width: size, height: size)
        let loadingView = KDLoadingView(frame: frame, lineWidth: lineWidth, firstColor: firstColor, secondColor: secondColor, thirdColor: thirdColor, duration: duration)
        loadingView.center = blurView.center
        
        blurView.addSubview(loadingView)
        loadingView.startAnimating()
        blurView.loadingView = loadingView
        
        addSubviewWithTransitionAnimation(fromView: topView, toView: blurView)
    }
    
    public class func stop() {
        if let window = UIApplication.shared.keyWindow {
            guard let topView = window.rootViewController?.view else {
                return
            }
            
            for view in topView.subviews {
                if view.isKind(of: KDLoadingBlurView.self) {
                    removeLoadingBlurView(view as! KDLoadingBlurView)
                }
            }
        }
    }
    
    private class func addSubviewWithTransitionAnimation(fromView: UIView, toView: UIView) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionReveal
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        toView.layer.add(transition, forKey: nil)
        fromView.addSubview(toView)
    }
    
    private class func removeLoadingBlurView(_ view: KDLoadingBlurView) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            view.loadingView?.alpha = 0.0
            view.alpha = 0.0
        }, completion: { (_) in
            view.removeFromSuperview()
        })
    }
}

