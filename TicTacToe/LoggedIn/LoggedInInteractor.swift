//
//  LoggedInInteractor.swift
//  TicTacToe
//
//  Created by 60080252 on 2021/12/22.
//  Copyright © 2021 Uber. All rights reserved.
//

import RIBs
import RxSwift

protocol LoggedInRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
	func routeToTicTacToe()
	func routeToOffGame()
}

protocol LoggedInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor,
                                LoggedInInteractable,
                                LoggedInActionableItem {

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

	private let mutableScoreStream: MutableScoreStream

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
	init(mutableScoreStream: MutableScoreStream) {
		self.mutableScoreStream = mutableScoreStream
	}

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }

	// MARK: - LoggedInInteractor
	func startTicTacToe() {
		router?.routeToTicTacToe()
	}

// MARK: - TicTacToeListener
	func gameDidEnd(with winner: PlayerType?) {
		if let winner = winner {
            mutableScoreStream.updateScore(with: winner)
		}
		router?.routeToOffGame()
	}
}

// MARK: - LoginActionableItem

extension LoggedInInteractor {
    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, ())> {
        return Observable.just((self, ()))
    }
}
