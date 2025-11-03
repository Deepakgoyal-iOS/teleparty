//
//  VideoDetailsView.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import SwiftUI

struct VideoDetailsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var detailModel: PrimeVideoDetailsModel
    
    var body: some View {
        
        VStack(spacing: 0){
            
            ScrollView(.vertical){
                
                VStack(spacing: 0) {
                   
                    AsyncImage(url: URL(string: detailModel.images?.covershot ??  ""), content: { image in
                        image.resizable()
                    }) {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, idealHeight: UIScreen.main.bounds.height * 0.4)
                    .padding(0)
                    .padding(.top, 0)
                    .background(Color.white.opacity(0.5))
                
                    
                    VStack(spacing: 0){
                        
                        
                        Text(detailModel.title ?? "No Movie Name Found")
                            .font(.system(size: 24, weight: .semibold, design: .monospaced))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            
                        Text("Run time : \(detailModel.runtime ?? "No runtime found")")
                            .font(.system(size: 14, weight: .semibold, design: .monospaced))
                            .foregroundStyle(.white.opacity(0.5))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
                        
                        Divider()
                            .background(Color.white)
                            .padding(16)
                        
                        Text(detailModel.synopsis ?? "No description found")
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
                       
                        Text("Released on \(detailModel.releaseDate ?? "No release date found")")
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundStyle(.white.opacity(0.5))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(0)
                }
                
               
            }
            .frame(maxHeight: .infinity)
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue)
                
                Button(action: {
                    dismiss()
                }, label: {
                    
                    HStack{
                        Text("Close")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                })
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: 52)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        }
        .background(Color.black)
       
        
    }
}

#Preview {
    VideoDetailsView(detailModel: .init())
}
