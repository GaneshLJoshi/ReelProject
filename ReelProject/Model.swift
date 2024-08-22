//
//  Model.swift
//  ReelProject
//
//  Created by Ganesh Joshi on 03/08/24.
//

import Foundation


//Old Models

struct ReelResponse: Codable {
    let reels: [ReelArray]
}

struct ReelArray: Codable {
    let arr: [ReelItem]
}

struct ReelItem: Codable {
    let id: String
    let video: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case video
        case thumbnail
    }
}

//New Models

struct Reel: Codable, Identifiable {
    let id = UUID()
    let videos: [Video]

    enum CodingKeys: String, CodingKey {
        case videos = "arr"
    }
}

struct Video: Codable, Identifiable {
    let id: String
    let videoURL: URL
    let thumbnailURL: URL

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case videoURL = "video"
        case thumbnailURL = "thumbnail"
    }
}

class VideoViewModel: ObservableObject {
    @Published var reels: [Reel] = []

    init() {
        loadReels()
    }

    func loadReels() {
        // Parse JSON data and populate the `reels` array
        
            do {
//                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let json = try decoder.decode([Reel].self, from: jsonData)
                self.reels = json
//                print(url)
                print(self.reels)
            } catch {
                print("Failed to load and parse JSON: \(error)")
            }
        }
}

class ViewModel {
    
    var reelResponse : ReelResponse?
    
    var reels : [Reel]?
    
    func getReelResponse() -> ReelResponse {
        var reelResponse : ReelResponse?
        do {
            let decoder = JSONDecoder()
            reelResponse = try decoder.decode(ReelResponse.self, from: jsonData)
            print(reelResponse!)
        } catch {
            print("Failed to decode JSON: \(error)")
        }
        return reelResponse!
    }
    
//    func loadReels() {
//        if let url = Bundle.main.url(forResource: "reels", withExtension: "json") {
//            do {
////                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let json = try decoder.decode([Reel].self, from: jsonData)
//                self.reels = json
//                print(self.reels)
//            } catch {
//                print("Failed to load and parse JSON: \(error)")
//            }
//        }
//    }
}

// JSON data (replace this with your actual JSON data)
let jsonData = """

{
    "reels": [
        {
            "arr": [
                {
                    "_id": "66a33f2e21577293158a355f",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3405221577293158a3574/1721974865795-08846663572526636-4038462-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3405221577293158a3574/1721974865939-040833689591632805-Screenshot%202024-07-26%20at%2011.37.13%20AM.png"
                },
                {
                    "_id": "66a3464f21577293158a357d",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3464f21577293158a357d/1721976399724-21327640595139208-mixkit-man-runs-past-ground-level-shot-32809-hd-ready.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3464f21577293158a357d/1721976399737-27574699859928464-Screenshot%202024-07-26%20at%2012.15.21%20PM.png"
                },
                {
                    "_id": "6694adb70007fd4aeff4517a",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/6694adb70007fd4aeff4517a/1721019830949-2533659002996804-2795405-uhd_2160_3840_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66953a8501bd082401a3a3c9/1721055877655-7014527174220184-model1.jpg"
                },
                {
                    "_id": "66a3402121577293158a356c",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3402121577293158a356c/1721974816927-1578548303334062-4058904-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3402121577293158a356c/1721974817382-6932488051752395-Screenshot%202024-07-26%20at%2011.38.35%20AM.png"
                }
            ]
        },
        {
            "arr": [
                {
                    "_id": "66a3467121577293158a3582",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3467121577293158a3582/1721976433743-7569023006552968-mixkit-portrait-of-a-fashion-woman-with-silver-makeup-39875-hd-ready.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3467121577293158a3582/1721976433756-5926039297621923-Screenshot%202024-07-26%20at%2012.14.29%20PM.png"
                },
                {
                    "_id": "66a33fa821577293158a3567",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33fa821577293158a3567/1721974695508-5098487685479176-4154230-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33fa821577293158a3567/1721974696191-8751596844302476-Screenshot%202024-07-26%20at%2011.41.32%20AM.png"
                },
                {
                    "_id": "66a33f2e21577293158a355f",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33f2e21577293158a355f/1721974574889-02987801029102477-5642525-hd_1080_1920_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33f2e21577293158a355f/1721974574914-7263180484558278-Screenshot%202024-07-26%20at%2011.43.35%20AM.png"
                },
                {
                    "_id": "6699eb8aa64d5ae0484d47f9",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/6699eb8aa64d5ae0484d47f9/1721363338198-6408187406160157-4058069-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/6699eb8aa64d5ae0484d47f9/1721363338337-15431623626084412-image1.jpeg"
                }
            ]
        },
        {
            "arr": [
                {
                    "_id": "66a33f2e21577293158a355f",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3405221577293158a3574/1721974865795-08846663572526636-4038462-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3405221577293158a3574/1721974865939-040833689591632805-Screenshot%202024-07-26%20at%2011.37.13%20AM.png"
                },
                {
                    "_id": "66a3464f21577293158a357d",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3464f21577293158a357d/1721976399724-21327640595139208-mixkit-man-runs-past-ground-level-shot-32809-hd-ready.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3464f21577293158a357d/1721976399737-27574699859928464-Screenshot%202024-07-26%20at%2012.15.21%20PM.png"
                },
                {
                    "_id": "6694adb70007fd4aeff4517a",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/6694adb70007fd4aeff4517a/1721019830949-2533659002996804-2795405-uhd_2160_3840_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66953a8501bd082401a3a3c9/1721055877655-7014527174220184-model1.jpg"
                },
                {
                    "_id": "66a3402121577293158a356c",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3402121577293158a356c/1721974816927-1578548303334062-4058904-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3402121577293158a356c/1721974817382-6932488051752395-Screenshot%202024-07-26%20at%2011.38.35%20AM.png"
                }
            ]
        },
        {
            "arr": [
                {
                    "_id": "66a3467121577293158a3582",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3467121577293158a3582/1721976433743-7569023006552968-mixkit-portrait-of-a-fashion-woman-with-silver-makeup-39875-hd-ready.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3467121577293158a3582/1721976433756-5926039297621923-Screenshot%202024-07-26%20at%2012.14.29%20PM.png"
                },
                {
                    "_id": "66a33fa821577293158a3567",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33fa821577293158a3567/1721974695508-5098487685479176-4154230-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33fa821577293158a3567/1721974696191-8751596844302476-Screenshot%202024-07-26%20at%2011.41.32%20AM.png"
                },
                {
                    "_id": "66a33f2e21577293158a355f",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33f2e21577293158a355f/1721974574889-02987801029102477-5642525-hd_1080_1920_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33f2e21577293158a355f/1721974574914-7263180484558278-Screenshot%202024-07-26%20at%2011.43.35%20AM.png"
                },
                {
                    "_id": "6699eb8aa64d5ae0484d47f9",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/6699eb8aa64d5ae0484d47f9/1721363338198-6408187406160157-4058069-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/6699eb8aa64d5ae0484d47f9/1721363338337-15431623626084412-image1.jpeg"
                }
            ]
        },
        {
            "arr": [
                {
                    "_id": "66a33f2e21577293158a355f",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3405221577293158a3574/1721974865795-08846663572526636-4038462-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3405221577293158a3574/1721974865939-040833689591632805-Screenshot%202024-07-26%20at%2011.37.13%20AM.png"
                },
                {
                    "_id": "66a3464f21577293158a357d",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3464f21577293158a357d/1721976399724-21327640595139208-mixkit-man-runs-past-ground-level-shot-32809-hd-ready.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3464f21577293158a357d/1721976399737-27574699859928464-Screenshot%202024-07-26%20at%2012.15.21%20PM.png"
                },
                {
                    "_id": "6694adb70007fd4aeff4517a",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/6694adb70007fd4aeff4517a/1721019830949-2533659002996804-2795405-uhd_2160_3840_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66953a8501bd082401a3a3c9/1721055877655-7014527174220184-model1.jpg"
                },
                {
                    "_id": "66a3402121577293158a356c",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3402121577293158a356c/1721974816927-1578548303334062-4058904-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3402121577293158a356c/1721974817382-6932488051752395-Screenshot%202024-07-26%20at%2011.38.35%20AM.png"
                }
            ]
        },
        {
            "arr": [
                {
                    "_id": "66a3467121577293158a3582",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3467121577293158a3582/1721976433743-7569023006552968-mixkit-portrait-of-a-fashion-woman-with-silver-makeup-39875-hd-ready.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3467121577293158a3582/1721976433756-5926039297621923-Screenshot%202024-07-26%20at%2012.14.29%20PM.png"
                },
                {
                    "_id": "66a33fa821577293158a3567",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33fa821577293158a3567/1721974695508-5098487685479176-4154230-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33fa821577293158a3567/1721974696191-8751596844302476-Screenshot%202024-07-26%20at%2011.41.32%20AM.png"
                },
                {
                    "_id": "66a33f2e21577293158a355f",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33f2e21577293158a355f/1721974574889-02987801029102477-5642525-hd_1080_1920_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33f2e21577293158a355f/1721974574914-7263180484558278-Screenshot%202024-07-26%20at%2011.43.35%20AM.png"
                },
                {
                    "_id": "6699eb8aa64d5ae0484d47f9",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/6699eb8aa64d5ae0484d47f9/1721363338198-6408187406160157-4058069-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/6699eb8aa64d5ae0484d47f9/1721363338337-15431623626084412-image1.jpeg"
                }
            ]
        },
        {
            "arr": [
                {
                    "_id": "66a33f2e21577293158a355f",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3405221577293158a3574/1721974865795-08846663572526636-4038462-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3405221577293158a3574/1721974865939-040833689591632805-Screenshot%202024-07-26%20at%2011.37.13%20AM.png"
                },
                {
                    "_id": "66a3464f21577293158a357d",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3464f21577293158a357d/1721976399724-21327640595139208-mixkit-man-runs-past-ground-level-shot-32809-hd-ready.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3464f21577293158a357d/1721976399737-27574699859928464-Screenshot%202024-07-26%20at%2012.15.21%20PM.png"
                },
                {
                    "_id": "6694adb70007fd4aeff4517a",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/6694adb70007fd4aeff4517a/1721019830949-2533659002996804-2795405-uhd_2160_3840_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66953a8501bd082401a3a3c9/1721055877655-7014527174220184-model1.jpg"
                },
                {
                    "_id": "66a3402121577293158a356c",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3402121577293158a356c/1721974816927-1578548303334062-4058904-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3402121577293158a356c/1721974817382-6932488051752395-Screenshot%202024-07-26%20at%2011.38.35%20AM.png"
                }
            ]
        },
        {
            "arr": [
                {
                    "_id": "66a3467121577293158a3582",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3467121577293158a3582/1721976433743-7569023006552968-mixkit-portrait-of-a-fashion-woman-with-silver-makeup-39875-hd-ready.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a3467121577293158a3582/1721976433756-5926039297621923-Screenshot%202024-07-26%20at%2012.14.29%20PM.png"
                },
                {
                    "_id": "66a33fa821577293158a3567",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33fa821577293158a3567/1721974695508-5098487685479176-4154230-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33fa821577293158a3567/1721974696191-8751596844302476-Screenshot%202024-07-26%20at%2011.41.32%20AM.png"
                },
                {
                    "_id": "66a33f2e21577293158a355f",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33f2e21577293158a355f/1721974574889-02987801029102477-5642525-hd_1080_1920_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/66a33f2e21577293158a355f/1721974574914-7263180484558278-Screenshot%202024-07-26%20at%2011.43.35%20AM.png"
                },
                {
                    "_id": "6699eb8aa64d5ae0484d47f9",
                    "video": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/6699eb8aa64d5ae0484d47f9/1721363338198-6408187406160157-4058069-uhd_2160_4096_25fps.mp4",
                    "thumbnail": "https://finap-dev.s3.ap-southeast-2.amazonaws.com/reels/6699eb8aa64d5ae0484d47f9/1721363338337-15431623626084412-image1.jpeg"
                }
            ]
        }
    ]
}
""".data(using: .utf8)!



