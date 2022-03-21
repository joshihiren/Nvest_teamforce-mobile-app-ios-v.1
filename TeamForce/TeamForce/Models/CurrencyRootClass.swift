//
//  CurrencyRootClass.swift
//  TeamForce
//
//  Created by Hiren Joshi on 08/02/21.
//

import Foundation
import SwiftyJSON


class CurrencyRootClass : NSObject, NSCoding{

    var appCode : String!
    var coinsData : [CurrencyCoinsData]!
    var count : Int!
    var profileId : String!
    var status : Bool!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        appCode = json["app_code"].stringValue
        coinsData = [CurrencyCoinsData]()
        let coinsDataArray = json["coins_data"].arrayValue
        for coinsDataJson in coinsDataArray{
            let value = CurrencyCoinsData(fromJson: coinsDataJson)
            coinsData.append(value)
        }
        count = json["count"].intValue
        profileId = json["profile_id"].stringValue
        status = json["status"].boolValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if appCode != nil{
            dictionary["app_code"] = appCode
        }
        if coinsData != nil{
            var dictionaryElements = [[String:Any]]()
            for coinsDataElement in coinsData {
                dictionaryElements.append(coinsDataElement.toDictionary())
            }
            dictionary["coins_data"] = dictionaryElements
        }
        if count != nil{
            dictionary["count"] = count
        }
        if profileId != nil{
            dictionary["profile_id"] = profileId
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         appCode = aDecoder.decodeObject(forKey: "app_code") as? String
         coinsData = aDecoder.decodeObject(forKey: "coins_data") as? [CurrencyCoinsData]
         count = aDecoder.decodeObject(forKey: "count") as? Int
         profileId = aDecoder.decodeObject(forKey: "profile_id") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if appCode != nil{
            aCoder.encode(appCode, forKey: "app_code")
        }
        if coinsData != nil{
            aCoder.encode(coinsData, forKey: "coins_data")
        }
        if count != nil{
            aCoder.encode(count, forKey: "count")
        }
        if profileId != nil{
            aCoder.encode(profileId, forKey: "profile_id")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }

    }

}

class CurrencyCoinsData : NSObject, NSCoding{

    var hr24change : Double!
    var id : String!
    var adminCoin : Bool!
    var assetType : String!
    var coinImage : String!
    var coinName : String!
    var coinSymbol : String!
    var coinValue : Int!
    var coinValueUSD : Int!
    var coinAddedBy : String!
    var coinAddress : String!
    var country : String!
    var date : String!
    var decimals : Int!
    var erc20Address : String!
    var ethToken : Bool!
    var gxcoin : Bool!
    var mktCap : Double!
    var nativeDeposit : Bool!
    var originalPriceUsd : Double!
    var price : CurrencyPrice!
    var priceUsd : Double!
    var stableCoin : Bool!
    var supply : Int!
    var symbol : String!
    var ticker : String!
    var timestamp : Int!
    var token : Bool!
    var type : String!
    var usdPrice : Double!
    var volume24hr : Double!
    var withdrawalBalance : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        hr24change = json["_24hrchange"].doubleValue
        id = json["_id"].stringValue
        adminCoin = json["adminCoin"].boolValue
        assetType = json["asset_type"].stringValue
        coinImage = json["coinImage"].stringValue
        coinName = json["coinName"].stringValue
        coinSymbol = json["coinSymbol"].stringValue
        coinValue = json["coinValue"].intValue
        coinValueUSD = json["coinValueUSD"].intValue
        coinAddedBy = json["coin_added_by"].stringValue
        coinAddress = json["coin_address"].stringValue
        country = json["country"].stringValue
        date = json["date"].stringValue
        decimals = json["decimals"].intValue
        erc20Address = json["erc20Address"].stringValue
        ethToken = json["eth_token"].boolValue
        gxcoin = json["gxcoin"].boolValue
        mktCap = json["mkt_cap"].doubleValue
        nativeDeposit = json["native_deposit"].boolValue
        originalPriceUsd = json["original_price_usd"].doubleValue
        let priceJson = json["price"]
        if !priceJson.isEmpty{
            price = CurrencyPrice(fromJson: priceJson)
        }
        priceUsd = json["price_usd"].doubleValue
        stableCoin = json["stable_coin"].boolValue
        supply = json["supply"].intValue
        symbol = json["symbol"].stringValue
        ticker = json["ticker"].stringValue
        timestamp = json["timestamp"].intValue
        token = json["token"].boolValue
        type = json["type"].stringValue
        usdPrice = json["usd_price"].doubleValue
        volume24hr = json["volume24hr"].doubleValue
        withdrawalBalance = json["withdrawal_balance"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if hr24change != nil{
            dictionary["_24hrchange"] = hr24change
        }
        if id != nil{
            dictionary["_id"] = id
        }
        if adminCoin != nil{
            dictionary["adminCoin"] = adminCoin
        }
        if assetType != nil{
            dictionary["asset_type"] = assetType
        }
        if coinImage != nil{
            dictionary["coinImage"] = coinImage
        }
        if coinName != nil{
            dictionary["coinName"] = coinName
        }
        if coinSymbol != nil{
            dictionary["coinSymbol"] = coinSymbol
        }
        if coinValue != nil{
            dictionary["coinValue"] = coinValue
        }
        if coinValueUSD != nil{
            dictionary["coinValueUSD"] = coinValueUSD
        }
        if coinAddedBy != nil{
            dictionary["coin_added_by"] = coinAddedBy
        }
        if coinAddress != nil{
            dictionary["coin_address"] = coinAddress
        }
        if country != nil{
            dictionary["country"] = country
        }
        if date != nil{
            dictionary["date"] = date
        }
        if decimals != nil{
            dictionary["decimals"] = decimals
        }
        if erc20Address != nil{
            dictionary["erc20Address"] = erc20Address
        }
        if ethToken != nil{
            dictionary["eth_token"] = ethToken
        }
        if gxcoin != nil{
            dictionary["gxcoin"] = gxcoin
        }
        if mktCap != nil{
            dictionary["mkt_cap"] = mktCap
        }
        if nativeDeposit != nil{
            dictionary["native_deposit"] = nativeDeposit
        }
        if originalPriceUsd != nil{
            dictionary["original_price_usd"] = originalPriceUsd
        }
        if price != nil{
            dictionary["price"] = price.toDictionary()
        }
        if priceUsd != nil{
            dictionary["price_usd"] = priceUsd
        }
        if stableCoin != nil{
            dictionary["stable_coin"] = stableCoin
        }
        if supply != nil{
            dictionary["supply"] = supply
        }
        if symbol != nil{
            dictionary["symbol"] = symbol
        }
        if ticker != nil{
            dictionary["ticker"] = ticker
        }
        if timestamp != nil{
            dictionary["timestamp"] = timestamp
        }
        if token != nil{
            dictionary["token"] = token
        }
        if type != nil{
            dictionary["type"] = type
        }
        if usdPrice != nil{
            dictionary["usd_price"] = usdPrice
        }
        if volume24hr != nil{
            dictionary["volume24hr"] = volume24hr
        }
        if withdrawalBalance != nil{
            dictionary["withdrawal_balance"] = withdrawalBalance
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         hr24change = aDecoder.decodeObject(forKey: "_24hrchange") as? Double
         id = aDecoder.decodeObject(forKey: "_id") as? String
         adminCoin = aDecoder.decodeObject(forKey: "adminCoin") as? Bool
         assetType = aDecoder.decodeObject(forKey: "asset_type") as? String
         coinImage = aDecoder.decodeObject(forKey: "coinImage") as? String
         coinName = aDecoder.decodeObject(forKey: "coinName") as? String
         coinSymbol = aDecoder.decodeObject(forKey: "coinSymbol") as? String
         coinValue = aDecoder.decodeObject(forKey: "coinValue") as? Int
         coinValueUSD = aDecoder.decodeObject(forKey: "coinValueUSD") as? Int
         coinAddedBy = aDecoder.decodeObject(forKey: "coin_added_by") as? String
         coinAddress = aDecoder.decodeObject(forKey: "coin_address") as? String
         country = aDecoder.decodeObject(forKey: "country") as? String
         date = aDecoder.decodeObject(forKey: "date") as? String
         decimals = aDecoder.decodeObject(forKey: "decimals") as? Int
         erc20Address = aDecoder.decodeObject(forKey: "erc20Address") as? String
         ethToken = aDecoder.decodeObject(forKey: "eth_token") as? Bool
         gxcoin = aDecoder.decodeObject(forKey: "gxcoin") as? Bool
         mktCap = aDecoder.decodeObject(forKey: "mkt_cap") as? Double
         nativeDeposit = aDecoder.decodeObject(forKey: "native_deposit") as? Bool
         originalPriceUsd = aDecoder.decodeObject(forKey: "original_price_usd") as? Double
         price = aDecoder.decodeObject(forKey: "price") as? CurrencyPrice
         priceUsd = aDecoder.decodeObject(forKey: "price_usd") as? Double
         stableCoin = aDecoder.decodeObject(forKey: "stable_coin") as? Bool
         supply = aDecoder.decodeObject(forKey: "supply") as? Int
         symbol = aDecoder.decodeObject(forKey: "symbol") as? String
         ticker = aDecoder.decodeObject(forKey: "ticker") as? String
         timestamp = aDecoder.decodeObject(forKey: "timestamp") as? Int
         token = aDecoder.decodeObject(forKey: "token") as? Bool
         type = aDecoder.decodeObject(forKey: "type") as? String
         usdPrice = aDecoder.decodeObject(forKey: "usd_price") as? Double
         volume24hr = aDecoder.decodeObject(forKey: "volume24hr") as? Double
         withdrawalBalance = aDecoder.decodeObject(forKey: "withdrawal_balance") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if hr24change != nil{
            aCoder.encode(hr24change, forKey: "_24hrchange")
        }
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if adminCoin != nil{
            aCoder.encode(adminCoin, forKey: "adminCoin")
        }
        if assetType != nil{
            aCoder.encode(assetType, forKey: "asset_type")
        }
        if coinImage != nil{
            aCoder.encode(coinImage, forKey: "coinImage")
        }
        if coinName != nil{
            aCoder.encode(coinName, forKey: "coinName")
        }
        if coinSymbol != nil{
            aCoder.encode(coinSymbol, forKey: "coinSymbol")
        }
        if coinValue != nil{
            aCoder.encode(coinValue, forKey: "coinValue")
        }
        if coinValueUSD != nil{
            aCoder.encode(coinValueUSD, forKey: "coinValueUSD")
        }
        if coinAddedBy != nil{
            aCoder.encode(coinAddedBy, forKey: "coin_added_by")
        }
        if coinAddress != nil{
            aCoder.encode(coinAddress, forKey: "coin_address")
        }
        if country != nil{
            aCoder.encode(country, forKey: "country")
        }
        if date != nil{
            aCoder.encode(date, forKey: "date")
        }
        if decimals != nil{
            aCoder.encode(decimals, forKey: "decimals")
        }
        if erc20Address != nil{
            aCoder.encode(erc20Address, forKey: "erc20Address")
        }
        if ethToken != nil{
            aCoder.encode(ethToken, forKey: "eth_token")
        }
        if gxcoin != nil{
            aCoder.encode(gxcoin, forKey: "gxcoin")
        }
        if mktCap != nil{
            aCoder.encode(mktCap, forKey: "mkt_cap")
        }
        if nativeDeposit != nil{
            aCoder.encode(nativeDeposit, forKey: "native_deposit")
        }
        if originalPriceUsd != nil{
            aCoder.encode(originalPriceUsd, forKey: "original_price_usd")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if priceUsd != nil{
            aCoder.encode(priceUsd, forKey: "price_usd")
        }
        if stableCoin != nil{
            aCoder.encode(stableCoin, forKey: "stable_coin")
        }
        if supply != nil{
            aCoder.encode(supply, forKey: "supply")
        }
        if symbol != nil{
            aCoder.encode(symbol, forKey: "symbol")
        }
        if ticker != nil{
            aCoder.encode(ticker, forKey: "ticker")
        }
        if timestamp != nil{
            aCoder.encode(timestamp, forKey: "timestamp")
        }
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if usdPrice != nil{
            aCoder.encode(usdPrice, forKey: "usd_price")
        }
        if volume24hr != nil{
            aCoder.encode(volume24hr, forKey: "volume24hr")
        }
        if withdrawalBalance != nil{
            aCoder.encode(withdrawalBalance, forKey: "withdrawal_balance")
        }

    }

}

class CurrencyPrice : NSObject, NSCoding{

    var aED : Double!
    var aRS : Double!
    var aUD : Double!
    var cAD : Double!
    var cNY : Double!
    var cOP : Double!
    var eUR : Double!
    var gBP : Double!
    var iDR : Double!
    var iNR : Double!
    var jPY : Double!
    var mXN : Double!
    var uSD : Double!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        aED = json["AED"].doubleValue
        aRS = json["ARS"].doubleValue
        aUD = json["AUD"].doubleValue
        cAD = json["CAD"].doubleValue
        cNY = json["CNY"].doubleValue
        cOP = json["COP"].doubleValue
        eUR = json["EUR"].doubleValue
        gBP = json["GBP"].doubleValue
        iDR = json["IDR"].doubleValue
        iNR = json["INR"].doubleValue
        jPY = json["JPY"].doubleValue
        mXN = json["MXN"].doubleValue
        uSD = json["USD"].doubleValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if aED != nil{
            dictionary["AED"] = aED
        }
        if aRS != nil{
            dictionary["ARS"] = aRS
        }
        if aUD != nil{
            dictionary["AUD"] = aUD
        }
        if cAD != nil{
            dictionary["CAD"] = cAD
        }
        if cNY != nil{
            dictionary["CNY"] = cNY
        }
        if cOP != nil{
            dictionary["COP"] = cOP
        }
        if eUR != nil{
            dictionary["EUR"] = eUR
        }
        if gBP != nil{
            dictionary["GBP"] = gBP
        }
        if iDR != nil{
            dictionary["IDR"] = iDR
        }
        if iNR != nil{
            dictionary["INR"] = iNR
        }
        if jPY != nil{
            dictionary["JPY"] = jPY
        }
        if mXN != nil{
            dictionary["MXN"] = mXN
        }
        if uSD != nil{
            dictionary["USD"] = uSD
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         aED = aDecoder.decodeObject(forKey: "AED") as? Double
         aRS = aDecoder.decodeObject(forKey: "ARS") as? Double
         aUD = aDecoder.decodeObject(forKey: "AUD") as? Double
         cAD = aDecoder.decodeObject(forKey: "CAD") as? Double
         cNY = aDecoder.decodeObject(forKey: "CNY") as? Double
         cOP = aDecoder.decodeObject(forKey: "COP") as? Double
         eUR = aDecoder.decodeObject(forKey: "EUR") as? Double
         gBP = aDecoder.decodeObject(forKey: "GBP") as? Double
         iDR = aDecoder.decodeObject(forKey: "IDR") as? Double
         iNR = aDecoder.decodeObject(forKey: "INR") as? Double
         jPY = aDecoder.decodeObject(forKey: "JPY") as? Double
         mXN = aDecoder.decodeObject(forKey: "MXN") as? Double
         uSD = aDecoder.decodeObject(forKey: "USD") as? Double

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if aED != nil{
            aCoder.encode(aED, forKey: "AED")
        }
        if aRS != nil{
            aCoder.encode(aRS, forKey: "ARS")
        }
        if aUD != nil{
            aCoder.encode(aUD, forKey: "AUD")
        }
        if cAD != nil{
            aCoder.encode(cAD, forKey: "CAD")
        }
        if cNY != nil{
            aCoder.encode(cNY, forKey: "CNY")
        }
        if cOP != nil{
            aCoder.encode(cOP, forKey: "COP")
        }
        if eUR != nil{
            aCoder.encode(eUR, forKey: "EUR")
        }
        if gBP != nil{
            aCoder.encode(gBP, forKey: "GBP")
        }
        if iDR != nil{
            aCoder.encode(iDR, forKey: "IDR")
        }
        if iNR != nil{
            aCoder.encode(iNR, forKey: "INR")
        }
        if jPY != nil{
            aCoder.encode(jPY, forKey: "JPY")
        }
        if mXN != nil{
            aCoder.encode(mXN, forKey: "MXN")
        }
        if uSD != nil{
            aCoder.encode(uSD, forKey: "USD")
        }

    }

}
