//
//  OfflineMap.swift
//  eFFU
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import CoreLocation
import Mapbox

extension ViewController {
    
    @nonobjc func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        // Start downloading tiles and resources for z13-16.
        startOfflinePackDownload()
    }
    
    func startOfflinePackDownload(){
        // Create a region that includes the current viewport and any tiles needed to view it when zoomed further in.
        // Because tile count grows exponentially with the maximum zoom level, you should be conservative with your `toZoomLevel` setting.
        
        if departureOn && arrivalOn {
            
            let coord = calculation.getCoordOfflineMap(departureLat: flight_Plan.get_Departure_Airfield_Latitude(),
                                                       departureLong: flight_Plan.get_Departure_Airfield_Longitude(),
                                                       arrivalLat: flight_Plan.get_Arrival_Airfield_Latitude(),
                                                       arrivalLong: flight_Plan.get_Arrival_Airfield_Longitude())
            
            //let northeast = CLLocationCoordinate2D(latitude: 40.989329, longitude: -102.062592)
            //let southwest = CLLocationCoordinate2D(latitude: 36.986207, longitude: -109.049896)
            
            let bbox = MGLCoordinateBounds(sw: coord.1, ne: coord.0)
            
            let region = MGLTilePyramidOfflineRegion(styleURL: MGLStyle.lightStyleURL, bounds: bbox, fromZoomLevel: 5, toZoomLevel: 13)
            let context = "Tile Pyramid Region".data(using: .utf8)
            MGLOfflineStorage.shared.addPack(for: region, withContext: context!) { (pack, error) in guard error == nil else {
                
                // The pack couldn't be created for some reason
                print ("Error: \(error?.localizedDescription ?? "unknow error")")
                return
                }
                
                // Start downloading
                pack!.resume()
            }
        }
    }
    
    @objc func offlinePackProgressDidChange(notification: NSNotification) {
        // Get the offline pack this notification is regarding,
        // and the associated user info for the pack; in this case, `name = My Offline Pack`
        do {
            if let pack = notification.object as? MGLOfflinePack,
                let userInfo = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(pack.context) as? [String: String] {
                let progress = pack.progress
                // or notification.userInfo![MGLOfflinePackProgressUserInfoKey]!.MGLOfflinePackProgressValue
                let completedResources = progress.countOfResourcesCompleted
                let expectedResources = progress.countOfResourcesExpected
                
                // Calculate current progress percentage.
                let progressPercentage = Float(completedResources) / Float(expectedResources)
                
                // Setup the progress bar.
                if progressView == nil {
                    progressView = UIProgressView(progressViewStyle: .default)
                    let frame = view.bounds.size
                    progressView.frame = CGRect(x: frame.width / 4, y: frame.height * 0.75, width: frame.width / 2, height: 10)
                    view.addSubview(progressView)
                }
                
                progressView.progress = progressPercentage
                
                // If this pack has finished, print its size and resource count.
                if completedResources == expectedResources {
                    let byteCount = ByteCountFormatter.string(fromByteCount: Int64(pack.progress.countOfBytesCompleted), countStyle: ByteCountFormatter.CountStyle.memory)
                    print("Offline pack “\(userInfo["name"] ?? "unknown")” completed: \(byteCount), \(completedResources) resources")
                } else {
                    // Otherwise, print download/verification progress.
                    print("Offline pack “\(userInfo["name"] ?? "unknown")” has \(completedResources) of \(expectedResources) resources — \(progressPercentage * 100)%.")
                }
            }
        } catch {
            print("Couldn't read file.")
        }
    }
    
    @objc func offlinePackDidReceiveError(notification: NSNotification) {
        do {
            if let pack = notification.object as? MGLOfflinePack,
                let userInfo = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(pack.context) as? [String: String],
                let error = notification.userInfo?[MGLOfflinePackUserInfoKey.error] as? NSError {
                print("Offline pack “\(userInfo["name"] ?? "unknown")” received error: \(error.localizedFailureReason ?? "unknown error")")
            }
        } catch {
            print("Couldn't read file.")
        }
    }
    
    @objc func offlinePackDidReceiveMaximumAllowedMapboxTiles(notification: NSNotification) {
        do {
            if let pack = notification.object as? MGLOfflinePack,
                let userInfo = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(pack.context) as? [String: String],
                let maximumCount = (notification.userInfo?[MGLOfflinePackUserInfoKey.maximumCount] as AnyObject).uint64Value {
                print("Offline pack “\(userInfo["name"] ?? "unknown")” reached limit of \(maximumCount) tiles.")
            }
        } catch {
            print("Couldn't read file.")
        }
    }
    /**
    func loadOffline(){
        
        //if app is offline load tiles
        if (MGLOfflineStorage.shared.packs?.count ?? 0) > 0{
            var index = Int()
            for i in 0..<(MGLOfflineStorage.shared.packs?.count ?? 0){
                do {
                    let dict = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(MGLOfflineStorage.shared.packs?[i].context ?? Data()) as! [String: Any]
                    if (MGLOfflineStorage.shared.packs?[i].region) == JSON(dict["name"] ?? "").stringValue{
                        index = i
                        break
                    }
                } catch {
                    print("Couldn't read file.")
                }
            }
            
            mapView.styleURL =  MGLOfflineStorage.shared.packs?[index].region.styleURL
            if let tiles = MGLOfflineStorage.shared.packs?[index].region as? MGLTilePyramidOfflineRegion{
                
                mapView.setVisibleCoordinateBounds(tiles.bounds, animated: true)
                guard ((self.model.data?.count ?? 0) != 0) || ((self.model.mapData?.regionName ?? "") == "") else{
                    return
                }
                self.mapView.zoomLevel = tiles.maximumZoomLevel
                self.mapView.centerCoordinate = CLLocationCoordinate2D(latitude: JSON(self.model.data?[0].latitude ?? "").doubleValue, longitude: JSON(self.model.data?[0].longitude ?? "").doubleValue)
                
            }
        }
    }
    **/
}
