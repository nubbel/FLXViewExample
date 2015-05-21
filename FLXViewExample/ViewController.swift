//
//  ViewController.swift
//  FLXViewExample
//
//  Created by Dominique d'Argent on 21/05/15.
//  Copyright (c) 2015 Dominique d'Argent. All rights reserved.
//

import UIKit
import FLXView

public let infoText = "The Réunion parrot or Dubois's parrot (Necropsittacus  "
    + "borbonicus) is a hypothetical extinct species of parrot "
    + "based on descriptions of birds from the Mascarene island "
    + "of Réunion. Its existence has been inferred from the "
    + "travel report of Dubois in 1674 who described it as "
    + "having a “Body the size of a large pigeon, green; head, "
    + "tail and upper part of wings the colour of fire.” No "
    + "remains have been found of this supposed species, and "
    + "its existence seems doubtful."


public let Bird1 = UIImage(named: "Bird1")!

public let Bird2 = UIImage(named: "Bird2")!

public let Bird3 = UIImage(named: "Bird3")!

public let Bird4 = UIImage(named: "Bird4")!

public let Bird5 = UIImage(named: "Bird5")!

public let Bird6 = UIImage(named: "Bird6")!

public class Avatar: UIImageView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = true
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
}

public class Button: UIButton {
    public convenience init(label: String) {
        self.init()
        
        setTitle(label, forState: .Normal)
        layer.cornerRadius = 5
    }
}

public class Label: UILabel {
    public convenience init(text string: String, align: NSTextAlignment = .Center, fontSize: CGFloat = 20) {
        self.init()
        
        font = UIFont(name: "Avenir Next", size: fontSize)
        numberOfLines = 0
        text = string
        textAlignment = align
    }
}

public class Separator: UIView {
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        
        backgroundColor = UIColor(white: 0.92, alpha: 1)
    }
}

public class Tag: UILabel {
    static let Padding = UIEdgeInsets(top: 3, left: 5, bottom: 2, right: 5)
    
    public convenience init(name: String) {
        self.init()
        
        font = UIFont(name: "Avenir Next", size: 16)
        layer.backgroundColor = UIColor(hue: 0.3, saturation: 0.5, brightness: 0.8, alpha: 1).CGColor
        layer.borderColor = UIColor(white: 0.92, alpha: 1).CGColor
        layer.borderWidth = 1
        layer.cornerRadius = 4
        text = name
        textColor = UIColor.whiteColor()
    }
    
    public override func sizeThatFits(size: CGSize) -> CGSize {
        var result = super.sizeThatFits(size)
        
        result.width += Tag.Padding.left + Tag.Padding.right
        result.height += Tag.Padding.top + Tag.Padding.bottom
        
        return result
    }
    
    public override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, Tag.Padding))
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    let flexView : FLXView = FLXView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flexView.backgroundColor = UIColor.whiteColor()
        flexView.childAlignment = .Stretch
        flexView.direction = .Column
        flexView.padding = FLXPadding(top: 8, left: 0, bottom: 8, right: 0)
        
        let header = FLXView()
        header.childAlignment = .Center
        header.direction = .Row
        header.flx_margins = FLXMargins(top: 0, left: 8, bottom: 0, right: 8)
        flexView.addSubview(header)
        
        let avatar = Avatar(image: Bird6)
        avatar.flx_layoutStrategy = FLXLayoutStrategy.fixed(CGSize(width: 80, height: 80))
        avatar.flx_margins = FLXMargins(top: 8, left: 8, bottom: 8, right: 8)
        avatar.flx_selfAlignment = .Start
        header.addSubview(avatar)
        
        let title = Label(text: "Necropsittacus Borbonicus", align: .Left, fontSize: 24)
        title.flx_flex = 1
        title.flx_margins = FLXMargins(top: 8, left: 8, bottom: 8, right: 8)
        header.addSubview(title)
        
        let subtitle = Label(text: "A pretty but unfortunately extinct bird.", align: .Left)
        subtitle.flx_margins = FLXMargins(top: 8, left: 8, bottom: 8, right: 8)
        flexView.addSubview(subtitle)
        
        flexView.addSubview(Separator())
        
        let body = Label(text: infoText, align: .Left, fontSize: 16)
        body.flx_margins = FLXMargins(top: 8, left: 8, bottom: 8, right: 8)
        flexView.addSubview(body)
        
        flexView.addSubview(Separator())
        
        let tags = Label(text: "Tags:", align: .Left)
        tags.flx_margins = FLXMargins(top: 8, left: 8, bottom: 8, right: 8)
        flexView.addSubview(tags)
        
        let tagList = FLXView(frame: CGRectMake(0, 0, 200, 200))
        tagList.childAlignment = .Start
        tagList.direction = .Row
        tagList.flx_margins = FLXMargins(top: 0, left: 8, bottom: 8, right: 8)
        tagList.wrap = true
        flexView.addSubview(tagList)
        
        for tagName in ["Bird", "Extinct", "Red", "Réunion", "Parrot", "Psittacinae"] {
            let tag = Tag(name: tagName)
            tag.flx_margins = FLXMargins(top: 0, left: 0, bottom: 4, right: 4)
            tagList.addSubview(tag)
        }
        
        flexView.addSubview(Separator())
        
        let friends = Label(text: "Friends:", align: .Left)
        friends.flx_margins = FLXMargins(top: 8, left: 8, bottom: 4, right: 8)
        flexView.addSubview(friends)
        
        let friendList = FLXView()
        friendList.childAlignment = .Start
        friendList.direction = .Row
        friendList.flx_margins = FLXMargins(top: 0, left: 8, bottom: 4, right: 4)
        friendList.wrap = true
        flexView.addSubview(friendList)
        
        for image in [ Bird1, Bird2, Bird3, Bird4, Bird5 ] {
            let avatar = Avatar(image: image)
            
            avatar.flx_margins = FLXMargins(top: 0, left: 0, bottom: 4, right: 4)
            avatar.flx_layoutStrategy = FLXLayoutStrategy.relative { size in
                let width = min((size.width / 4) - 4, 80)
                return CGSize(width: width, height: width)
            }
            
            friendList.addSubview(avatar)
        }
        
        let separator = Separator()
        flexView.addSubview(separator)
        
        scrollView.addSubview(flexView)
    }
    
    override func viewDidLayoutSubviews() {
        flexView.frame.size = flexView.sizeThatFits(CGSize(width: scrollView.bounds.width, height: CGFloat.max))
        
        scrollView.contentSize = flexView.bounds.size
    }

}

