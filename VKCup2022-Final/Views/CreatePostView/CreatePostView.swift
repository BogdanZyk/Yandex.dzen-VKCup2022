//
//  CreatePostView.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 03.02.2023.
//

import SwiftUI

struct CreatePostView: View {
    @ObservedObject var rootVM: RootViewModel
    @StateObject var player = AudioPlayerManger()
    @StateObject private var audioRecorder = AudioRecorderManager()
    @State private var text: String = ""
    @State private var podcast: Podcast?
    
    var body: some View {
        VStack{
            headerView
            textEditorView
            if let podcast {
                AudioPodcastViewComponent(playerManager: player, podcast: podcast)
                    .padding(.horizontal)
            }
            toolBarView
        }
        .preferredColorScheme(.dark)
    }
}

struct CreatePostView1_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(rootVM: RootViewModel())
    }
}

extension CreatePostView{
    private var headerView: some View{
        HStack{
            Button {
                if audioRecorder.recordState == .recording{
                    audioRecorder.cancel()
                }
                rootVM.showPostCreateView.toggle()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding(.leading)
            }
            Spacer()
            
            Button {
                rootVM.createPost(text, podcast: podcast)
            } label: {
                Image(systemName: "arrow.right")
                    .imageScale(.small)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(text.isEmpty ? Color.white.opacity(0.2) : Color.accentColor)
                    .clipShape(Circle())
                    .disabled(text.isEmpty || audioRecorder.recordState == .recording)
            }
        }
    }
    
    private var toolBarView: some View{
        HStack(spacing: 25){
            
            if audioRecorder.recordState == .recording{
                InRecordingView
            }else{
                Group{
                    Image(systemName: "paperclip")
                    Image(systemName: "slider.horizontal.3")
                }
                .font(.system(size: 25, weight: .bold))
                Spacer()
                if audioRecorder.recordState == .empty{
                    Button {
                        withAnimation {
                            audioRecorder.startRecording()
                        }
                    } label: {
                        Image(systemName: "mic.fill")
                            .imageScale(.large)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.accentColor)
                            .clipShape(Circle())
                    }
                }else{
                    Button {
                        withAnimation {
                            podcast = nil
                            audioRecorder.cancel()
                        }
                    } label: {
                        Label("Удалить аудио", systemImage: "trash.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.red)
                    }
                }
            }
        }
        
        .padding(.horizontal)
        .hLeading()
        .frame(height: 60)
        .background(Color.secondaryGray.ignoresSafeArea())
    }
    
    
    private var InRecordingView: some View{
        HStack{
            Circle()
                .fill(Color.red)
                .frame(width: 8, height: 8)
                .opacity(audioRecorder.toggleColor ? 0 : 1)
                .animation(.easeInOut(duration: 0.6), value: audioRecorder.toggleColor)
            Text(audioRecorder.currentRecordTime.minuteSeconds)
                .font(.subheadline)
            Spacer()
            Button {
                audioRecorder.cancel()
            } label: {
                Text("Отменить")
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding(.trailing, 30)
            }
            Spacer()
            
            Button {
                audioRecorder.stopRecording { audio in
                    self.podcast = .init(audio: audio, channelName: "Aнтон Лавров")
                }
            } label: {
                Image(systemName: "arrow.up")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .scaleEffect(audioRecorder.toggleColor ? 1.1 : 1)
                    .animation(.easeIn, value: audioRecorder.toggleColor)
            }
        }
    }
}



extension CreatePostView{
    
    private var textEditorView: some View{
        ZStack(alignment: .topLeading){
            
            TextEditor(text: $text)
            if text.isEmpty{
                Text("Что нового?")
                    .foregroundColor(.lightGray)
                    .padding(.top, 10)
                    .padding(.leading, 2)
            }
           
        }
        .lineSpacing(3)
        .font(.system(size: 16))
        .padding()
    }
}
