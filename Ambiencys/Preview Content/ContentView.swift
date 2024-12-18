//
//  ContentView.swift
//  Ambiencys
//
//  Created by Michele Lemba on 17/12/24.
//

// Update imports
import SwiftUI
import AVFoundation

struct Playlist: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String?
    let playerImageName: String?
    let audioFileName: String  // Name of the MP3 file
}

struct ContentView: View {
    @State private var playlists: [Playlist] = [
        Playlist(name: "Horror Ambience",
                imageName: "horror pre",
                playerImageName: "horror play",
                audioFileName: "silent hill 2 album"),  // Add your MP3 file name here
        Playlist(name: "Iceland Explore",
                imageName: "iceland pre",
                playerImageName: "iceland play",
                audioFileName: "iceland album"),  // Add your MP3 file name here
        Playlist(name: "Night Drive",
                imageName: "night drive pre",
                playerImageName: "night drive play",
                 audioFileName: "drive album"),  // Add your MP3 file name here
        Playlist(name: "Wormhole",
                imageName: "wormhole pre",
                playerImageName: "wormhole play",
                 audioFileName: "Interstellar album"),  // Add your MP3 file name here
        Playlist(name: "Cyber Core",
                imageName: "cyber pre",
                playerImageName: "cyber play",
                audioFileName: "cyberpunk album")  // Add your MP3 file name here
            ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(playlists) { playlist in
                        NavigationLink(destination: PlaylistPlayerView(playlist: playlist)) {
                            VStack {
                                if let imageName = playlist.imageName {
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300, height: 200)
                                        .clipped()
                                } else {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 300, height: 200)
                                }
                                
                                Text(playlist.name)
                                    .font(.headline)
                                    .padding(.top, 5)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Ambiencys")
        }
        .preferredColorScheme(.dark)
    }
}

struct PlaylistPlayerView: View {
    let playlist: Playlist
    @State private var isPlaying: Bool = false
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            if let playerImageName = playlist.playerImageName {
                Image(playerImageName)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            } else {
                Color.black
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack {
                Spacer()
                
                // Simplified controls with only play/pause
                Button(action: togglePlayback) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
        .navigationTitle(playlist.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: setupAudio)
        
    }

    func setupAudio() {
        guard let path = Bundle.main.path(forResource: playlist.audioFileName, ofType: "mp3") else {
            print("Could not find audio file")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error setting up audio player: \(error)")
        }
    }
    
    func togglePlayback() {
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        isPlaying.toggle()
    }
    
   
    }

#Preview {
    ContentView()
}
