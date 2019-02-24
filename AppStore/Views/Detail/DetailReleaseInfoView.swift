//
//  DetailReleaseInfoView.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

class DetailReleaseInfoView: UIView {
    @IBOutlet var versionLabel             : UILabel?
    @IBOutlet var releaseDateLabel         : UILabel?
    @IBOutlet var releaseNoteLabel         : UILabel?
    @IBOutlet var moreWrapView             : UIView?
    
    func configure(_ data: SoftwareModel) {
        self.versionLabel?.text             = "버전 \(data.version)"
        self.configureReleaseNote(data)
        self.configureReleaseDate(data)
    }
    
    func configureReleaseNote(_ data: SoftwareModel) {
        guard let releaseNoteLabel = self.releaseNoteLabel else { return }
        releaseNoteLabel.text = data.releaseNotes
        releaseNoteLabel.numberOfLines = 3
        
        self.moreWrapView?.isHidden = releaseNoteLabel.countLines <= 3
    }
    
    func configureReleaseDate(_ data: SoftwareModel) {
        guard let releaseDateLabel = self.releaseDateLabel else { return }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let displayString = formatter.date(from: data.currentVersionReleaseDate)?.displayStringFromToday
        releaseDateLabel.text = displayString
    }
    
    @IBAction func actionTouchUpInsideMore(_ sender: Any?) {
        self.moreWrapView?.isHidden = true
        self.releaseNoteLabel?.numberOfLines = 0
    }
}
