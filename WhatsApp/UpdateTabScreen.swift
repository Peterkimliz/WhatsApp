//
//  UpdateTabScreen.swift
//  WhatsApp
//
//  Created by Apple on 06/10/2026.
//

import SwiftUI

struct UpdateTabScreen: View {
    @State private var searchString:String = ""
    var body: some View {
        NavigationStack{
            List {
                Text("Status")
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .font(.callout)
                     .bold()
                   .foregroundStyle(.whatsAppBlack)

                    StatusHeaderView()
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        
                
                StatusSection()
                
                Section {
                    StatusView()
                } header: {
                    Text("Recent Updates")
                }
                
                
                Section {
                    
                }header: {
                    HStack {
                        Text("Channels")
                            .bold()
                            .foregroundStyle(.whatsAppBlack)
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .padding(10)
                                .background(Color(.systemGray5))
                                .clipShape(Circle())
                        }

                    }
                }
                
                
                
            }.navigationTitle("Updates")
            .listStyle(.grouped)
            
            .searchable(text: $searchString)
            
        }
    }
}


private struct StatusHeaderView : View {
    var body: some View {
        HStack (alignment: .top){
            Image(systemName: "circle.dashed")
                .foregroundStyle(.blue)
            
            VStack(alignment: .leading){
               Text("Use status to share photos,text and videos that disappear in 24 hours.")
                Text("Status Privacy")
                    .font(.callout)
                    .bold()
                    .foregroundStyle(.blue)
                
            }
            
            
            Image(systemName: "xmark")
                .foregroundStyle(.gray)
            
        }.padding()
        .background(.whatsAppWhite)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    
        
       
    }
}

private struct StatusView : View {
    var body: some View {
        HStack {
                Circle()
                    .frame(width: 55,height: 55)
                
                VStack (alignment: .leading){
                    Text("John Does")
                        .font(.callout)
                        .bold()
                    
                    Text("1hr ago")
                        .font(.system(size: 15))
                        .foregroundStyle(.gray)
                }

                
            }

    }
}




private struct StatusSection: View{
    
    var body: some View{
        HStack {
            Circle()
                .frame(width: 55,height: 55)
            
            VStack (alignment: .leading){
                Text("John Does")
                    .font(.callout)
                    .bold()
                
                Text("Add to my status")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            cameraButton()
            pencilButton()
            
            
        }
    
    }
    
    
    fileprivate  func cameraButton()->some View{
        Button {
            
        } label: {
            Image(systemName: "camera.fill")
                .padding(10)
                .background(Color(.systemGray5))
                .clipShape(Circle())
        }

        
    }
    
    private func pencilButton()->some View{
        Button {
            
        } label: {
            Image(systemName: "applepencil")
                .padding(10)
                .background(Color(.systemGray5))
                .clipShape(Circle())
        }

        
    }
}








#Preview {
    UpdateTabScreen()
}
