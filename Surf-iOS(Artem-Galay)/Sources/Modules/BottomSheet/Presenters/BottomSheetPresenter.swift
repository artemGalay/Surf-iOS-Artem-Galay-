//
//  BottomSheet.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 11.02.23.
//

import Foundation

protocol BottomSheetPresenterProtocol: AnyObject {
    func getNumberOfItemsInfiniteCarousel() -> Int
    func getNumberOfItems() -> Int
    func getCategoriesText(for indexPath: IndexPath) -> String
}

final class BottomSheetPresenter: BottomSheetPresenterProtocol {

    private var numberOfItems = 1000
    private var categories = Categories.names

    func getNumberOfItemsInfiniteCarousel() -> Int {
        numberOfItems
    }

    func getNumberOfItems() -> Int {
        categories.count
    }

    func getCategoriesText(for indexPath: IndexPath) -> String {
        categories[indexPath.row % categories.count]
    }
}
