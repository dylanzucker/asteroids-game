//
//  Constants.swift
//  Hamburger 2
//
//  Created by Joann Lin on 3/17/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import Foundation

struct Constants {
    struct API {
        struct Twitter {
            static let consumerKey = "MeyMtNeYAhM7WnVsKDcOVXa1C"
            static let consumerSecret = "MWYcadEEKorN0H3suj4n7ETnXeuvArgAne2ANknZeUMY3MfHRa"
        }
    }
    
    struct Mixpanel {
        static let token = "12d5d65fc49e0ac5b0d601d1ac4acadc"
    }
    
    struct Colors {
        static let themeColor = UIColor(red: 85/255, green: 80/255, blue: 235/255, alpha:1.00)
        static let themeUnderlineColor = UIColor(red: 8/255, green: 0/255, blue: 165/255, alpha:1.00)

//            UIColor(red:89/255, green:96/255, blue:234/255, alpha:1.00)
        
        struct InfoColors {
            static var facebookColor: UIColor = UIColor(red: 236/255, green: 238/255, blue: 255/255, alpha: 100/100)
            
            static var instagramGradient: CAGradientLayer {
                let topColor = UIColor(red: 230/255, green: 92/255, blue: 242/255, alpha: 12/100).cgColor
                let middleColor = UIColor(red: 229/255, green: 113/255, blue: 177/255, alpha: 12/100).cgColor
                let bottomColor = UIColor(red: 227/255, green: 138/255, blue: 97/255, alpha: 12/100).cgColor
                
                return getGradient(forColors: [topColor, middleColor, bottomColor], isHorizontal: false)
            }
            
            static var linkedinGradient: CAGradientLayer {
                // currently using behance's colors
                let topColor = UIColor(red: 21/255, green: 100/255, blue: 255/255, alpha: 15/100).cgColor
                let bottomColor = UIColor(red: 101/255, green: 153/255, blue: 255/255, alpha: 15/100).cgColor
                
                return getGradient(forColors: [topColor, bottomColor], isHorizontal: false)
            }
            
            static var pinterestGradient: CAGradientLayer {
                let topColor = UIColor(red: 217/255, green: 20/255, blue: 25/255, alpha: 20/100).cgColor
                let middleColor = UIColor(red: 225/255, green: 78/255, blue: 82/255, alpha: 20/100).cgColor
                let bottomColor = UIColor(red: 230/255, green: 113/255, blue: 116/255, alpha: 20/100).cgColor
                
                return getGradient(forColors: [topColor, middleColor, bottomColor], isHorizontal: false)
            }
            
            static var snapchatColor: UIColor = UIColor(red: 253/255, green: 253/255, blue: 218/255, alpha: 100/100)
            
            static var twitterGradient: CAGradientLayer {
                let leftSideColor = UIColor(red: 126/255, green: 163/255, blue: 194/255, alpha: 27/100).cgColor
                let middleColor = UIColor(red: 165/255, green: 190/255, blue: 211/255, alpha: 50/100).cgColor
                let rightSideColor = leftSideColor
                
                return getGradient(forColors: [leftSideColor, middleColor, rightSideColor], isHorizontal: true)
            }
            
            static var youtubeGradient: CAGradientLayer {
                // using dribble's colors
                let leftSideColor = UIColor(red: 239/255, green: 106/255, blue: 158/255, alpha: 27/100).cgColor
                let middleColor = UIColor(red: 227/255, green: 60/255, blue: 125/255, alpha: 27/100).cgColor
                let rightSideColor = leftSideColor
                
                return getGradient(forColors: [leftSideColor, middleColor, rightSideColor], isHorizontal: true)
            }


            private static func getGradient(forColors colors: [CGColor], isHorizontal: Bool) -> CAGradientLayer {
                let gl = CAGradientLayer()
                gl.colors = colors

                // switch to mathematical formula
                if (colors.count == 2) {
                    gl.locations = [0.0, 1.0]
                } else {
                    gl.locations = [0.0, 0.5, 1.0]
                }

                if (isHorizontal) {
                    gl.startPoint = false ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
                    gl.endPoint   = false ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
                }
                
                return gl
            }
        }
    }
    
    struct AppSettings {
        static let minNumberPeopleForAlphabeticalHeaders = 10
        static let maxNumberFriendRequestsShown = 1
    }
}
