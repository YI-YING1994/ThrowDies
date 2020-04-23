//
//  ViewController.swift
//  iCloudCheck
//
//  Created by user on 2018/7/16.
//  Copyright © 2018年 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 計算執行次數的變數
    var counter: Int!

    // 計算出現點數次數
    var dieCount = [0, 0, 0, 0, 0, 0]

    // 載入六個點數的圖
    var images = [UIImage(named: "one"), UIImage(named: "two"), UIImage(named: "three"),
                  UIImage(named: "four"), UIImage(named: "five"), UIImage(named: "six")]

    // Timer 物件
    var animateTimer: Timer!

    // 用來顯示分數的標籤
    @IBOutlet weak var scoreLabel: UILabel!

    // 顯示點數的物件
    @IBOutlet var dies: [UIImageView]!

    // 擲骰
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        scoreLabel.text = ""

        // 如有執行中的 Timer，將其停止
        if animateTimer != nil {
            animateTimer.invalidate()
        }

        counter = 0

        // 以 class function 產生 Timer 物件
        animateTimer =  Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) {
            [unowned self] (timer: Timer) in
            self.counter += 1
            if self.counter == 10 {
                timer.invalidate()

                // 計算點數
                var score = 0
                for i in 0...5 {
                    if self.dieCount[i] == 2 {
                        self.dieCount[i] -= 2

                        for j in 0...5 {
                            score += (j + 1) * self.dieCount[j]
                        }

                        self.scoreLabel.text = "\(score) 點"
                        return
                    }

                    if self.dieCount[i] == 4 {
                        self.scoreLabel.text = "豹子！"
                        return
                    }
                }

                self.scoreLabel.text = "請重擲"

                return
            }

            // 變更顯示的圖
            var randomNumber: Int
            for i in 0...5 { self.dieCount[i] = 0 }
            for die in self.dies {
                randomNumber = Int(arc4random() % 6)
                self.dieCount[randomNumber] += 1
                die.image = self.images[randomNumber]
            }
        }
    }
}

