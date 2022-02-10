//
//  LoggedInBuilder.swift
//  TicTacToe
//
//  Created by 60080252 on 2021/12/22.
//  Copyright © 2021 Uber. All rights reserved.
//

import RIBs

protocol LoggedInDependency: Dependency {
	// Dependency에 정의 => Static Dependencies
	// 아예 의존성으로 들고있음 => LoggedInDependency를 채택하는 RootComponent에서도 플레이어의 이름을 가지고있어야함
	// RootComponent를 생성할때는 아직 이름이 결정되기 전임;
	// 그래 그러면 Optional로 처리하자! => (불필요한 Optional 처리 해줘야하는 상황 발생!)
	// 동적의존성을 적절히 사용하여 효율적으로 처리를 하자!
//	var player1Name: String { get }
//	var player2Name: String { get }



    // TODO: Make sure to convert the variable into lower-camelcase.
    var loggedInViewController: LoggedInViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class LoggedInComponent: Component<LoggedInDependency>, OffGameDependency, TicTacToeDependency {
	// TODO: Declare 'fileprivate' dependencies that are only used by this RIB.

	// LoggedInComponent라는 구체적인 객체 클래스에 정의(Dependency에는 정의X) => Dynamic Dependencies
	let player1Name: String
	let player2Name: String

	// LoggedInComponent
	var mutableScoreStream: MutableScoreStream {
		return shared { ScoreStreamImpl() }
	}

	// OffGameDependency
	var scoreStream: ScoreStream {
		return mutableScoreStream
	}

	init(dependency: LoggedInDependency,
				  player1Name: String,
				  player2Name: String) {
		self.player1Name = player1Name
		self.player2Name = player2Name
		super.init(dependency: dependency)
	}

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var loggedInViewController: LoggedInViewControllable {
        return dependency.loggedInViewController
    }
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener,
			   player1Name: String,
			   player2Name: String) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener,
			   player1Name: String,
			   player2Name: String) -> LoggedInRouting {

		// LoggedInDependency의 구현체인 component에 넘겨줘야함
        let component = LoggedInComponent(dependency: dependency,
										  player1Name: player1Name,
										  player2Name: player2Name)
		let interactor = LoggedInInteractor(mutableScoreStream: component.mutableScoreStream)
        interactor.listener = listener

		let offGameBuilder = OffGameBuilder(dependency: component)
		let tictactoeBuilder = TicTacToeBuilder(dependency: component)

		return LoggedInRouter(interactor: interactor,
							  viewController: component.loggedInViewController,
							  offGameBuilder: offGameBuilder,
							  tictactoeBuilder: tictactoeBuilder)
    }
}
