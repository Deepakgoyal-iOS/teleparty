//
//  SearchVideoViewModel.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

class SearchVideoViewModel: ObservableObject{
    
    private var detailsAPIRepository: APIRepositoryProtocol?
    private var refID: String
    @Published var isLoading: Bool = false
    @Published var isFetched: Bool = false
    private(set) var videoDetails: PrimeVideoDetailsModel?
    
    init(refID: String) {
        self.refID = refID
    }
    
    /// Use `Factory` pattern for multiple streaming platforms like Prime, Netflix, etc.
    func fetch(byID id: String){
        
        isFetched = false
        isLoading = true
        detailsAPIRepository = PrimeVideoDetailsAPIRepository(id: id, ref: refID, query: .init(clientVersion: "1.0.113997.0"))
        detailsAPIRepository?.performAPI{ [weak self] response in
            
            switch response {
            case .success(let json):
                
                self?.getDetailsJson(from: json)?.toModel(modelType: PrimeVideoDetailsModel.self, state: { [weak self] inProgress in
                    self?.isLoading = inProgress
                }, { [weak self] model in
                    self?.videoDetails = model
                    self?.isFetched = true
                })
                
                break
            case .failure(let aPIError):
                self?.isLoading = false
                debugPrint(aPIError.message as Any)
                break
            case nil:
                self?.isLoading = false
                break
            }
        }
    }
    
    private func getDetailsJson(from json: JSONItem) -> JSONItem?{
        
        // However this is not the right way to decode we should use data models ideally
        let body = (((json["page"] as? [Any])?.first as? JSONItem)?["assembly"] as? JSONItem)?["body"] as? [Any]
        let props = (body?.first as? JSONItem)?["props"] as? [String: Any]
        let state = (props?["btf"] as? JSONItem)?["state"] as? JSONItem
        let page = (state?["pageTitleId"] as? String) ?? ""
        return ((state?["detail"] as? JSONItem)?["detail"] as? JSONItem)?[page] as? JSONItem
    }
    
}

