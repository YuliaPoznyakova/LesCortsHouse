//
//  ProgressHeaderView.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 05.06.2024.
//

import UIKit

class ProgressHeaderView: UICollectionReusableView {
    static var elementKind: String { UICollectionView.elementKindSectionHeader }
    
    var progress: CGFloat = 0 {
        didSet {
            setNeedsLayout()
            widthConstraint?.constant = progress * bounds.width
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
    }
    
    private let leftView = UIView(frame: .zero)
    private let rightView = UIView(frame: .zero)
    private let containerView = UIView(frame: .zero)
    private var widthConstraint: NSLayoutConstraint?
    private var valueFormat: String {
        NSLocalizedString("%d percent", comment: "progress percentage value format")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
        
        isAccessibilityElement = true
        accessibilityLabel = NSLocalizedString("Progress", comment: "Progress view accessibility label")
        accessibilityTraits.update(with: .updatesFrequently)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        accessibilityValue = String(format: valueFormat, Int(progress * 100.0))
        widthConstraint?.constant = progress * bounds.width
    }
    
    private func prepareSubviews() {
        containerView.addSubview(leftView)
        containerView.addSubview(rightView)
        addSubview(containerView)
        
        leftView.translatesAutoresizingMaskIntoConstraints = false
        rightView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        containerView.heightAnchor.constraint(equalTo: heightAnchor, constant: -30).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        containerView.widthAnchor.constraint(equalTo: widthAnchor, constant: -30).isActive = true
        
        leftView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        leftView.topAnchor.constraint(equalTo: rightView.topAnchor).isActive = true
        rightView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        rightView.bottomAnchor.constraint(equalTo: leftView.bottomAnchor).isActive = true
        
        rightView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor).isActive = true
        leftView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        widthConstraint = leftView.widthAnchor.constraint(equalToConstant: 0)
        widthConstraint?.isActive = true
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 30
        
        backgroundColor = .clear
        containerView.backgroundColor = .clear
        rightView.backgroundColor = .lightGray
        leftView.backgroundColor = .green
    }
}
