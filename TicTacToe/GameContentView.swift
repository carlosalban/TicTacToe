//
//  GameContentView.swift
//  TicTacToe
//
//  Created by Carlos Alban on 1/19/24.
//

import SwiftUI
import SwiftData

struct GameContentView: View {
    @StateObject var viewModel = GameViewModel()

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.gameStatusDescription)
                    .font(.title)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 40)
            
            ForEach(viewModel.gameData, id: \.self) { rowData in
                HStack {
                    ForEach(rowData) { tile in
                        Button(action: {
                            viewModel.playerTouchedTile(id: tile.id)
                        }, label: {
                            // Wrap in HStack w/ padding so that button is still tapable even with empty text
                            HStack {
                                if let titleDisplayString = viewModel.tileDisplayString(id: tile.id) {
                                    Text(titleDisplayString)
                                        .font(.title)
                                }
                            }
                            .padding()
                        })
                        .foregroundStyle(.foreground)
                        .frame(width: 100, height: 100, alignment: .center)
                        .border(.foreground, width: 1)
                    }
                }
            }
            
            Button(action: {
                viewModel.resetGame()
            }, label: {
                Text("Reset")
                    .foregroundStyle(.background)
                    .padding(.horizontal, 60)
                    .padding(.vertical, 20)
            })
            .background(.foreground, in: .rect(cornerRadius: 10))
            .padding(.top, 40)
        }
    }
}

#Preview {
    GameContentView()
}
