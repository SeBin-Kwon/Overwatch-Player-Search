//
//  ContentView.swift
//  OverwatchAPI
//
//  Created by Sebin Kwon on 11/15/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: Network
    @State private var playerId = ""
    @State private var isSearch = false
    var body: some View {
        VStack {
            HStack {
                Image("Overwatch2Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .padding(.trailing, 5)
                Text("플레이어 검색")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.vertical)
            HStack {
                TextField("닉네임#배틀태그", text: $playerId)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color(uiColor: .secondarySystemBackground))
                    }
                    .overlay(alignment: .trailing) {
                        Image(systemName: "magnifyingglass")
                            .padding(.trailing)
                            .foregroundStyle(Color(uiColor: .lightGray))
                    }
                Button {
                    let replaceStr = playerId.replacingOccurrences(of: "#", with: "-")
                    network.getPlayer(playerId: replaceStr)
                    hideKeyboard()
                    isSearch = true
                } label: {
                    Text("검색")
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.vertical)
                        .frame(maxWidth: 70)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(.blue)
                        }
                }
            }
            .padding(.bottom, 10)
            Text("ex) 맨들맨들매운맨두#3391 / 초롱초롱해#31867")
                .font(.caption)
                .foregroundStyle(.gray)
            .padding(.bottom, 60)
            if isSearch {
                VStack {
                    AsyncImage(url: URL(string: network.player?.avatar ?? "")) { image in
                        image
                            .clipped()
                            .cornerRadius(10)
                    } placeholder: {
                        Image(systemName: "clock.arrow.circlepath")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30)
                            .foregroundColor(Color(uiColor: .lightGray))
                    }
                    .padding(.bottom, 8)
                    ZStack(alignment: .leading) {
                        AsyncImage(url: URL(string: network.player?.namecard ?? ""), scale: 5) { image in
                            image
                                .clipped()
                                .cornerRadius(10)
                        } placeholder: {
                            Image(systemName: "clock.arrow.circlepath")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 50)
                                .foregroundColor(Color(uiColor: .lightGray))
                        }
                        Text(network.player?.username ?? "")
                            .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.leading)
                    }
                    .padding(.bottom, 20)
                    if network.player?.privacy == "private" {
                        Text("비공개 프로필입니다.")
                            .foregroundStyle(.gray)
                    }
                }
                .padding(30)
                .padding(.vertical, 10)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color(uiColor: .secondarySystemBackground))
                        
                }
            }
            Spacer()
            
        }
        .onTapGesture { hideKeyboard() }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(Network())
}

