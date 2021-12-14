//
//  ICDataService.swift
//  iCoin
//
//  Created by Lingeswaran Kandasamy on 12/14/21.
//

import Foundation
import Combine


class ICDataService {
    
    @Published var coins: [ICModel] = []
    
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoinsData()
    }
    
    func getCoinsData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = ICNetworkManager.getData(url: url)
            .decode(type: [ICModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: ICNetworkManager.completionHandler,receiveValue: {[weak self](returnedCoins) in
                self?.coins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
    
}
