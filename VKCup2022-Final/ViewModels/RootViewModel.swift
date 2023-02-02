//
//  RootViewModel.swift
//  VKCup2022-Final
//
//  Created by Богдан Зыков on 01.02.2023.
//

import SwiftUI

class RootViewModel: ObservableObject{
    
    @Published var currentTab: TabEnum = .home
    @Published var selectedStories = [Story]()
    @Published var showStoryView: Bool = false
    
}
