//
//  DetailViewController.swift
//  TomorrowNews
//
//  Created by paprika on 2017/8/22.
//  Copyright © 2017年 paprika. All rights reserved.
//

import UIKit
import WebKit
import LeoDanmakuKit
import LLSwitch
class DetailViewController: UIViewController {

    @IBOutlet weak var switchBtn: LLSwitch!

    @IBOutlet weak var danmuView: LeoDanmakuView!

    fileprivate var webView = WKWebView()
    
    var post : Post!
    
    var isDanmuOn = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadHtml()
        
        loadDanmu(comments: post.comments)
        
        switchBtn.delegate = self
    }
    
}
//MARK:弹幕布局
extension DetailViewController {
    func loadDanmu(comments: [Comment]? = nil, postAComment: String? = nil)  {
        
        if isDanmuOn {
            danmuView.resume()
            
            if let comments = comments {
                let danmus : [LeoDanmakuModel] = comments.map{
                    let model = LeoDanmakuModel.randomDanmku(withColors: UIColor.danmu, maxFontSize: 30, minFontSize: 15)
                    model?.text = $0.content.html2String
                    return model!
                }
                
                danmuView.addDanmaku(with: danmus)
            }
            
            if let comment = postAComment {
                let model = LeoDanmakuModel.randomDanmku(withColors: UIColor.danmu, maxFontSize: 30, minFontSize: 15)
                model?.text = comment
                danmuView.addDanmaku(model)
            }
        } else {
            danmuView.stop()
        }
    }
}
//MARK:HTML页面布局
extension DetailViewController{
    func loadHtml()  {
        
        webView = WKWebView(frame: CGRect(x: 0, y: 64, width:view.frame.width, height: view.frame.height-70))
        webView.scrollView.bounces = false
        view.insertSubview(webView, at: 0)
        //loadrequest能把网页所有的元素都加载过来,而loadhtml(content)却很不适配移动端,还要美化
        //webView.load(URLRequest(url: URL(string: url)!))
        
        var header = "<html>"
        header += "<head>"
        //<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
        header += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
        
        //<style type="text/css">
        //        body {background-color: red}
        //        p {margin-left: 20px}
        //        </style>
        
        header += "<style>"
        header += " img { width: 100% } body { font-size: 100%; } "
        header += "</style>"
        
        //把本地的scrollsmoothly.js存到服务器,从服务器拿到文件的URL
        header += "<script src=\"http://localhost:8888/wordpress/wp-content/uploads/2017/08/scrollsmoothly.js\"></script>"
        
        header += "</head>"
        header += "<body>"
        //跳到这根线上
        let comment = "<p><h3>评论</h3></p> <hr id=\"commentAnchor\">" + commentHtml(comments: post.comments)
        
        var footer =  "</body>"
        footer += "</html>"
        
        
        webView.loadHTMLString(header + post.content + comment + footer, baseURL: nil)
        
        
    }
    //添加底部评论区段落
    func commentHtml(comments: [Comment]) -> String {
        var result = ""
        
        for comment in comments {
            let paragraph = "<p> <h6>\(comment.name!)</h6> <h4>\(comment.content!)</h4> <hr size=1>  </p>"
            result += paragraph
        }
        
        return result
    }
}
//MARK:输入框代理
extension DetailViewController{
    @IBAction func textfieldEditBegin(_ sender: Any) {
        switchBtn.isHidden = true
    }
    
    @IBAction func textfieldEditEnd(_ sender: UITextField) {
        switchBtn.isHidden = false
        guard let comment = sender.text else {
            return
        }
        loadDanmu(postAComment: comment)
        Post.submitComment(postId: post.id, name: "pap", email: "sdf@sd.com", content: comment) { (finish) in
            if finish {
                print("评论成功")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: UpdateListNotification), object: nil)
            }
            sender.text = ""
        }
    }

}
//MARK:平滑滚动JS
extension DetailViewController{
    func doJS(){
        // let js1 = "$(\"p\").hide()"//隐藏点击的段落jQuery
        //js2速度太快,需要js3平滑滚动
        //let js2 = "window.location.hash = \"commentAnchor\""
        let js3 = "ScrollToControl(\'commentAnchor\')"
        webView.evaluateJavaScript(js3, completionHandler: nil)
    }
    
    @IBAction func commentBtn(_ sender: UIButton) {
        
        doJS()
    }

}
//MARK:弹幕开关代理
extension DetailViewController:LLSwitchDelegate{
    func didTap(_ llSwitch: LLSwitch!) {
        if isDanmuOn {
            switchBtn.setOn(false, animated: true)
            danmuView.stop()
            danmuView.isHidden = true
        }else{
            danmuView.resume()
            switchBtn.setOn(true, animated: true)
            danmuView.isHidden = false
        }
        isDanmuOn = !isDanmuOn
    }
}

//MARK:弹幕颜色扩展
extension UIColor{
    static var danmu: [UIColor] {
        return [UIColor.blue, UIColor.brown, UIColor.black, UIColor.darkGray, UIColor.purple]
    }
}
//mark:弹幕字体优化扩展
extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch  {
            print(error)
            return nil
        }
    }
    
    var html2String:String {
        return html2AttributedString?.string ?? ""
    }
}
