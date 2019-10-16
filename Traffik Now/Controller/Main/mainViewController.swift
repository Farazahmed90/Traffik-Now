//
//  mainViewController.swift
//  Traffik Now

//  Copyright © 1398 www.d-tech.com. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SafariServices
class mainViewController: ButtonBarPagerTabStripViewController
{
    
    
    @IBAction func google_map(_ sender: Any) {
        showSafari(url: "https://www.google.com/maps/dir///@24.8331935,67.119375,14z/data=!4m2!4m1!3e0")
    }
    func showSafari(url: String) {
        guard let url = URL(string: url)
        else
        {
            return
        }
        let safariview = SFSafariViewController(url: url)
        present(safariview,animated: true)
    }
    
    override func viewDidLoad()
    {
        settings.style.buttonBarBackgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        settings.style.buttonBarItemBackgroundColor = UIColor.clear
        settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 13)
        settings.style.selectedBarHeight = 6.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        }
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]
    {
        let social = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "social")
        let news = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "news")
        let update = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "update")
        let more = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "more")
        return [social,news,update,more]
    }
    
    
    @IBAction func postButton_Clicked(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "goToPost", sender: self)        
    }
    
    
    
    
}

