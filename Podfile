platform :ios, '9.0'

use_frameworks!
inhibit_all_warnings!

def common_pods
  pod 'RIBs', :git=> 'https://github.com/uber/RIBs'
  pod 'RxSwift'
  pod 'RxRelay'
  pod 'SnapKit', '~> 4.0.0'
  pod 'RxCocoa', '~> 6.0'
end

target 'TicTacToe' do
  common_pods
end

target 'TicTacToeTests' do
  common_pods
end
