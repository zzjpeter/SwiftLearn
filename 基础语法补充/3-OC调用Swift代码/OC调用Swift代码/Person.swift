//
//  Person.swift
//  OC调用Swift代码
//
//  Created by 朱志佳 on 2024/3/4.
//

import Foundation


@objc public class Person: NSObject {
    @objc var name: String

    @objc init(name: String) {
        self.name = name
    }

    @objc func greet() {
        print("Hello, my name is \(name).")
    }
}
