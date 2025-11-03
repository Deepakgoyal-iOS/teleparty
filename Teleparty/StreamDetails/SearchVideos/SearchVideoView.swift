//
//  SearchVideoView.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import SwiftUI

struct SearchVideoView: View {
    
    @StateObject var viewModel = SearchVideoViewModel(refID: "atv_mv_hom_c_pcMEb7_brws_2_1")
    //0U8HKBVXT8N56BP89840L5IQXY - sample video id
    @State var videoID: String = ""
    @State var isDetailsPresented = false

    var body: some View {
        VStack {
            
            Image(uiImage: .primeVideoLogoSvg)
                .padding(.top, 100)
                .padding(.bottom, 50)
           
            
            HStack{
                TextField("Enter video ID", text: $videoID)
                    .padding(16)
            }
            .overlay(content: {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue)
                    .frame(height: 52)
            })
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue)
                    .opacity(viewModel.isLoading ? 0.5 : 1)
                
                Button(action: {
                    
                    viewModel.fetch(byID: videoID)
                    
                }, label: {
                    
                    HStack{
                        Text(viewModel.isLoading ? "Searching" : "Search")
                        
                        if viewModel.isLoading{
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                   
                })
                .allowsHitTesting(!viewModel.isLoading)
                .foregroundStyle(.white)

            }
            .frame(width: 150, height: 50)
            .padding(.top, 20)
            
            Spacer()
         
        }
        .padding()
        .fullScreenCover(isPresented: $viewModel.isFetched) {
            if let _detailsModel = viewModel.videoDetails{
                VideoDetailsView(detailModel: _detailsModel)
            }
        }
    }
}

#Preview {
    SearchVideoView()
}
