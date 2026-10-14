//
//  ChannellIteemView.swift
//  WhatsApp
//
//  Created by Apple on 13/10/2026.
//



 struct ChannellItemView:View{
    let index: Int
    
    var body: some View{
        HStack(alignment: .top) {
            Circle()
                .frame(width: 45,height: 45)
            
            VStack(alignment: .leading) {
                headerTextView()
                
                Text("Voice Message")
                    .font(.callout)
                    .bold()
                    .foregroundStyle(.gray)
                    .lineLimit(2)
               
            }
        }
    }
    
    
    private func headerTextView()->some View{
        
        HStack {
            Text("Qatester \(index)")
                .bold()
                .font(.title2)
                .lineLimit(1)
            Spacer()
            
            Text("5:50PM")
                .font(.callout)
                .bold()
                .foregroundStyle(.gray)
        }
        
    }
}
