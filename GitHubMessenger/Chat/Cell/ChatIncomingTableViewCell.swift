//
//  ChatIncomingTableViewCell.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 18/03/20.
//  Copyright © 2020 Gabriel Targon. All rights reserved.
//

import UIKit

class ChatIncomingTableViewCell: UITableViewCell {

    @IBOutlet weak var incomingBubbleImage: UIImageView!
    @IBOutlet weak var incomingBubbleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabelSize(messageText: String) {
        incomingBubbleLabel.text = messageText
        
        let size = CGSize(width: 250, height: 100)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: incomingBubbleLabel.font.pointSize)], context: nil)
        incomingBubbleImage.frame = CGRect(x: contentView.frame.width - estimatedFrame.width - 25,
                                           y: 0,
                                           width: estimatedFrame.width + 25,
                                           height: estimatedFrame.height + 25)
        incomingBubbleLabel.frame = CGRect(x: incomingBubbleImage.center.x - (estimatedFrame.width/2) - 3,
                                           y: incomingBubbleImage.center.y - (estimatedFrame.height/2),
                                           width: estimatedFrame.width,
                                           height: estimatedFrame.height)
        setBubbleSize()
    }
    
    func setBubbleSize() {
        guard let image = UIImage(named: "right_bubble") else { return }
        incomingBubbleImage.image = image.resizableImage(withCapInsets: UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 20), resizingMode: .stretch)
    }
    
}

