//
//  Extensions.swift
//  MyToDoList
//
//  Created by Ali Siddiqui on 1/10/24.
//


import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, value: self, comment: "Localized string for \(self)")
    }
}

extension Notification.Name {
    static let didDenyLocationPermission = Notification.Name("didDenyLocationPermission")
    static let didAllowLocationPermission = Notification.Name("didAllowLocationPermission")

    static let didRemoveAds = Notification.Name("didRemoveAds")

    static let didActivatePro = Notification.Name("didActivatePro")
    static let didDeactivatePro = Notification.Name("didDeactivatePro")

    static let didUpdateSavedLocations = Notification.Name("didUpdateSavedLocations")

    static let timezoneSettingDidChange = Notification.Name("timezoneSettingDidChange")

    static let didDismissOnboarding = Notification.Name("didDismissOnboarding")
}

extension String {
    func capitalizingFirstLetter() -> String {
        let characters = Array(self)
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension Date {
    func convertToTimeZone(
        initTimeZone: TimeZone = .current,
        timeZone: TimeZone
    ) -> Date {
         let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
         return addingTimeInterval(delta)
    }
}
