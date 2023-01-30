//
//  Mocks.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 30.01.2023.
//

import Foundation


class Mocks{
    
    /// Берем данные длительности и децибелов при записи адио пользователем, храним на беке, таким образом ресурсоемкая операция буфуризации только при создании аудио
    ///
    ///Пример  децибелов [-22.04066, -25.137188, -25.342838, -24.163029, -26.385578, -12.319859, -10.529728, -8.324246, -11.337729, -9.090269, -9.417578, -9.883145, -8.065973, -10.078754, -8.628684, -7.886608, -13.356369, -8.546566, -11.172239, -12.766743, -10.853883, -12.419373, -7.708742, -8.151003, -8.74112, -8.811096, -14.244507, -10.347063, -8.423946, -10.364698, -8.335038, -8.668793, -9.576224, -7.1475077, -10.263487, -8.209866, -16.794659, -43.69749, -78.24029]
    ///
    
    static private let decibles: [Float] = {
        return (0...40).map { _ in -(Float.random(in: (1.0)...(80.0))) }
    }()
    

    
    static let audios: [Audio] = [
        .init(url: "https://mave-ua.b-cdn.net/podcasts/83cd9f40-5a0c-4935-b5e2-815b1b5fdb9d/episodes/7041463c-5f7a-4e28-894f-0862a708d410.mp3", duration: 732, decibles: decibles),
        .init(url: "https://muzati.net/music/0-0-1-20606-20", duration: 145, decibles: decibles),
        .init(url: "https://muzati.net/music/0-0-1-20580-20", duration: 139, decibles: decibles),
        .init(url: "https://muzati.net/music/0-0-1-20564-20", duration: 212, decibles: decibles)
    ]
    
    
}
