//
//  ContentView.swift
//  MultiSelect
//
//  Created by Макс on 18.08.2024.
//

import SwiftUI


struct MultiSelectFormView: View {
    // Массив элементов для выбора
    @State private var items: [SelectableItem] = [
        SelectableItem(id: 1, title: "Красный", required: true, tappedOnSelectAll: true),
        SelectableItem(id: 2, title: "Зеленый", required: true, tappedOnSelectAll: false),
        SelectableItem(id: 3, title: "Синий", required: false, tappedOnSelectAll: true),
        SelectableItem(id: 4, title: "Желтый", required: false, tappedOnSelectAll: true),
        SelectableItem(id: 5, title: "Фиолетовый", required: false, tappedOnSelectAll: false)
    ]
    
    // Флаг состояния "Выбрать всё"
    @State private var selectAll: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            // Кнопка "Выбрать всё"
            Button(action: {
                selectAll.toggle()
                toggleSelectAll(value: selectAll)
            }) {
                HStack {
                    Image(systemName: selectAll ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(selectAll ? .green : .gray)
                    Text("Выбрать всё")
                        .foregroundColor(selectAll ? .black : .gray)
                }
            }
            .padding(.bottom)

            // Список элементов с галочками
            ForEach($items) { $item in
                HStack {
                    Image(systemName: item.isSelected ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.isSelected ? .green : .gray)
                    Text(item.title)
                        .foregroundColor(item.isSelected ? .black : .gray)
                        .onTapGesture {
                            toggleItemSelection(item: $item)
                        }
                }
                .padding(.vertical, 5)
            }
            
            // Кнопка "Отправить"
            Button("Отправить") {
                submitForm()
            }
            .disabled(!isSubmitEnabled()) // Активность кнопки зависит от того, выбран ли хотя бы один элемент
            .padding(.top)
        }
        .padding()
    }
    
    // Функция, которая срабатывает при изменении состояния "Выбрать всё"
    private func toggleSelectAll(value: Bool) {
        for index in items.indices {
            items[index].isSelected = value
        }
        // После изменения состояния элементов обновляем состояние чекбокса "Выбрать всё"
        updateSelectAllState()
    }
    
    // Функция обновляет состояние чекбокса "Выбрать всё"
    private func updateSelectAllState() {
        selectAll = items.allSatisfy { $0.isSelected }
    }
    
    // Функция для переключения состояния выбора элемента
    private func toggleItemSelection(item: Binding<SelectableItem>) {
        item.isSelected.wrappedValue.toggle()
        updateSelectAllState()
    }
    
    // Функция проверяет, можно ли отправить форму
    private func isSubmitEnabled() -> Bool {
        // Кнопка "Отправить" активна, если выбран хотя бы один элемент
        return items.contains { $0.isSelected }
    }
    
    // Обработчик нажатия на кнопку "Отправить"
    private func submitForm() {
        print("Форма отправлена с выбранными элементами: \(items.filter { $0.isSelected }.map { $0.title })")
    }
}

// Превью для быстрого просмотра в Xcode
struct MultiSelectFormView_Previews: PreviewProvider {
    static var previews: some View {
        MultiSelectFormView()
    }
}
