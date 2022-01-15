//
//  GradientBackgroundViewController.swift
//  Example
//
//  Created by Merrick Sapsford on 04/10/2020.
//

import UIKit

final class GradientBackgroundViewController: UIViewController {
    
    // MARK: Properties
    
    private lazy var gradientView = GradientView(colors: colors)
    private let child: UIViewController
    
    private let colors: [UIColor]
    
    // MARK: Init
    
    init(embedding child: UIViewController, colors: [UIColor]) {
        self.child = child
        self.colors = colors
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not Supported")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor)
        ])
        
        addChild(child)
        view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: child.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: child.view.bottomAnchor)
        ])
    }
}

private final class GradientView: UIView {
    
    // MARK: Properties
    
    private var gradientLayer: CAGradientLayer? {
        if let gradientLayer = self.layer as? CAGradientLayer {
            return gradientLayer
        }
        return nil
    }
    
    var colors: [UIColor]? {
        didSet {
            var colorRefs = [CGColor]()
            for color in colors ?? [] {
                colorRefs.append(color.cgColor)
            }
            gradientLayer?.colors = colorRefs
        }
    }
    
    var locations: [Double]? {
        didSet {
            var locationNumbers = [NSNumber]()
            for location in locations ?? [] {
                locationNumbers.append(NSNumber(value: location))
            }
            gradientLayer?.locations = locationNumbers
        }
    }
    
    var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0) {
        didSet {
            gradientLayer?.startPoint = startPoint
        }
    }
    
    var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0) {
        didSet {
            gradientLayer?.endPoint = endPoint
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    // MARK: Init
    
    init(colors: [UIColor]) {
        super.init(frame: .zero)
        commonInit(colors: colors)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(colors: [UIColor] = [UIColor.white, UIColor.black]) {
        self.colors = colors
        gradientLayer?.startPoint = self.startPoint
        gradientLayer?.endPoint = self.endPoint
    }
}
