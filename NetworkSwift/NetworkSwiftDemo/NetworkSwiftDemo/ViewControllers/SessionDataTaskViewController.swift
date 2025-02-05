//
//  SessionDataTaskViewController.swift
//  NetworkSwiftDemo
//
//  Created by 韩俊强 on 2017/8/30.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import Foundation

class SessionDataTaskViewController: UIViewController, URLSessionDataDelegate {

    var data:NSMutableData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "其他参考Alamofire,这里只讲代理方法"
        
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.setTitle("请求", for: UIControl.State.normal)
        btn.backgroundColor = UIColor.green
        btn.setTitleColor(UIColor.red, for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(starRequest), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)
        
    }
    
    // MARK: - 代理
    @objc func starRequest() {
        // URL
        let url = URL(string:"https://www.baidu.com")!
        
        // URLRquest
        let request = URLRequest(url: url)
        
        // 会话对象,并设置代理
        /*
         第一个参数：会话对象的配置信息 defaultSessionConfiguration 表示默认配置
         第二个参数：谁成为代理，此处为控制器本身即self, 协议 NSURLSessionDelegate
         第三个参数：队列，该队列决定代理方法在哪个线程中调用,可以传主队列|非主队列
         [NSOperationQueue mainQueue]   主队列：   代理方法在主线程中调用
         [[NSOperationQueue alloc]init] 非主队列： 代理方法在子线程中调用
         */
        let session:Foundation.URLSession = Foundation.URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        
        let dataTask = session.dataTask(with: request)
        
        dataTask.resume()
    }
    
    // MARK: - 接收到服务器响应的时候调用该方法
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        // 响应头信息，即response
        print("didReceiveResponse--%@", response)
        
        // 注意：需要使用completionHandler回调告诉系统应该如何处理服务器返回的数据
        // 默认是取消的
        /*
         NSURLSessionResponseCancel = 0,        默认的处理方式，取消
         NSURLSessionResponseAllow = 1,         接收服务器返回的数据
         NSURLSessionResponseBecomeDownload = 2,变成一个下载请求
         NSURLSessionResponseBecomeStream        变成一个流
         */
        completionHandler(Foundation.URLSession.ResponseDisposition.allow)
    }
    
    // MARK: - 接收到服务器返回数据的时候会调用该方法, 如果数据较大那么该方法可能会调用多次
    func urlSession(_ session: Foundation.URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        print("didReceiveData--%@", data)
        // 拼接服务器返回的数据
        if self.data == nil {
            self.data = NSMutableData()
        }
        self.data.append(data)
    }
    
    // 当请求完成(成功|失败)的时候会调用该方法，如果请求失败，则error有值
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if (error == nil)
        {
            var dict:NSDictionary? = nil
            do {
                dict = try JSONSerialization.jsonObject(with: self.data! as Data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? NSDictionary
                DispatchQueue.main.async(execute:{ () -> Void in
                    let msg:String = dict!.object(forKey: "msg") as! String
                    let alertVC = UIAlertController(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
                    alertVC.addAction(action)
                    self.present(alertVC, animated: true, completion: nil)
                })
            } catch {
                print("不是字典")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
