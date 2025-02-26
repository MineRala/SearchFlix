//
//  CollectionCellBuilder.swift
//  SearchFlix
//
//  Created by Mine Rala on 25.02.2025.
//

import Foundation

final class CollectionCellBuilder {
    @discardableResult
    static func build(cell: CollectionViewCell) -> CollectionViewCell {
        let interactor = CollectionCellInteractor()
        let presenter = CollectionCellPresenter(view: cell, interactor: interactor)

        cell.presenter = presenter
        interactor.output = presenter
        return cell
    }
}
