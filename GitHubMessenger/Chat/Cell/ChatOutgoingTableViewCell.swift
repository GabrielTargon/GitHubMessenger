//
//  ChatOutgoingTableViewCell.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 18/03/20.
//  Copyright © 2020 Gabriel Targon. All rights reserved.
//

import UIKit

class ChatOutgoingTableViewCell: UITableViewCell {

    @IBOutlet weak var outgoingBubbleImage: UIImageView!
    @IBOutlet weak var outgoingBubbleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabelSize(messageText: String) {
        outgoingBubbleLabel.text = messageText
        
        let size = CGSize(width: 250, height: 100)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: outgoingBubbleLabel.font.pointSize)], context: nil)
        outgoingBubbleImage.frame = CGRect(x: 20,
                                           y: 0,
                                           width: estimatedFrame.width + 25,
                                           height: estimatedFrame.height + 25)
        outgoingBubbleLabel.frame = CGRect(x: outgoingBubbleImage.center.x - (estimatedFrame.width/2) + 2,
                                           y: outgoingBubbleImage.center.y - (estimatedFrame.height/2),
                                           width: estimatedFrame.width,
                                           height: estimatedFrame.height)
        setBubbleSize()
    }
    
    func setBubbleSize() {
        guard let image = UIImage(named: "left_bubble") else { return }
        outgoingBubbleImage.image = image.resizableImage(withCapInsets: UIEdgeInsets(top: 13, left: 20, bottom: 13, right: 13), resizingMode: .stretch)
    }
    
}
