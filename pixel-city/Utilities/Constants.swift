//
//  Constants.swift
//  pixel-city
//
//  Created by Umut Ağbaba on 18.03.2023.
//
import Foundation

let apiKey = "53c9c2b5ebba561af4cd0b3b27352f3b"

func flickrURL(forApiKey key: String, withAnnotation annotation: DroppablePin, numberOfPhotos number: Int) -> String {
    let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=km&per_page=\(number)&format=json&nojsoncallback=1"
    print(url)
    return(url)
}
