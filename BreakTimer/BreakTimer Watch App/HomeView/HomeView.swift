//
//  HomeView.swift
//  BreakTimer Watch App
//
//  Created by Park Sungmin on 2022/11/06.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 2) {
            Button {
                print("hello")
            } label: {
                Spacer()
                Image(systemName: "gearshape")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 24, height: 24)
                    .cornerRadius(40)
            }
            .buttonStyle(.borderless)
            
            ZStack {
                // background
                Circle()
                    .foregroundColor(.blue)
                
                // time gauge
                Circle()
                    .stroke(
                        Color.gray,
                        lineWidth: 4
                    )
                Circle()
                    .trim(from: 0, to: 0.25)
                    .stroke(
                        Color.white,
                        // 1
                        style: StrokeStyle(
                            lineWidth: 4,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                
                // shadow
                Rectangle()
                    .frame(width: 75, height: 100)
                    .rotationEffect(.degrees(30))
                    .offset(x: -25, y: 43.3)
                    .foregroundColor(.black.opacity(0.4))
                
                // button background
                Circle()
                    .foregroundColor(.black)
                    .frame(width: 75, height: 75)
                
                // button
                Button {
                    print("pp")
                } label: {
                    ZStack{
                        Circle()
                            .foregroundColor(.red)
                        Text("00:00")
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .medium))
                    }
                }
                .frame(width: 75, height: 75)
                .buttonStyle(.borderless)
            }
        }
        .padding(.horizontal, 0)
        .padding(.vertical, 0)
        .navigationTitle("BreakTimer")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
