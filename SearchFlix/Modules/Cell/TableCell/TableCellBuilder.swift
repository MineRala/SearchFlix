//
//  TableCellBuilder.swift
//  SearchFlix
//
//  Created by Mine Rala on 25.02.2025.
//

import Foundation

final class TableCellBuilder {
    @discardableResult
    static func build(cell: TableViewCell) -> TableViewCell {
        let interactor = TableViewCellInteractor()
        let presenter = TableViewCellPresenter(view: cell, interactor: interactor)
        
        cell.presenter = presenter
        interactor.output = presenter
        return cell
    }
}
