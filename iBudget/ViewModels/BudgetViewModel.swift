//
//  BudgetViewModel.swift
//  iBudget
//
//  Created by Antoine Himpens on 06/02/2024.
//

import SwiftUI
import SwiftData

struct BudgetViewModel {
    var budget : Budget
    
    init(budget : Budget) {
        self.budget = budget
    }
    
    func initBudgetEnveloppes() -> [Enveloppe] {
        var enveloppes : [Enveloppe] = []
        print("inside initEnveloppe")
        print(budget.budget_interval)

        let calendar = Calendar.current
        var currentDate = budget.budget_start_date
        var nextDate = budget.budget_start_date

        let calendarComponent: Calendar.Component
        switch budget.budget_interval {
            case .day:
                calendarComponent = .day
            case .week:
                calendarComponent = .weekOfYear
            case .month:
                calendarComponent = .month
            case .year:
                calendarComponent = .year
            }
        
        print(calendarComponent.self)
        
        // Tant que la date actuelle est inférieure ou égale à la date de fin du budget
        while currentDate <= budget.budget_end_date {
            print(budget.budget_end_date)
            // Passer à la prochaine date en fonction de l'intervalle du budget
            if let nextDate = calendar.date(byAdding: calendarComponent, value: budget.budget_number, to: currentDate) {
                    print("here")
                // Créer une nouvelle enveloppe avec la date actuelle
                let enveloppe = Enveloppe(enveloppe_name: budget.budget_name, enveloppe_category: budget.budget_category.category_name, enveloppe_timescale: budget.budget_interval, enveloppe_start_date:currentDate, enveloppe_end_date: nextDate)
                enveloppes.append(enveloppe)
                currentDate = nextDate
            } else {
                // En cas d'erreur, sortir de la boucle
                break
            }
        }
        return enveloppes
    }
}

