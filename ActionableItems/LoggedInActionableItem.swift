//
//  LoggedInActionableItem.swift
//  TicTacToe
//
//  Created by SEUNGHA on 2022/02/10.
//  Copyright © 2022 Uber. All rights reserved.
//

import RxSwift

public protocol LoggedInActionableItem: AnyObject {
    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, ())>
}

