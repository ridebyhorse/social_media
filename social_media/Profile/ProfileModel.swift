//
//  ProfileModel.swift
//  social_media
//
//  Created by Мария Нестерова on 01.12.2023.
//

import Foundation

struct ProfileModel {
    
    let user: User
    
    let authorData = ["Live Science", "BBC News", "Magazine Design", "The Conversation"]
    
    let textData = [
        
        "Ask anyone what the fastest animal on Earth is, and they'll probably say the cheetah. But the focus on the speedy feline has stolen attention from other species that go much faster — some three or more times faster than the cheetah. Who are the overlooked speedsters of the animal kingdom?",
        
        "\"This isn’t a prison,' a nun in the new BBC drama The Woman in the Wall says. 'You can leave anytime you want. But where would you go? Who would have you? No one wants you. You’re a sinner.\"",
        
        "Editorial Design and in particular magazines always fascinated me. There are a lot of things you need to learn to be good at designing contemporary, stylish magazine spreads.",
        
        "An enthusiastic, sellout crowd arrived at Melbourne’s Hamer Hall in September to hear an evening of music from Orchestra Victoria. The program consisted largely of Australian music and premiere performances. If the sight of over 2,500 filled seats (filled, anecdotally, by those much younger than the typical orchestra audience) did not indicate how deeply this music was loved, then the standing ovation at the end of the night would leave no-one in doubt."
        
    ]
    
    let photoData = ["Cheetah", "WomanInTheWall", "MagDesign", "Gamer"]
    
    var likeData = [Int]()
    
    var viewData = [Int]()
    
    init(user: User) {
        self.user = user
        for _ in 1...authorData.count {
            likeData.append(Int.random(in: 1...10000))
        }
        
        
        for i in 0..<likeData.count {
            viewData.append(Int.random(in: likeData[i]...50000))
        }
    }
}
