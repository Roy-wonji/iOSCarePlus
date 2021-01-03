//
//  GameItemCodeTableViewCell.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2020/12/23.
//

import UIKit

class GameItemCodeTableViewCell: UITableViewCell {
    var gameImageView: UIImageView
    var titleLabel: UILabel
    var priceLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        gameImageView = UIImageView()
        titleLabel = UILabel()
        priceLabel = UILabel()
        super.init(style: .default, reuseIdentifier: "GameItemCodeTableViewCell")
        contentView.addSubview(gameImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        //상위 뷰 생성함 -> 오토레이아웃 가능해진다
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        //자동으로 제약조건을 만드는 것을 꺼줘야한다. 자동으로 오토레이아웃 만드는 것을 방지해야한다
        NSLayoutConstraint.activate([
            //Anchor 사용하여 오토레이아웃 만든다. 위에는 상대적으로 상위 뷰를 기준으로 맞추므로 다른 파마티러를 가진다
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            //상위 뷰와 동일시 해야한다 + 활성화시켜야한다. 활성화 시키지 않으면 제약조건은 있지만 되지않는다 -> 오른쪽제약조건.. 활성화시키는 것을 선언 후 배열로 해서 전체 적용 가능하다
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            // 왼쪽 제약조건,, 20만큼 떨어트리겠다는 의미
            gameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            gameImageView.widthAnchor.constraint(equalToConstant: 122), // 자기 기준에 대해서 오토레이아웃을 걸기떄문에 파라미터가 다르다
            gameImageView.heightAnchor.constraint(equalToConstant: 69)])
            gameImageView.backgroundColor = .red
        //gameImageView에서 5만큼 낮게 만들어 준 것이고 그 사이의 여백은 12가 되게 한 것이다
        NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: 5),
        titleLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 12),
        titleLabel.trailingAnchor
                  .constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 15)
        //오른쪽 여백이 15는 최소로 남기겠다!
        ])
        titleLabel.text = "test"
        }
required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

