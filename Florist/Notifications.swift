//
//  Notifications.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var changeCategoryId = Notification.Name("changeCategoryId")
    static var deleteItem = Notification.Name("deleteItem")
    static var addItem = Notification.Name("addItem")
    static var itemCount = Notification.Name("itemCount")
}
