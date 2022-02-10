//
//  LoggedOutViewController.swift
//  TicTacToe
//
//  Created by 60080252 on 2021/12/22.
//  Copyright © 2021 Uber. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol LoggedOutPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
	func login(withPlayer1Name player1Name: String?, player2Name: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
	// 의존성 역전의 원칙
	// VC가 interactor를 알고있으면 안됨 -> Listener라는 프로토콜 채택하여 VC가 interactor와 상관이 없는 독립적인 컴포넌트로 만들어주고 VC를 testable하게 해줌
	// Listener는 weak var로 만들어주어, 순환참조에 의한 메모리릭을 방지
	// unowned는 Listener가 없을 떄 앱이 죽을 수 있음(interactor가 메모리에서 사라졌을 때, VC에서 쓸모없는 작동이 일어나지 않도록 방지)
	// interactor의 생명주기 <= VC의 생명주기
    weak var listener: LoggedOutPresentableListener?

	private var player1Field: UITextField?
	private var player2Field: UITextField?

	private func buildPlayerFields() -> (player1Field: UITextField, player2Field: UITextField) {
		let player1Field = UITextField()
		self.player1Field = player1Field
		player1Field.borderStyle = UITextBorderStyle.line
		view.addSubview(player1Field)
		player1Field.placeholder = "Player 1 name"
		player1Field.snp.makeConstraints { (maker: ConstraintMaker) in
			maker.top.equalTo(self.view).offset(100)
			maker.leading.trailing.equalTo(self.view).inset(40)
			maker.height.equalTo(40)
		}

		let player2Field = UITextField()
		self.player2Field = player2Field
		player2Field.borderStyle = UITextBorderStyle.line
		view.addSubview(player2Field)
		player2Field.placeholder = "Player 2 name"
		player2Field.snp.makeConstraints { (maker: ConstraintMaker) in
			maker.top.equalTo(player1Field.snp.bottom).offset(20)
			maker.left.right.height.equalTo(player1Field)
		}
		return (player1Field, player2Field)
	}

	private func buildLoginButton(withPlayer1Field player1Field: UITextField, player2Field: UITextField) {
		let loginButton = UIButton()
		view.addSubview(loginButton)
		loginButton.snp.makeConstraints { (maker: ConstraintMaker) in
			maker.top.equalTo(player2Field.snp.bottom).offset(20)
			maker.left.right.height.equalTo(player1Field)
		}

		loginButton.setTitle("Login", for: .normal)
		loginButton.setTitleColor(UIColor.white, for: .normal)
		loginButton.backgroundColor = UIColor.black
		loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
	}

	@objc private func didTapLoginButton() {
		listener?.login(withPlayer1Name: player1Field?.text, player2Name: player2Field?.text)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view?.backgroundColor = UIColor.white
		let playerFields = buildPlayerFields()
		buildLoginButton(withPlayer1Field: playerFields.player1Field, player2Field: playerFields.player2Field)
	}
}

