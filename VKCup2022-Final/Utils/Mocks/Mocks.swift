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
    
    static private var decibles: [Float]  {
        return (0...40).map { _ in -(Float.random(in: (1.0)...(80.0))) }
    }
    

    
    static let audios: [Audio] = [
        .init(url: "https://mave-ua.b-cdn.net/podcasts/83cd9f40-5a0c-4935-b5e2-815b1b5fdb9d/episodes/7041463c-5f7a-4e28-894f-0862a708d410.mp3", duration: 732, decibles: decibles),
        .init(url: "https://mavecloud.s3mts.ru/storage/podcasts/4fbfe8cb-665b-419a-82f6-686e679e9661/episodes/ed145525-ef2c-4339-a9f0-9d4f30c803ba.mp3", duration: 1011, decibles: decibles),
        .init(url: "https://mavecloud.s3mts.ru/storage/podcasts/4fbfe8cb-665b-419a-82f6-686e679e9661/episodes/0ee4469f-97fb-46f0-8b30-b29f76c97dfa.mp3", duration: 855, decibles: decibles),
        .init(url: "https://mave-ua.b-cdn.net/podcasts/83cd9f40-5a0c-4935-b5e2-815b1b5fdb9d/episodes/7041463c-5f7a-4e28-894f-0862a708d410.mp3", duration: 732, decibles: decibles),
        .init(url: "https://mavecloud.s3mts.ru/storage/podcasts/4fbfe8cb-665b-419a-82f6-686e679e9661/episodes/ed145525-ef2c-4339-a9f0-9d4f30c803ba.mp3", duration: 1011, decibles: decibles),
        .init(url: "https://mavecloud.s3mts.ru/storage/podcasts/4fbfe8cb-665b-419a-82f6-686e679e9661/episodes/0ee4469f-97fb-46f0-8b30-b29f76c97dfa.mp3", duration: 855, decibles: decibles)
    ]
    
    
    static let posts: [Post] = [
        
        
        .init(
        text: "Новые истории о позиционировании b2b компаний в IT: вредные советы и рабочие рекомендации.",
        imageUrl: nil,
        podcastAudio: nil,
        channelInfo: .init(name: "Bloha.ru", avatar: "https://avatars.dzeninfra.ru/get-zen-logos/1520972/pub_5dcbbb0e136c034ec1805087_614ae97fd2124317a70da7fb/scale_2400"),
        stories: storiesIT,
        storyPreview: .init(title: "О позиционировании B2B компаний в IT",image: storyImages[1].url)
        ),
        
        
            .init(text: "Здоровое питание может приносить и пользу, и удовольствие. Дорогие подписчики, завтра выйдет новая статья с моими авторскими рецептами, а пока предлагаю вам пройти мини-опрос в истории.",
                  imageUrl: nil,
                  podcastAudio: nil,
                  channelInfo: .init(name: "Aнтон Лавров", avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQo6rHdhb-HpWoC8JKiBBOSv376q3Z49BvUxdwdpdAwvaLiuTH9sXEECwMyQ00dQxnAYFA&usqp=CAU"),
                  stories: storiesFood,
                  storyPreview: .init(title: "Простые рецепты для здорового питания",image: storyImages[4].url)
                 ),
        
            .init(text: "Что такое IT и почему это так важно? Сегодня мой подкаст об этом.", imageUrl: "https://avatars.dzeninfra.ru/get-zen_doc/1581470/pub_5cbf20e90a13b900b4b7e328_5cbf2c9070da470224cb8fd4/scale_1200", podcastAudio: .init(audio: audios[2], channelName: "IT Media"), channelInfo: .init(name: "IT Media", avatar: "https://res.cloudinary.com/grand-canyon-university/image/fetch/w_750,h_564,c_fill,g_faces,q_auto/https://www.gcu.edu/sites/default/files/2020-09/programming.jpg")),
        
        .init(text: "Новый нашумевший сериал “Игра в кальмара” ужасный, хотите знать почему? Разбор сериала в новом подкасте.",
              imageUrl: "https://infobiscuit.com/wp-content/uploads/2021/11/%D1%81%D0%B5%D1%80%D0%B8%D0%B0%D0%BB-%D0%B8%D0%B3%D1%80%D0%B0-%D0%B2-%D0%BA%D0%B0%D0%BB%D1%8C%D0%BC%D0%B0%D1%80%D0%B0-%D0%B4%D0%BE%D1%80%D0%B0%D0%BC%D0%B0.jpg",
              podcastAudio: .init(audio: audios[0], channelName: "Aнтон Лавров"),
              channelInfo: .init(name: "Aнтон Лавров", avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQo6rHdhb-HpWoC8JKiBBOSv376q3Z49BvUxdwdpdAwvaLiuTH9sXEECwMyQ00dQxnAYFA&usqp=CAU")
             ),
        
    ]
    
    
    

    static let storiesIT: [Story] = [
        
        .init(image: storyImages[0], textBoxes: [
            
            .init(text: "Позиционирование b2b компаний в IT: вредные советы и рабочие рекомендации", size: 26, isBold: true, offsetX: -30, offsetY: -150, color: "#FFFFFF"), .init(text: "О подходах и решениях, делающих бренды безликими,\nи продуманной дифференциации в категории", size: 18, isBold: true, offsetX: -20, offsetY: 0, color: "#FFFFFF")], sticker: nil),
        
        
            .init(image: storyImages[1], textBoxes: [.init(text: "Вредный совет № 1: Целиться в рынки, а не в людей", size: 26, isBold: true, offsetX: -20, offsetY: -150, color: "#FFFFFF"), .init(text: "Часто B2B бренды воспринимаю свою аудиторию как функцию в компаниях с определенной географией, масштабом бизнеса и отраслью.", size: 20, isBold: true, offsetX: -10, offsetY: 0, color: "#FFFFFF")], sticker: .init(label: "🔥", type: .slider, offsetX: 0, offsetY: 150)),
        
        
            .init(image: storyImages[2], textBoxes: [.init(text: "Вредный совет № 2: Считать технологичность и инновационность своим преимуществом", size: 26, isBold: true, offsetX: 0, offsetY: -150, color: "#FFFFFF"), .init(text: "Бренды делают фокус на своей технологичности как на главном преимуществе, забывая о том, что в их категориях это must have", size: 20, isBold: true, offsetX: 0, offsetY: 0, color: "#FFFFFF")], sticker: .init(label: "🤩", type: .reaction, offsetX: 0, offsetY: 150)),
        
        
            .init(image: storyImages[3], textBoxes: [.init(text: "Вредный совет № 3: Забыть про эмоциональную составляющую бренда", size: 26, isBold: true, offsetX: 0, offsetY: -150, color: "#FFFFFF"), .init(text: "Во многих tech-категориях коммуникация брендов находится на уровне исключительно продуктовых и функциональных преимуществ", size: 20, isBold: true, offsetX: -10, offsetY: 0, color: "#FFFFFF")], sticker: .init(votedCount: 0.45, type: .button, buttonLabels : ["👍", "👎"],  offsetX: 0, offsetY: 150)),
        
    ]
    
    static let storiesFood: [Story] = [
        
        .init(image: storyImages[4], textBoxes: [
            
            .init(text: "Как бы вы оценили качество своего питания?", size: 26, isBold: true, offsetX: 0, offsetY: -250, color: "#FFFFFF"), .init(text: "только честно))", size: 26, isBold: true, offsetX: 0, offsetY: 200, color: "#FFFFFF")], sticker: .init(label: "🍆", type: .slider, offsetX: 0, offsetY: 250)),
        
            .init(image: storyImages[5], textBoxes: [.init(text: "Влияет ли ваш тип питания на качество вашей жизни?", size: 26, isBold: true, offsetX: 0, offsetY: -250, color: "#FFFFFF"), .init(text: "только честно))", size: 26, isBold: true, offsetX: 0, offsetY: 200, color: "#FFFFFF")], sticker: .init(label: "🍔", type: .slider, offsetX: 0, offsetY: 250)),
        
        
            .init(image: storyImages[6], textBoxes: [.init(text: "Составляете ли вы план вашего рациона?", size: 26, isBold: true, offsetX: 0, offsetY: -250, color: "#FFFFFF"), .init(text: "только честно))", size: 26, isBold: true, offsetX: 0, offsetY: 200, color: "#FFFFFF")], sticker: .init(label: "🥑", type: .slider, offsetX: 0, offsetY: 250)),
        
            .init(image: storyImages[7], textBoxes: [.init(text: "Как вы считаете, влияет ли сбалансированное здоровое и полноценное питание на качество вашей жизни?", size: 26, isBold: true, offsetX: 0, offsetY: -250, color: "#FFFFFF")], sticker: .init(votedCount: 0.68, type: .button, offsetX: 0, offsetY: 250)),
    ]
    
    
    
    
    
    
    private static let storyImages: [Story.BackgroundImage] = [
    
        .init(url: "https://images.unsplash.com/photo-1547394765-185e1e68f34e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80", offsetX: 0, offsetY: 0, scale: 3, bgColor: "#9D9C28"),
        .init(url: "https://images.unsplash.com/photo-1544652478-6653e09f18a2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80", offsetX: 0, offsetY: 0, scale: 7, bgColor: "#941C28"),
        .init(url: "https://images.unsplash.com/photo-1523961131990-5ea7c61b2107?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1548&q=80", offsetX: 0, offsetY: 0, scale: 4, bgColor: "#9D9C28"),
        .init(url: "https://images.unsplash.com/photo-1558742619-fd82741daa99?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80", offsetX: 4,  offsetY: 0, scale: 3, bgColor: "#9D9C28"),
        
        .init(url: "https://img.freepik.com/free-photo/top-view-eggplant-onion-plate-with-cutlery_23-2148853400.jpg?t=st=1675366797~exp=1675367397~hmac=5dceb8cd059715e5a14c8e19e8c8864c4db5af9d3e3d5c225391c212594aa947", offsetX: 0, offsetY: 0, scale: 1, bgColor: "#5D4493"),
        .init(url: "https://img.freepik.com/free-photo/flat-lat-bell-peppers-with-basket-vegetables_23-2148853382.jpg?t=st=1675366896~exp=1675367496~hmac=4f17bd3087f481ff8e6d2e853f2577ca723bf4b75407283810490ebaf06e4136", offsetX: 0,  offsetY: 0, scale: 1, bgColor: "#663C24"),
        .init(url: "https://img.freepik.com/free-photo/very-fresh-herb-quinoa-bowl_53876-126673.jpg?w=1480&t=st=1675369960~exp=1675370560~hmac=67c13f77f025f2c95956d3cfc5af48498046b1f753d592c859750e2e30822fc0", offsetX: 0,  offsetY: 0, scale: 1, bgColor: "#63926E"),
        .init(url: "https://img.freepik.com/free-photo/flat-lay-mix-vegetables-cutting-board-bowl-with-chicken-drumstick-spoon_23-2148369704.jpg?w=1800&t=st=1675366812~exp=1675367412~hmac=e42463d6920e613494ea45a83b9ae84e3ddf9cb16831a45cd96a9d187e2624ee", offsetX: 0,  offsetY: 0, scale: 4, bgColor: "#63926E")
    
    ]
    
}


