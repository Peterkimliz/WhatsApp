//
//  CommunitesTabScreen.swift
//  WhatsApp
//
//  Created by Apple on 07/10/2026.
//

import SwiftUI

struct CommunitesTabScreen: View {
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading,spacing: 10) {
                    Image(.communities)
                    
                    Group {
                        Text("Stay connected with a community")
                            .font(.title2)
                            .bold()
                        
                        Text("Communities bring members together in topic-based groups. Any community you are added to will appear here. ")
                            .foregroundStyle(.gray)
                            .font(.callout)
                
                        
                        
                    }.padding(.horizontal,5)
                    
                    
                    Button {
                        
                    } label: {
                        Text("See example communities >")
                            .frame(maxWidth: .infinity,alignment: .center)
                            .bold()
                    }
                
                    
                    Button {
                        
                    } label: {
                        Label("New Community", systemImage: "plus")
                            .frame(maxWidth: .infinity,alignment: .center)
                            .bold()
                            .padding(10)
                    
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    
                    
                }.navigationTitle("Communites")
                .padding()
            }
        }
    }
}

#Preview {
    CommunitesTabScreen()
}
