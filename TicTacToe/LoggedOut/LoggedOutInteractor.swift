//
//  LoggedOutInteractor.swift
//  TicTacToe
//
//  Created by 60080252 on 2021/12/22.
//  Copyright © 2021 Uber. All rights reserved.
//

import RIBs
import RxSwift

protocol LoggedOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoggedOutListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
	func didLogin(withPlayer1Name player1Name: String, player2Name: String)
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {
    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoggedOutPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

	// MARK: - LoggedOutPresentableListener
	func login(withPlayer1Name player1Name: String?, player2Name: String?) {
		let player1NameWithDefault = playerName(player1Name, withDefaultName: "Player 1")
		let player2NameWithDefault = playerName(player2Name, withDefaultName: "Player 2")

		print("\(player1NameWithDefault) vs \(player2NameWithDefault)")

		listener?.didLogin(withPlayer1Name: player1NameWithDefault, player2Name: player2NameWithDefault)
		// 자식RIB에서 부모 RIB호출 (자식 interactor -> 부모 interactor(자식의 listener) -> 부모 router)
	}

	private func playerName(_ name: String?, withDefaultName defaultName: String) -> String {
		if let name = name {
			return name.isEmpty ? defaultName : name
		} else {
			return defaultName
		}
	}
}
