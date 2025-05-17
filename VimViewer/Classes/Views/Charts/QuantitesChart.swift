//
//  QuantitiesChart.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import Charts
import SwiftData
import SwiftUI
import VimKit

struct QuantitiesChart: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.modelContext)
    var modelContext

    @State
    var data: [Vim.Tree.Node] = []

    @State
    var selectedAngle: Int? = nil

    @State
    var selected: Vim.Tree.Node? = nil

    /// Returns a total count of all data slices.
    var total: Int {
        data.reduce(0) { $0 + $1.ids.count }
    }

    /// Returns a percentage of the selected data slice.
    var percentage: Float {
        guard let selected else { return .zero }
        return Float(selected.ids.count) / Float(total)
    }

    var body: some View {

        ZStack {

            chartView
                .padding()
                .background(Color.black.opacity(0.65))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white, lineWidth: 2)
                )
        }
        .padding()
        .opacity(data.isEmpty ? 0 : 1)
        .onChange(of: vim.tree) { oldValue, newValue in
            Task {
                await loadData()
            }
        }
        .onChange(of: selected) { oldValue, newValue in
            Task {
                await toggle()
            }
        }
    }

    /// Builds the chart view.
    private var chartView: some View {
        Chart(data, id: \.name) { element in
            SectorMark(
                angle: .value("Count", element.ids.count),
                innerRadius: .ratio(0.618),
                angularInset: 1.5
            )
            .cornerRadius(5.0)
            .foregroundStyle(by: .value("Name", element.name))
            .opacity(element.name == selected?.name ? 1 : 0.3)
        }
        .chartAngleSelection(value: $selectedAngle)
        .scaledToFit()
        .onChange(of: selectedAngle, { oldValue, newValue in
            selected = findSelected(newValue)
        })
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                let frame = geometry[chartProxy.plotFrame!]
                VStack {
                    if let selected {
                        Text(selected.name)
                            .font(.callout.bold())

                        VStack {
                            Text(selected.ids.count.formatted())
                                .font(.callout)
                            Text(percentage.formatted(.percent.precision(.fractionLength(0))))
                                .font(.caption)
                        }
                        .foregroundStyle(.secondary)
                    } else {
                        Text("Model Objects")
                            .font(.callout.bold())
                        Text(total.formatted())
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                }
                .position(x: frame.midX, y: frame.midY)
            }
        }
        .chartLegend(.hidden)
    }

    /// Finds the selected data slice at the specified angle
    /// - Parameter angle: the angle of the data slice
    /// - Returns: the selected data slice
    private func findSelected(_ angle: Int?) -> Vim.Tree.Node? {

        guard let angle else { return nil }

        var accumulatedCount = 0

        let slice = data.first { slice in
            accumulatedCount += slice.ids.count
            return angle <= accumulatedCount
        }
        return slice
    }

    /// Toggles the selected data slice.
    private func toggle() async {

        guard let geometry = vim.geometry else { return }

        if let selected {
            geometry.hide(excluding: selected.ids)
        } else {
            geometry.unhide()
        }
    }

    /// Loads the top level categories as the array of data slices.
    private func loadData() async {
        guard let tree = vim.tree, let children = tree.root.children else { return }
        // Fetch the top level categories from the node tree
        data = children
    }
}

#Preview {
    let vim: Vim = .init()
    let data = [Vim.Tree.Node]()
    QuantitiesChart(data: data).environmentObject(vim)
}
