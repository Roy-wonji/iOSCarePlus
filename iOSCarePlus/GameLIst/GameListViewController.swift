//
//  GameListViewController.swift
//  iOSCarePlus
//
//  Created by Kyunghun Kim on 2020/12/16.
//

import Alamofire
import UIKit

class GameListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var getNewGameListURL: String {
    //setter 없이 getter만 있으면 get {} 생략가능, return도 하나면 생략가능
            "https://ec.nintendo.com/api/KR/ko/search/new?count=\(newCount)&offset=\(newOffset)"
    }
    private var getSaleGameListURL: String {
        "https://ec.nintendo.com/api/KR/ko/search/sales?count=\(newCount)&offset=\(newOffset)"
    }
    
    @IBOutlet private weak var newButton: SelectableButton!
    @IBOutlet private weak var saleButton: SelectableButton!
    @IBOutlet private weak var selectedLineCenterConstraints: NSLayoutConstraint!
    @IBAction private func newButtonTouchUp(_ sender: Any) {
        newButton.isSelected = true
        saleButton.isSelected = false
        
        UIView.animate(withDuration: 0.1) {[weak self] in
            self?.selectedLineCenterConstraints.constant = 0
            self?.view.layoutIfNeeded()
        }
        model?.contents.removeAll()
        newOffset = 0
        gameListApiCall(getNewGameListURL)
        //        selectedLineCenterConstraints.constant = 0
    }
    @IBAction private func saleButtonTouchUp(_ sender: Any) {
        newButton.isSelected = false
        saleButton.isSelected = true
        
        let constant: CGFloat = saleButton.center.x - newButton.center.x
        
        UIView.animate(withDuration: 0.1) {[weak self] in
            self?.selectedLineCenterConstraints.constant = constant
            self?.view.layoutIfNeeded()
    }
        model?.contents.removeAll()
        newOffset = 0
        gameListApiCall(getSaleGameListURL)
    }
    private var newCount: Int = 10
    private var newOffset: Int = 0
    private var isEnd: Bool = false
    //    let getGamePriceURL = "https://api.ec.nintendo.com/v1/price"
    var model: NewGameResponse? {
        didSet {
            tableView.reloadData() //세팅될떄마다 새로 업로드
        }
    }
    private func isIndicatorCell(_ indexPath: IndexPath) -> Bool {
        indexPath.row == model?.contents.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//
//        tableView.register(GameItemCodeTableViewCell.self, forCellReuseIdentifier: "GameItemCodeTableViewCell")
        gameListApiCall(getNewGameListURL)
    }
    
    private func gameListApiCall(_ url: String) {
        AF.request(url).responseJSON {[weak self] response in
            guard let data = response.data else { return }
            let decoder: JSONDecoder = JSONDecoder()
            guard let newModel: NewGameResponse = try? decoder.decode(NewGameResponse.self, from: data) else {
                return
            }

            //            for content in model?.contents {
            //                getGamePriceApiCall(id: content.id)
            //            }
            if self?.model == nil {
                self?.model = newModel
            } else {
                if newModel.contents.isEmpty { //끝부분 가면 버퍼링 돌아갈 필요없이 끝나는 것을 표시해야 한다
                    self?.isEnd = true
                }
                self?.model?.contents.append(contentsOf: newModel.contents) //무한스크롤할 때 새 가져오는 값을 추가해야한다. 덮어씌기아니라!
            }
        }
    }
}

extension GameListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pageViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailPageViewController") as? GameDetailPageViewController else { return }
        pageViewController.model = model?.contents[indexPath.row]
        navigationController?.pushViewController(pageViewController, animated: true)
    }
}

extension GameListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //호출 할때 한번 호출, 그리고 셀이 그려질 때 호출된다 
        if isEnd {
            return (model?.contents.count ?? 0)
        } else {
            if model == nil {
                return 0
            }
        }
        return (model?.contents.count ?? 0) + 1 //10개의 데이터가 있는데 11개를 그려준다. 11개의 셀에 대한 처리가 필요하다
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isIndicatorCell(indexPath) {
            newOffset += 10
            gameListApiCall(getSaleGameListURL)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "GameItemCodeTableViewCell", for: indexPath)
//        return cell
        //마지막 셀일 때 위의 것을 호출한다
        if isIndicatorCell(indexPath) {
            newOffset += 10 //10번쨰부터 10개를 새로 더 호출한다
            gameListApiCall(getNewGameListURL)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IndicatorCell", for: indexPath) as? IndicatorCell else { return
                UITableViewCell() }
                cell.animationIndicatorView()
        
                return cell
             //마지막 셀은 데이터가 없으므로 빈셀을 리턴한다;
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameItemTableViewCell", for: indexPath) as? GameItemTableViewCell, let  content = model?.contents[indexPath.row] else { return UITableViewCell() }
        //스토리보드에 등록된 셀을 가져오는 것. 테이블뷰에 이미 등록되어 있는데 이를 가져오는 방법은 dequeReusableCell을 통해 가져온다

        let model: GameItemModel = GameItemModel(gameTitle: content.formalName, gameOriginPrice: 10_000, gameDiscountPrice: nil, imageURL: content.heroBannerURL, screenshots: content.screenshots)
        cell.setModel(model)
        return cell
    }
}
