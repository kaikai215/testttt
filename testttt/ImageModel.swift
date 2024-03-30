//
//  ImageModel.swift
//  testttt
//
//  Created by Ryan on 2024/3/24.
//

import Foundation
import UIKit

class ImageModel {
    var initialImagesGroup1: [UIImage] = []
    var initialImagesGroup2: [UIImage] = []
    var images:[UIImage] = []
    var imagesB:[UIImage] = []
    
    init(){
        for i in 1...6{
            if let image = UIImage(named: "imageA\(i)"){
                images.append(image)
                initialImagesGroup1.append(image)
            }
        }
        
        for i in 1...6{
            if let image = UIImage(named: "imageB\(i)"){
                imagesB.append(image)
                initialImagesGroup2.append(image)
            }
        }
        
    }
    func getRandomImage(group: Int) -> UIImage?{
        let images = group == 1 ? images : imagesB
        return images.randomElement()
    }
    
    func swapImageGroups() {
           // 交换两组图片数组
           (images, imagesB) = (imagesB, images)
       }
    
    func restImage(){
        images = initialImagesGroup1
        imagesB = initialImagesGroup2
    }
}
