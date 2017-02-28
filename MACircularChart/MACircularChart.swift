//
//  MACircularChart.swift
//  MACircularChart
//
//  Created by Mina Ashena on 12/10/1395 AP.
//  Copyright © 1395 MA. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class MACircularChart: UIView {
    
    @IBInspectable var containerCircleColor: UIColor = UIColor.lightGray
    @IBInspectable var gradientStartColor: UIColor = UIColor.yellow
    @IBInspectable var gradientEndColor: UIColor = UIColor.red
    @IBInspectable var arcWidth: CGFloat = 20
    @IBInspectable var progressPercent: CGFloat = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        circularProgressView_init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        circularProgressView_init()
    }
    
    fileprivate func circularProgressView_init() {
        let viewHeight = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        self.addConstraint(viewHeight)
    }
    
    override func prepareForInterfaceBuilder() {
        circularProgressView_init()
    }
    
    override func draw(_ rect: CGRect) {
        let width = self.bounds.width
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let radius: CGFloat = (width - (arcWidth * 2.5)) / 2
        let progressStartAngle: CGFloat = 3 * CGFloat.pi / 2
        let progressEndAngle: CGFloat = ConvertToTrigonometry.shared.trigonimetryCordinate(percentage: progressPercent) //CGFloat.pi / 2
        
        //fill circular
        let circlePath = UIBezierPath(arcCenter:  center,
                                      radius: radius,
                                      startAngle: 0,
                                      endAngle: 360,
                                      clockwise: true)
        circlePath.lineWidth = arcWidth
        containerCircleColor.setStroke()
        circlePath.stroke()
        
        
        //MARK: ProgressPath
        let progressPath = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: progressStartAngle,
                                        endAngle: progressEndAngle,
                                        clockwise: true)
        progressPath.lineWidth = arcWidth
        progressPath.lineCapStyle = .round
        
        //MARK: Gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [gradientStartColor.cgColor , gradientEndColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x:1, y:1)
        gradientLayer.frame = self.bounds
        
        //MARK: Mask Layer
        let maskLayer = CAShapeLayer()
        maskLayer.path = progressPath.cgPath
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.strokeColor = UIColor.black.cgColor
        maskLayer.lineWidth = arcWidth
        maskLayer.lineCap = kCALineCapRound
        maskLayer.masksToBounds = false
        
        gradientLayer.mask = maskLayer
        
        //MARK: Shadow
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.backgroundColor = UIColor.gray.cgColor
        layer.addSublayer(shadowLayer)
        
        let maskShadowLayer = CAShapeLayer()
        maskShadowLayer.path = progressPath.cgPath
        maskShadowLayer.fillColor = UIColor.clear.cgColor
        maskShadowLayer.backgroundColor = UIColor.black.cgColor
        maskShadowLayer.strokeColor = UIColor.black.cgColor
        maskShadowLayer.lineWidth = arcWidth
        maskShadowLayer.lineCap = kCALineCapRound
        maskShadowLayer.masksToBounds = false
        maskShadowLayer.shadowColor = UIColor.black.cgColor
        maskShadowLayer.shadowOpacity = 0.5
        maskShadowLayer.shadowOffset = CGSize(width: 3.1, height: 3.1)
        
        shadowLayer.mask = maskShadowLayer
        
        //MARK: Animation
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        anim.duration = 2
        anim.fillMode = kCAFillModeForwards
        anim.fromValue = 0
        anim.toValue = 1
        
        maskShadowLayer.add(anim, forKey: nil)
        maskLayer.add(anim, forKey: nil)
        gradientLayer.add(anim, forKey: nil)
        
        layer.addSublayer(gradientLayer)
        
    }
}
