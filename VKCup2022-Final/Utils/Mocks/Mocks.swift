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
        .init(url: "https://muzati.net/music/0-0-1-20580-20", duration: 139, decibles: decibles),
        .init(url: "https://muzati.net/music/0-0-1-20564-20", duration: 212, decibles: decibles),
    ]
    
    
    static let posts: [Post] = [
        
        
        .init(
        text: "Магия Apple или ничего необычного? Всех приветствую! В октябре свой отпуск я провела, путешествуя по городам Турции. Так я посетила официальный Apple Store в Стамбуле. О нём сегодня и пойдёт речь.",
        imageUrl: "https://avatars.dzeninfra.ru/get-zen_doc/5221694/pub_6373f050c613f77a96145ffb_6373f05bc613f77a96146119/scale_1200",
        podcastAudio: .init(audio: audios[0], channelName: "Bloha.ru"),
        channelInfo: .init(name: "Bloha.ru", avatar: "https://avatars.dzeninfra.ru/get-zen-logos/1520972/pub_5dcbbb0e136c034ec1805087_614ae97fd2124317a70da7fb/scale_2400")
        ),
        
        
            .init(text: "Новый нашумевший сериал “Игра в кальмара” ужасный, хотите знать почему? Разбор сериала в новом подкасте.",
                  imageUrl: "https://infobiscuit.com/wp-content/uploads/2021/11/%D1%81%D0%B5%D1%80%D0%B8%D0%B0%D0%BB-%D0%B8%D0%B3%D1%80%D0%B0-%D0%B2-%D0%BA%D0%B0%D0%BB%D1%8C%D0%BC%D0%B0%D1%80%D0%B0-%D0%B4%D0%BE%D1%80%D0%B0%D0%BC%D0%B0.jpg",
                  podcastAudio: .init(audio: audios[1], channelName: "Aнтон Лавров"),
                  channelInfo: .init(name: "Aнтон Лавров", avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQo6rHdhb-HpWoC8JKiBBOSv376q3Z49BvUxdwdpdAwvaLiuTH9sXEECwMyQ00dQxnAYFA&usqp=CAU")
                 ),
        
            .init(text: "Что такое IT и почему это так важно?  Если спросить на улице обычного прохожего, то у него на ум сразу приходит что-то вроде ну это то что связано с компьютерами, а Ай-Ти'шники это те кто работают с компьютерами, банально сразу можно услышать программисты. Отчасти это верное представление, но лишь отчасти, мне, как представителю IT-сферы хотелось бы, чтобы у людей было правильное представление о данной сфере и уважительное отношение к ней.", imageUrl: "https://avatars.dzeninfra.ru/get-zen_doc/1581470/pub_5cbf20e90a13b900b4b7e328_5cbf2c9070da470224cb8fd4/scale_1200", podcastAudio: .init(audio: audios[2], channelName: "IT Media"), channelInfo: .init(name: "IT Media", avatar: "https://res.cloudinary.com/grand-canyon-university/image/fetch/w_750,h_564,c_fill,g_faces,q_auto/https://www.gcu.edu/sites/default/files/2020-09/programming.jpg"))
        
    ]
    
}
