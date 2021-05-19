//
//  BubbleCell.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 27/04/21.
//  Copyright © 2021 Gabriel Targon. All rights reserved.
//

import UIKit

class BubbleCell: UITableViewCell {
    
    lazy var bubbleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var bubbleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.contentMode = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var type: BubbleType = .incoming
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Methods
    
    func setLabelSize(messageText: String, type: BubbleType) {
        bubbleLabel.text = messageText
        
        let size = CGSize(width: 250, height: 100)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: bubbleLabel.font.pointSize)], context: nil)
        bubbleImage.frame = CGRect(x: type == .outgoing ?
                                    10 :
                                    contentView.frame.width - estimatedFrame.width - 35,
                                   y: 0,
                                   width: estimatedFrame.width + 25,
                                   height: estimatedFrame.height + 25)
        bubbleLabel.frame = CGRect(x: type == .outgoing ?
                                    bubbleImage.center.x - (estimatedFrame.width/2) + 2 :
                                    bubbleImage.center.x - (estimatedFrame.width/2) - 3,
                                   y: bubbleImage.center.y - (estimatedFrame.height/2),
                                   width: estimatedFrame.width,
                                   height: estimatedFrame.height)
        setBubbleSize(type: type)
    }
    
    func setBubbleSize(type: BubbleType) {
        guard let image = UIImage(named: type.image) else { return }
        bubbleImage.image = image.resizableImage(withCapInsets: UIEdgeInsets(top: 13, left: type.bubbleEdgeLeft, bottom: 13, right: type.bubbleEdgeRight), resizingMode: .stretch)
    }
}

extension BubbleCell: ViewCode {
    func setupHierarchy() {
        addSubview(bubbleImage)
        addSubview(bubbleLabel)
    }
    
    func setupConstraints() {
        // No constraints needed
    }
    
    func setupConfigurations() {
        self.selectionStyle = .none
    }
}
