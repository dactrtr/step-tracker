//
//  STError.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 02-10-24.
//

import Foundation

enum STError : LocalizedError {
  case authNotDetermined
  case sharingDenied(quantityType: String)
  case noData
  case unableToCompleteRequest
  case invalidValue
  
  var errorDescription: String? {
    switch self {
    case .authNotDetermined:
      "Need Acces to Health Data"
    case .sharingDenied(_):
      "no write access"
    case .noData:
      "no Data"
    case .unableToCompleteRequest:
      "Unable to Complete Request"
    case .invalidValue:
      "Ivalid Value"
    }
  }
  var failureReason: String {
    switch self {
    case .authNotDetermined:
      "You have not given access to your Health data. Please go to Settings > Health > Data Access & Devices."
    case .sharingDenied(let quantityType):
      "You have denied acceess to upload your \(quantityType) data. \n\nYou can change this in Settings > Health > Data Access & Devices"
    case .noData:
      "There is no data for this Health statistics"
    case .unableToCompleteRequest:
      "We are unable to complete your request at this time. \n\nPlease try again later or contact support"
    case .invalidValue:
      "Must ve a numeric value with a maximum of one decimal place."
    }
  }
}
