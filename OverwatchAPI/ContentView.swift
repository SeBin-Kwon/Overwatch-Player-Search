//
//  ContentView.swift
//  OverwatchAPI
//
//  Created by Sebin Kwon on 11/15/23.
//

import SwiftUI

struct ContentView: View {
    private let network = Network.shared
    @EnvironmentObject private var viewModel: MainViewModel
    @State private var playerId = ""
    @State private var isSearch = false
    @State private var isShowProfile = false
    var body: some View {
        NavigationStack {
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
//                        let replaceStr = playerId.replacingOccurrences(of: "#", with: "-")
                        viewModel.fetchPlayer(playerId: playerId)
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
                        AsyncImage(url: URL(string: viewModel.player?.avatar ?? "")) { image in
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
                            AsyncImage(url: URL(string: viewModel.player?.namecard ?? ""), scale: 5) { image in
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
                            Text(viewModel.player?.username ?? "")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.white)
                                .padding(.leading)
                        }
                        .padding(.bottom, 20)
                        if !viewModel.isPublic {
                            Text("비공개 프로필입니다.")
                                .font(.callout)
                                .foregroundStyle(.gray)
                        }
                    }
                    .sheet(isPresented: $isShowProfile, content: {
                        ProfileView()
                    })
                    .padding(30)
                    .padding(.vertical, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color(uiColor: .secondarySystemBackground))
                        
                    }
                    .onTapGesture {
                        if viewModel.player?.privacy == "public" {
                            isShowProfile = true
                            viewModel.fetchPlayerStats(playerId: playerId)
                        }
                    }
                }
                Spacer()
                
            }
            .onTapGesture { hideKeyboard() }
            .padding()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(MainViewModel())
}

