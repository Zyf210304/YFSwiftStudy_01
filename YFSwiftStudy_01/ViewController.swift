//
//  ViewController.swift
//  YFSwiftStudy_01
//
//  Created by 亚飞 on 2018/4/24.
//  Copyright © 2018年 yafei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

/*
timer = nil 报错  
暂时没找到合适的方法释放timer 或者invalidate() 就能释放
*/

    var playBtn : UIButton!
    var pauseBtn: UIButton!
    var reset : UIButton!
    var timeLabel : UILabel!

    var count = 0.0
    var timer = Timer()
    var isPlay = false

    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        timeLabel.text = String(count);
        self.initUI()
        self.addAction()
    }

    func initUI() {
        let kScreenW = self.view.frame.size.width
        let kScreenH = self.view.frame.size.height

        playBtn = UIButton(type:.custom)
        playBtn.frame = CGRect(x:0, y:kScreenH / 2, width:kScreenW / 2, height:kScreenH / 2)
        self.view.addSubview(playBtn)
        playBtn.backgroundColor = UIColor.blue;
        playBtn.setImage(UIImage(named:"play") , for:.normal)

        pauseBtn = UIButton(type:.custom)
        pauseBtn.frame = CGRect(x:kScreenW / 2, y:kScreenH / 2, width:kScreenW / 2, height:kScreenH / 2)
        self.view.addSubview(pauseBtn)
        pauseBtn.backgroundColor = UIColor.green;
        pauseBtn.setImage(UIImage(named:"pause") , for:.normal)

        timeLabel = UILabel(frame:CGRect(x:0, y:0, width:kScreenW, height:kScreenH / 2))
        timeLabel.text = String(count)
        timeLabel.textColor = UIColor.white
        timeLabel.textAlignment = .center
        timeLabel.backgroundColor = UIColor.lightGray
        timeLabel.font = UIFont.systemFont(ofSize: 150)
        self.view.addSubview(timeLabel)

        reset = UIButton(type:.custom)
        reset.frame = CGRect(x: kScreenW / 10 * 7, y : 60, width: kScreenW / 4, height:40)
        reset.setTitle("Reset", for: .normal)
        reset.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        reset.titleLabel?.textAlignment = .left
        self.view.addSubview(reset)
        reset.addTarget(self, action: #selector(ViewController.resetCount), for: .touchUpInside)
    }

    func addAction() {
        playBtn.addTarget(self, action:#selector(going), for:.touchUpInside)

        pauseBtn.addTarget(self, action:#selector(pause), for: .touchUpInside)

        reset.addTarget(self, action: #selector(ViewController.resetCount), for: .touchUpInside)
    }

    @objc func going() {
        if isPlay {
            return
        }
        playBtn.isEnabled = false
        pauseBtn.isEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.run), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
        isPlay = true
    }

    @objc func pause() {
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
        timer.invalidate()
        isPlay = false
    }

    @objc func run() {
        count += 0.1
        timeLabel.text = String(format:"%.1lf", count)
    }

    @objc func resetCount() {
        isPlay = false
        count = 0.0;
        timeLabel.text = String(count)
        timer.invalidate()
        playBtn.isEnabled = true
        pauseBtn.isEnabled = true

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
















