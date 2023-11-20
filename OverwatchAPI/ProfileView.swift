//
//  ProfileView.swift
//  OverwatchAPI
//
//  Created by Sebin Kwon on 11/16/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: MainViewModel
    var body: some View {
        List {
            Section {
                CellView(cellText: "치른 게임", content: String(viewModel.stats?.general.gamesPlayed ?? 0))
                CellView(cellText: "승리한 게임", content: String(viewModel.stats?.general.gamesWon ?? 0))
                CellView(cellText: "패배한 게임", content: String(viewModel.stats?.general.gamesLost ?? 0))
                CellView(cellText: "승률", content: String(format: "%.2f", viewModel.stats?.general.winrate ?? ""))
                CellView(cellText: "KDA", content: String(format: "%.2f", viewModel.stats?.general.kda ?? ""))
            } header: {
                Text("전체")
            }
            Section {
                CellView(cellText: "처치", content: String(format: "%.2f", viewModel.stats?.general.average.eliminations ?? ""))
                CellView(cellText: "지원", content: String(format: "%.2f", viewModel.stats?.general.average.assists ?? ""))
                CellView(cellText: "죽음", content: String(format: "%.2f", viewModel.stats?.general.average.deaths ?? ""))
                CellView(cellText: "피해량", content: String(format: "%.2f", viewModel.stats?.general.average.damage ?? ""))
                CellView(cellText: "치유량", content: String(format: "%.2f", viewModel.stats?.general.average.healing ?? ""))
            } header: {
                Text("평균")
            }
        }
    }
}

struct CellView: View {
    @EnvironmentObject var viewModel: MainViewModel
    var cellText: String
    var content: String
    var body: some View {
        HStack {
            Text(cellText)
            Spacer()
            Text(content)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(MainViewModel())
}
