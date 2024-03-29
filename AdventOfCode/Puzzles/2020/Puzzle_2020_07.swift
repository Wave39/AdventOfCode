//
//  Puzzle_2020_07.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/7/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2020_07: PuzzleBaseClass {
    private struct BagDescription {
        var color: String
        var count: Int
    }

    private struct BagRule {
        var bag: BagDescription
        var contents: [BagDescription]
    }

    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.puzzleInput)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.puzzleInput)
    }

    private func parseBagRules(str: String) -> [BagRule] {
        let lines = str.parseIntoStringArray()
        var bagRules: [BagRule] = []
        for line in lines {
            let arr = line.parseIntoStringArray(separator: " ")
            var bagRule = BagRule(bag: BagDescription(color: arr[0] + " " + arr[1], count: 1), contents: [])
            if arr[4] != "no" {
                var idx = 4
                while idx < arr.count {
                    let bagDescription = BagDescription(color: arr[idx + 1] + " " + arr[idx + 2], count: arr[idx].int)
                    bagRule.contents.append(bagDescription)
                    idx += 4
                }
            }

            bagRules.append(bagRule)
        }

        return bagRules
    }

    private func getDependenciesForBag(bagRules: [BagRule], bagColor: String) -> [BagDescription] {
        guard let matchingBag = bagRules.first(where: { $0.bag.color == bagColor }) else {
            return []
        }
        return matchingBag.contents
    }

    private func bagCountInsideBag(bagRules: [BagRule], bagColor: String) -> Int {
        let dependentBags = getDependenciesForBag(bagRules: bagRules, bagColor: bagColor)
        var bagCount = 0
        for bag in dependentBags {
            bagCount += (bag.count + bag.count * bagCountInsideBag(bagRules: bagRules, bagColor: bag.color))
        }

        return bagCount
    }

    private func findBagsContainingBagColor(bagRules: [BagRule], bagColor: String) -> Set<String> {
        var bagColorSet: Set<String> = []

        func recursiveFindBagsContainingBagColor(bagRules: [BagRule], bagColor: String) {
            for bagRule in bagRules {
                if bagRule.contents.contains(where: { $0.color == bagColor }) {
                    bagColorSet.insert(bagRule.bag.color)
                    recursiveFindBagsContainingBagColor(bagRules: bagRules, bagColor: bagRule.bag.color)
                }
            }
        }

        recursiveFindBagsContainingBagColor(bagRules: bagRules, bagColor: bagColor)

        return bagColorSet
    }

    private func solvePart1(str: String) -> Int {
        let bagRules = parseBagRules(str: str)
        let bagColorSet = findBagsContainingBagColor(bagRules: bagRules, bagColor: "shiny gold")
        return bagColorSet.count
    }

    private func solvePart2(str: String) -> Int {
        let bagRules = parseBagRules(str: str)
        let bagCount = bagCountInsideBag(bagRules: bagRules, bagColor: "shiny gold")
        return bagCount
    }
}

private class Puzzle_Input: NSObject {
    static let puzzleInput_test1 = """
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""

    static let puzzleInput_test2 = """
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
"""

    static let puzzleInput = """
muted white bags contain 4 dark orange bags, 3 bright white bags.
bright salmon bags contain 5 light indigo bags.
drab brown bags contain 2 dark green bags, 2 plaid fuchsia bags, 1 muted tomato bag, 5 light tan bags.
dark salmon bags contain 1 posh white bag, 4 light violet bags.
mirrored gray bags contain 4 mirrored turquoise bags.
posh turquoise bags contain 3 mirrored magenta bags, 1 muted red bag, 4 dim gray bags, 5 dull tan bags.
posh coral bags contain 4 dark purple bags, 5 drab teal bags.
light violet bags contain 2 striped magenta bags, 5 light lime bags, 5 posh cyan bags.
dull brown bags contain 1 vibrant silver bag, 3 dotted beige bags.
dim salmon bags contain no other bags.
light bronze bags contain 1 bright maroon bag, 3 faded olive bags, 2 shiny beige bags, 4 striped orange bags.
pale plum bags contain 3 muted white bags, 3 striped magenta bags.
shiny tomato bags contain 4 vibrant chartreuse bags.
dark gray bags contain 5 dim bronze bags.
plaid tan bags contain 4 light coral bags, 2 dim fuchsia bags, 3 mirrored coral bags.
bright blue bags contain 4 muted gold bags, 4 striped aqua bags.
faded cyan bags contain 4 drab teal bags, 2 faded black bags, 1 posh cyan bag.
clear purple bags contain 4 posh lavender bags, 4 dim green bags, 2 dull white bags, 5 pale crimson bags.
faded chartreuse bags contain 2 wavy orange bags, 5 vibrant red bags, 5 pale salmon bags, 2 vibrant plum bags.
dull plum bags contain 2 posh gray bags, 1 bright aqua bag, 3 faded lavender bags, 3 dull salmon bags.
dull magenta bags contain 3 shiny violet bags, 2 posh tan bags.
pale lime bags contain 2 vibrant plum bags, 5 striped crimson bags.
shiny cyan bags contain 5 plaid black bags, 4 muted lime bags, 3 posh black bags.
posh lime bags contain 5 light lavender bags, 1 dim green bag, 3 dull purple bags, 5 muted tomato bags.
dotted tomato bags contain 2 bright lavender bags, 5 muted white bags, 5 pale maroon bags, 4 dotted tan bags.
muted teal bags contain 5 shiny brown bags, 1 drab olive bag, 2 shiny black bags, 3 posh white bags.
mirrored violet bags contain 1 striped gold bag, 4 drab lavender bags, 4 mirrored blue bags, 4 bright gold bags.
dim crimson bags contain 1 pale bronze bag, 2 pale turquoise bags, 5 striped aqua bags, 1 light lavender bag.
wavy chartreuse bags contain 2 shiny violet bags, 2 striped white bags, 1 vibrant silver bag.
mirrored red bags contain 3 clear maroon bags, 4 dim indigo bags, 5 drab brown bags, 1 shiny white bag.
mirrored maroon bags contain 4 drab maroon bags, 1 mirrored teal bag, 5 faded coral bags.
clear teal bags contain 4 dim orange bags, 4 mirrored bronze bags, 3 faded beige bags.
muted lime bags contain 4 faded indigo bags, 2 muted olive bags, 2 mirrored chartreuse bags.
faded fuchsia bags contain 5 dim bronze bags, 3 muted tan bags, 3 drab teal bags, 5 faded bronze bags.
dull blue bags contain 5 shiny beige bags, 2 shiny silver bags, 5 dull fuchsia bags.
drab white bags contain 1 dotted aqua bag.
dark chartreuse bags contain 2 mirrored magenta bags, 3 wavy yellow bags.
bright gold bags contain 4 faded fuchsia bags, 1 plaid olive bag, 5 muted tomato bags, 4 drab bronze bags.
drab chartreuse bags contain 1 vibrant lime bag, 2 dark teal bags.
muted plum bags contain 5 light yellow bags, 4 drab lime bags.
shiny lime bags contain 4 dull brown bags, 5 dark brown bags.
pale white bags contain 2 dull aqua bags, 5 muted tan bags, 1 drab bronze bag.
dim violet bags contain 1 wavy red bag, 2 striped brown bags.
posh gold bags contain 4 wavy blue bags, 3 dotted aqua bags, 5 wavy maroon bags, 5 striped indigo bags.
light indigo bags contain 3 striped teal bags, 2 wavy blue bags, 5 shiny brown bags, 3 plaid fuchsia bags.
posh tan bags contain 4 bright aqua bags, 5 clear gold bags.
muted bronze bags contain 4 drab fuchsia bags, 3 bright brown bags, 2 dull brown bags, 3 plaid red bags.
shiny turquoise bags contain 2 muted purple bags, 2 striped green bags, 1 clear tomato bag, 5 bright plum bags.
pale tan bags contain 4 dark brown bags, 1 clear tomato bag, 1 mirrored black bag, 4 bright red bags.
faded yellow bags contain 3 drab purple bags.
striped black bags contain 1 clear lavender bag.
dotted indigo bags contain 4 striped plum bags.
dull black bags contain 5 posh crimson bags, 5 shiny bronze bags, 5 posh salmon bags, 4 bright salmon bags.
plaid beige bags contain 3 drab turquoise bags, 4 striped lavender bags.
striped gray bags contain 5 vibrant bronze bags, 4 bright chartreuse bags.
wavy bronze bags contain 2 clear teal bags, 2 light orange bags, 1 striped beige bag.
mirrored green bags contain 5 plaid lavender bags, 2 mirrored purple bags, 1 dark silver bag.
posh maroon bags contain 2 faded blue bags, 5 light tan bags, 4 clear brown bags.
plaid chartreuse bags contain 2 posh white bags, 3 striped orange bags, 5 light beige bags, 3 drab lime bags.
muted tomato bags contain 3 striped teal bags.
drab magenta bags contain 3 bright brown bags, 2 muted white bags, 4 shiny silver bags, 1 shiny indigo bag.
light gray bags contain 3 striped turquoise bags, 1 light purple bag.
pale violet bags contain 3 posh olive bags, 2 drab green bags.
light chartreuse bags contain 2 dull silver bags, 5 faded maroon bags, 5 drab purple bags, 5 shiny gold bags.
dull gold bags contain 2 shiny indigo bags, 5 bright orange bags, 4 faded bronze bags, 1 shiny tan bag.
dark black bags contain 1 faded lavender bag, 1 faded gold bag, 5 clear blue bags.
clear blue bags contain 3 dull teal bags, 3 wavy violet bags.
vibrant violet bags contain 3 dark purple bags, 3 bright aqua bags, 2 light indigo bags, 2 vibrant lime bags.
pale gray bags contain 3 plaid green bags, 2 dull beige bags.
plaid teal bags contain 1 wavy gold bag.
dotted maroon bags contain 2 shiny green bags, 5 wavy magenta bags, 5 posh fuchsia bags.
pale coral bags contain 1 plaid chartreuse bag, 1 dark bronze bag, 3 wavy blue bags.
shiny plum bags contain 2 dark yellow bags, 2 plaid gold bags.
light plum bags contain 2 light olive bags, 1 clear yellow bag.
drab aqua bags contain 4 wavy gray bags, 5 bright beige bags, 1 drab plum bag, 2 posh coral bags.
posh brown bags contain 4 dim blue bags, 3 shiny tan bags.
pale tomato bags contain 4 light olive bags, 2 shiny olive bags, 3 posh lavender bags.
dim orange bags contain 3 posh tan bags.
dull olive bags contain 5 dim turquoise bags, 3 dotted blue bags, 1 dotted plum bag, 5 mirrored bronze bags.
dim gray bags contain 3 shiny blue bags, 3 striped aqua bags, 2 bright tomato bags.
posh gray bags contain 1 plaid crimson bag, 1 mirrored yellow bag.
wavy silver bags contain 5 mirrored black bags, 5 clear gray bags.
muted salmon bags contain 1 clear indigo bag.
clear gold bags contain no other bags.
dotted cyan bags contain 2 dotted turquoise bags.
light crimson bags contain 2 shiny turquoise bags, 3 plaid fuchsia bags, 2 shiny yellow bags.
plaid lime bags contain 1 dim silver bag.
dim beige bags contain 3 clear green bags, 3 mirrored gray bags, 4 dotted lavender bags, 5 muted bronze bags.
dark coral bags contain 4 bright tomato bags, 3 shiny brown bags, 3 light magenta bags.
dull orange bags contain 5 striped red bags, 3 pale coral bags, 5 vibrant green bags, 5 muted indigo bags.
vibrant gold bags contain 4 dull crimson bags, 2 dark yellow bags.
mirrored coral bags contain 2 bright green bags, 3 shiny orange bags, 3 clear aqua bags, 3 dull salmon bags.
pale purple bags contain 2 bright tomato bags, 3 light beige bags, 5 plaid bronze bags, 4 dull beige bags.
bright olive bags contain 1 shiny beige bag, 3 mirrored crimson bags, 5 striped orange bags, 3 plaid fuchsia bags.
clear black bags contain 2 dull green bags.
bright red bags contain 5 posh cyan bags, 1 clear black bag, 2 plaid turquoise bags, 4 muted yellow bags.
mirrored tan bags contain 3 light cyan bags, 2 vibrant red bags.
muted orange bags contain 1 clear lavender bag, 4 posh bronze bags, 3 dim bronze bags.
plaid orange bags contain 3 shiny silver bags.
shiny teal bags contain 4 light chartreuse bags, 2 dull crimson bags.
striped crimson bags contain 2 dotted tomato bags, 5 dim fuchsia bags.
dotted tan bags contain 3 drab purple bags, 2 mirrored bronze bags, 3 shiny beige bags, 3 posh tan bags.
posh olive bags contain 1 clear tomato bag.
faded silver bags contain 4 drab blue bags, 5 dull yellow bags, 4 dim red bags.
plaid violet bags contain 3 dull tan bags, 1 dim yellow bag.
muted violet bags contain 4 clear violet bags, 2 mirrored teal bags, 1 plaid violet bag.
dull lavender bags contain 2 dotted silver bags, 4 striped coral bags, 5 striped indigo bags.
faded crimson bags contain 2 drab red bags.
striped coral bags contain 5 dull brown bags, 3 vibrant red bags.
shiny tan bags contain 1 shiny fuchsia bag, 2 plaid gray bags.
plaid coral bags contain 4 muted brown bags, 3 faded indigo bags, 5 wavy white bags, 3 mirrored blue bags.
bright white bags contain no other bags.
dark green bags contain 2 mirrored lime bags, 4 wavy maroon bags.
mirrored yellow bags contain 3 posh white bags.
bright magenta bags contain 1 drab lime bag, 4 mirrored black bags, 4 dark yellow bags, 1 light indigo bag.
shiny aqua bags contain 4 drab tan bags, 3 muted gray bags.
dim olive bags contain 4 dotted lavender bags, 4 plaid green bags, 1 posh lavender bag, 5 dim tan bags.
posh magenta bags contain 3 posh white bags, 1 clear plum bag.
light aqua bags contain 4 dim salmon bags.
muted indigo bags contain 5 plaid purple bags.
clear chartreuse bags contain 2 mirrored bronze bags.
dim teal bags contain 4 striped orange bags, 4 posh tan bags, 2 wavy maroon bags, 3 bright turquoise bags.
dim lime bags contain 5 faded coral bags, 2 muted aqua bags, 4 faded maroon bags, 3 mirrored bronze bags.
faded black bags contain 1 wavy maroon bag, 1 light aqua bag, 2 muted gray bags.
striped violet bags contain 3 drab olive bags, 3 clear purple bags.
plaid silver bags contain 4 wavy violet bags, 4 dotted beige bags, 4 dull bronze bags.
dull salmon bags contain 4 light bronze bags, 1 drab fuchsia bag.
posh salmon bags contain 4 dim bronze bags.
dim plum bags contain 4 pale maroon bags, 2 dim yellow bags, 4 dim turquoise bags.
faded maroon bags contain 1 shiny blue bag, 4 striped lavender bags, 2 bright aqua bags, 4 posh white bags.
plaid white bags contain 1 dark coral bag, 4 drab salmon bags, 5 muted blue bags.
pale red bags contain 3 dim aqua bags, 3 shiny lavender bags.
plaid gold bags contain 3 dotted brown bags, 5 clear tomato bags.
dim white bags contain 4 bright olive bags, 4 vibrant maroon bags, 5 pale brown bags.
bright brown bags contain 3 dark green bags, 3 dim gold bags, 2 bright aqua bags, 2 pale indigo bags.
mirrored bronze bags contain 5 striped orange bags, 1 dim bronze bag, 2 clear gold bags.
plaid plum bags contain 3 dotted tan bags, 5 dim salmon bags.
dim maroon bags contain 5 light aqua bags.
striped brown bags contain 3 vibrant beige bags, 2 dim indigo bags.
vibrant yellow bags contain 2 plaid black bags.
shiny white bags contain 2 dim maroon bags, 1 posh lavender bag, 5 dim gray bags.
striped tomato bags contain 2 pale plum bags, 2 wavy lime bags, 3 dim lime bags, 5 dark teal bags.
drab tan bags contain 5 dark brown bags.
pale beige bags contain 4 dim teal bags, 3 dim silver bags.
faded aqua bags contain 1 muted black bag, 1 light bronze bag.
dim green bags contain 3 vibrant lime bags, 2 drab fuchsia bags.
dim lavender bags contain 3 dotted beige bags, 1 dim green bag, 1 faded coral bag, 1 shiny teal bag.
pale blue bags contain 4 plaid fuchsia bags, 2 dark purple bags, 5 bright crimson bags.
faded lavender bags contain 1 mirrored black bag, 4 muted blue bags.
plaid aqua bags contain 2 clear maroon bags, 4 shiny teal bags, 2 posh fuchsia bags.
dotted violet bags contain 2 pale indigo bags, 2 muted red bags, 3 light lavender bags, 3 shiny yellow bags.
dotted olive bags contain 4 dim aqua bags, 5 striped maroon bags, 1 pale red bag.
drab lime bags contain 3 dotted aqua bags, 4 posh tan bags, 2 faded black bags.
dim yellow bags contain 2 faded maroon bags, 5 light teal bags.
dull maroon bags contain 5 drab purple bags, 1 pale maroon bag, 2 light gold bags, 1 faded salmon bag.
wavy tan bags contain 2 vibrant maroon bags, 3 muted white bags, 2 shiny brown bags, 4 light chartreuse bags.
dull violet bags contain 4 bright beige bags, 2 vibrant maroon bags, 5 dim gold bags, 4 drab violet bags.
drab cyan bags contain 1 light olive bag, 3 dark turquoise bags, 3 dark yellow bags, 2 light black bags.
wavy coral bags contain 3 posh lavender bags, 2 pale indigo bags, 2 striped green bags, 5 light beige bags.
clear white bags contain 5 dull purple bags, 2 wavy red bags.
shiny gray bags contain 3 striped teal bags.
shiny indigo bags contain 4 clear gold bags, 3 dark teal bags.
light blue bags contain 1 muted coral bag, 5 dark cyan bags.
bright cyan bags contain 5 drab brown bags, 1 pale teal bag, 2 posh cyan bags, 5 shiny indigo bags.
plaid yellow bags contain 1 vibrant gray bag.
dotted brown bags contain 3 mirrored silver bags.
dotted bronze bags contain 1 light indigo bag, 5 mirrored crimson bags.
bright purple bags contain 3 posh teal bags, 3 dim orange bags, 4 dark gold bags, 1 striped purple bag.
striped lavender bags contain 5 dim salmon bags, 2 posh indigo bags.
dark gold bags contain 5 faded brown bags, 1 faded magenta bag, 4 drab lavender bags, 1 dull tan bag.
clear beige bags contain 3 drab violet bags, 2 dim crimson bags.
drab orange bags contain 1 clear blue bag.
wavy teal bags contain 4 plaid green bags, 5 light bronze bags, 5 shiny indigo bags, 4 drab violet bags.
muted maroon bags contain 1 bright plum bag, 1 dim teal bag.
wavy violet bags contain 2 striped green bags, 5 striped brown bags, 4 muted bronze bags.
clear brown bags contain 2 wavy lime bags, 2 mirrored red bags.
plaid magenta bags contain 3 vibrant gold bags, 2 striped green bags, 4 striped maroon bags.
vibrant blue bags contain 2 light beige bags, 5 mirrored cyan bags, 4 dark blue bags, 5 drab yellow bags.
mirrored brown bags contain 2 dotted white bags.
light gold bags contain 3 vibrant silver bags.
mirrored silver bags contain 4 faded maroon bags, 5 faded coral bags.
bright indigo bags contain 1 clear salmon bag, 4 dim turquoise bags, 2 mirrored black bags, 1 striped indigo bag.
mirrored olive bags contain 2 drab olive bags, 4 vibrant gray bags.
dark silver bags contain 4 bright chartreuse bags, 1 shiny indigo bag, 2 dull brown bags.
drab salmon bags contain 3 dotted plum bags, 2 bright gold bags, 2 plaid beige bags.
dotted white bags contain 3 bright plum bags, 5 dotted beige bags, 1 dotted silver bag.
light olive bags contain 1 muted aqua bag, 2 striped brown bags, 1 mirrored bronze bag.
dotted blue bags contain 3 drab red bags, 2 mirrored bronze bags.
muted lavender bags contain 4 clear chartreuse bags, 4 striped brown bags, 3 mirrored tan bags, 5 shiny indigo bags.
dotted chartreuse bags contain 3 clear maroon bags, 5 clear turquoise bags, 4 mirrored aqua bags, 5 plaid aqua bags.
posh crimson bags contain 5 plaid plum bags, 1 wavy blue bag.
vibrant olive bags contain 3 wavy silver bags, 1 shiny blue bag.
wavy yellow bags contain 3 dim teal bags, 1 light brown bag, 4 dull chartreuse bags, 5 striped red bags.
dark olive bags contain 5 bright maroon bags, 4 dim tan bags, 3 bright aqua bags, 2 pale turquoise bags.
bright plum bags contain 1 light yellow bag, 4 muted aqua bags.
drab plum bags contain 1 dim gray bag, 5 light chartreuse bags.
striped salmon bags contain 4 drab lavender bags.
bright coral bags contain 4 clear tomato bags.
drab silver bags contain 2 shiny orange bags, 2 muted coral bags.
posh violet bags contain 3 wavy red bags, 3 shiny blue bags, 4 pale brown bags, 1 light yellow bag.
mirrored black bags contain 3 wavy white bags, 4 dotted tan bags, 3 shiny purple bags, 3 dim bronze bags.
faded green bags contain 2 drab brown bags.
posh yellow bags contain 3 striped gold bags, 4 light purple bags.
drab lavender bags contain 5 pale brown bags, 4 striped aqua bags.
clear magenta bags contain 4 dull beige bags, 2 wavy red bags.
wavy fuchsia bags contain 4 dull fuchsia bags, 1 bright beige bag.
bright maroon bags contain 2 striped orange bags, 2 muted white bags, 4 vibrant beige bags.
mirrored chartreuse bags contain 2 bright plum bags.
mirrored lavender bags contain 4 clear magenta bags.
light lime bags contain 4 vibrant cyan bags, 2 mirrored yellow bags, 5 light teal bags, 4 muted plum bags.
pale green bags contain 3 vibrant coral bags.
dark plum bags contain 3 shiny lavender bags, 1 light plum bag, 5 drab gold bags.
faded purple bags contain 2 wavy lime bags, 5 drab teal bags, 1 dark green bag.
dim silver bags contain 5 striped white bags, 5 drab coral bags.
faded bronze bags contain 1 bright white bag, 5 posh fuchsia bags, 2 mirrored teal bags.
pale indigo bags contain 1 dull brown bag, 4 muted red bags, 3 vibrant chartreuse bags, 5 drab teal bags.
dark tan bags contain 2 dim blue bags, 3 plaid indigo bags, 1 vibrant indigo bag, 5 dull salmon bags.
bright silver bags contain 4 vibrant black bags, 5 clear salmon bags, 5 dull violet bags.
striped aqua bags contain 1 pale brown bag, 5 shiny silver bags, 1 dim salmon bag, 3 dull chartreuse bags.
light beige bags contain 1 posh lavender bag, 2 muted gold bags, 5 light tan bags, 5 striped magenta bags.
faded gold bags contain 1 posh brown bag, 5 dull salmon bags, 5 faded olive bags, 2 posh coral bags.
drab violet bags contain 3 vibrant gray bags, 1 light silver bag, 5 posh gold bags, 1 vibrant lime bag.
striped beige bags contain 5 shiny yellow bags, 5 striped magenta bags, 1 shiny gold bag, 2 dotted tan bags.
muted beige bags contain 4 wavy lavender bags, 2 light beige bags, 4 vibrant tan bags, 5 dark plum bags.
shiny salmon bags contain 4 muted aqua bags, 3 dark olive bags, 5 shiny blue bags, 3 wavy maroon bags.
dotted crimson bags contain 5 mirrored cyan bags, 2 light black bags, 2 faded lavender bags, 3 drab indigo bags.
vibrant red bags contain 3 light silver bags, 1 shiny purple bag, 1 shiny blue bag, 4 dotted lavender bags.
striped yellow bags contain 4 clear red bags, 2 dim violet bags.
posh bronze bags contain 3 clear salmon bags, 1 dull salmon bag, 3 drab turquoise bags.
mirrored plum bags contain 1 bright plum bag, 5 striped tan bags, 4 shiny magenta bags, 1 shiny coral bag.
plaid gray bags contain 4 dim teal bags, 2 plaid green bags, 5 muted green bags.
bright orange bags contain 5 muted gray bags, 3 dim violet bags, 1 dark turquoise bag.
dim purple bags contain 3 dark brown bags, 3 dark cyan bags, 5 faded indigo bags, 1 light coral bag.
muted magenta bags contain 2 muted white bags.
vibrant white bags contain 2 wavy lime bags, 2 vibrant gold bags, 1 dim silver bag.
dull lime bags contain 3 dark salmon bags, 1 mirrored yellow bag, 5 clear salmon bags, 4 light white bags.
dark fuchsia bags contain 2 wavy salmon bags, 4 bright lavender bags.
bright bronze bags contain 3 dark turquoise bags, 3 dim maroon bags.
faded beige bags contain 5 wavy gold bags.
dotted green bags contain 4 muted red bags, 4 light black bags, 5 wavy cyan bags, 4 mirrored aqua bags.
light salmon bags contain 4 dim plum bags, 3 dark bronze bags, 3 dotted turquoise bags.
light red bags contain 4 vibrant gold bags, 5 drab red bags.
mirrored orange bags contain 5 drab lavender bags, 2 drab aqua bags, 5 mirrored aqua bags, 2 posh blue bags.
light coral bags contain 3 posh magenta bags, 3 dim maroon bags, 2 light aqua bags.
dotted purple bags contain 2 plaid purple bags, 3 light chartreuse bags.
light cyan bags contain 1 dotted magenta bag, 1 drab lime bag, 2 clear magenta bags.
shiny green bags contain 4 drab silver bags, 4 wavy blue bags.
dull yellow bags contain 4 wavy maroon bags, 4 bright white bags, 3 wavy white bags.
vibrant gray bags contain 1 wavy maroon bag, 5 dark yellow bags, 1 wavy silver bag, 1 vibrant silver bag.
plaid purple bags contain 1 dark yellow bag, 1 faded maroon bag, 1 muted coral bag, 2 clear yellow bags.
light orange bags contain 1 vibrant black bag, 4 striped brown bags.
vibrant tomato bags contain 4 plaid cyan bags, 5 dim salmon bags, 1 pale lime bag, 1 dim teal bag.
shiny coral bags contain 5 shiny blue bags, 1 shiny beige bag, 2 drab silver bags.
dark aqua bags contain 4 plaid magenta bags, 2 dull cyan bags, 3 dim red bags.
dotted aqua bags contain 4 pale turquoise bags.
clear gray bags contain 2 vibrant salmon bags, 4 dim salmon bags, 2 shiny silver bags.
striped purple bags contain 2 muted salmon bags, 2 posh green bags.
dark indigo bags contain 1 muted lime bag, 3 posh cyan bags, 2 dull brown bags.
wavy crimson bags contain 5 pale purple bags, 1 pale black bag, 5 plaid gold bags, 2 dull red bags.
faded gray bags contain 1 plaid maroon bag, 2 muted red bags, 1 drab turquoise bag, 3 clear maroon bags.
drab indigo bags contain 1 faded olive bag, 2 pale plum bags, 3 muted aqua bags, 3 muted white bags.
light green bags contain 3 plaid gray bags.
posh white bags contain 3 dim salmon bags.
shiny bronze bags contain 3 pale brown bags.
light tomato bags contain 4 dim tan bags, 4 dull crimson bags, 4 dark coral bags, 3 mirrored gold bags.
shiny crimson bags contain 1 vibrant gray bag.
muted blue bags contain 1 light magenta bag, 4 drab indigo bags, 1 vibrant salmon bag, 4 dim tomato bags.
wavy maroon bags contain 4 mirrored bronze bags, 3 clear gray bags, 3 muted white bags.
wavy white bags contain 5 dim salmon bags, 3 striped lavender bags, 3 faded olive bags.
striped plum bags contain 1 drab purple bag.
bright lavender bags contain 2 posh white bags.
posh red bags contain 5 vibrant salmon bags, 3 dark yellow bags, 1 dotted tan bag.
dark violet bags contain 5 vibrant beige bags, 3 drab lime bags, 1 dull plum bag.
mirrored aqua bags contain 4 posh orange bags, 4 mirrored fuchsia bags, 1 shiny chartreuse bag.
dark crimson bags contain 4 dim cyan bags, 2 wavy magenta bags.
striped cyan bags contain 3 mirrored teal bags, 5 light turquoise bags.
posh blue bags contain 3 posh indigo bags, 4 clear maroon bags, 5 pale salmon bags, 1 faded yellow bag.
mirrored tomato bags contain 1 dim silver bag, 3 bright purple bags, 3 clear lavender bags, 2 drab gold bags.
plaid green bags contain 5 drab indigo bags, 4 vibrant gray bags, 1 vibrant chartreuse bag, 5 mirrored lavender bags.
clear maroon bags contain 2 shiny beige bags.
faded turquoise bags contain 4 vibrant crimson bags.
striped magenta bags contain 3 vibrant salmon bags, 4 dull chartreuse bags, 3 faded olive bags, 2 striped aqua bags.
dark magenta bags contain 4 mirrored purple bags, 1 dull beige bag, 2 plaid chartreuse bags.
drab turquoise bags contain 2 dark olive bags, 4 pale plum bags.
faded tan bags contain 5 dull crimson bags, 3 wavy gray bags.
muted tan bags contain no other bags.
dull tan bags contain 2 plaid maroon bags, 3 dark green bags, 3 shiny orange bags.
striped red bags contain 1 striped maroon bag, 4 clear red bags.
faded magenta bags contain 3 shiny teal bags, 4 bright crimson bags.
dull aqua bags contain 5 pale turquoise bags, 5 bright tomato bags, 4 drab lime bags, 3 drab brown bags.
bright lime bags contain 2 light red bags, 2 shiny olive bags, 4 posh white bags, 2 dotted white bags.
clear tomato bags contain 1 shiny beige bag, 2 bright lavender bags.
faded indigo bags contain 5 muted tan bags, 4 dim bronze bags.
bright yellow bags contain 2 wavy blue bags.
striped bronze bags contain 3 muted gold bags.
mirrored fuchsia bags contain 5 faded yellow bags, 5 light cyan bags, 4 striped crimson bags.
wavy gray bags contain 3 dull chartreuse bags, 2 drab black bags.
muted coral bags contain 1 light aqua bag, 1 striped lavender bag.
vibrant lime bags contain 5 posh lavender bags, 2 dim bronze bags, 1 dull silver bag.
shiny gold bags contain 1 plaid orange bag, 2 striped lavender bags, 4 pale brown bags, 5 wavy blue bags.
plaid red bags contain 1 light aqua bag, 2 mirrored salmon bags.
dark brown bags contain 1 dull maroon bag.
pale fuchsia bags contain 5 striped coral bags, 5 dim tomato bags.
dull green bags contain 3 mirrored yellow bags, 2 bright lavender bags, 2 faded coral bags, 4 light bronze bags.
clear coral bags contain 1 mirrored black bag, 5 light chartreuse bags.
clear fuchsia bags contain 1 clear plum bag, 3 faded maroon bags.
drab gray bags contain 1 wavy tomato bag, 3 dark cyan bags.
wavy lavender bags contain 1 dim lavender bag, 3 clear turquoise bags.
dark tomato bags contain 3 dark red bags, 4 mirrored red bags, 1 plaid plum bag, 2 dark turquoise bags.
shiny maroon bags contain 2 plaid tomato bags, 2 posh magenta bags.
plaid bronze bags contain 3 light beige bags.
dim magenta bags contain 1 clear gold bag, 5 dark orange bags, 3 striped red bags.
pale aqua bags contain 1 vibrant beige bag, 3 vibrant maroon bags.
dim red bags contain 1 vibrant silver bag, 3 dark teal bags, 4 muted olive bags, 3 shiny beige bags.
shiny lavender bags contain 4 dim indigo bags, 4 muted brown bags, 4 dim tan bags, 3 dull white bags.
wavy turquoise bags contain 5 dim salmon bags, 1 light aqua bag, 3 vibrant salmon bags.
posh green bags contain 1 drab purple bag.
dim fuchsia bags contain 3 muted white bags, 3 pale bronze bags, 4 bright aqua bags.
wavy orange bags contain 5 muted tomato bags.
dark turquoise bags contain 2 plaid bronze bags.
shiny silver bags contain no other bags.
pale gold bags contain 5 posh turquoise bags, 3 posh gray bags, 1 wavy magenta bag, 2 posh beige bags.
dull chartreuse bags contain no other bags.
vibrant crimson bags contain 4 striped red bags, 3 light aqua bags, 5 shiny purple bags.
clear olive bags contain 3 shiny violet bags, 5 posh coral bags, 2 vibrant beige bags, 2 shiny salmon bags.
vibrant magenta bags contain 2 shiny blue bags, 2 dark brown bags, 5 dim teal bags, 5 pale purple bags.
faded orange bags contain 2 clear maroon bags, 4 posh tomato bags, 5 vibrant white bags, 3 shiny tan bags.
drab yellow bags contain 5 wavy maroon bags, 4 dotted fuchsia bags.
wavy purple bags contain 2 pale lavender bags, 4 faded indigo bags, 5 dotted lavender bags, 3 dim tomato bags.
drab beige bags contain 4 dark yellow bags, 5 drab indigo bags, 4 faded yellow bags.
wavy tomato bags contain 3 dim tan bags.
vibrant beige bags contain 2 bright aqua bags, 2 dull chartreuse bags.
dull bronze bags contain 3 dotted lavender bags, 3 shiny violet bags, 5 bright blue bags.
striped gold bags contain 3 dim white bags, 3 drab aqua bags, 4 dotted indigo bags, 5 vibrant black bags.
shiny yellow bags contain 1 dotted fuchsia bag.
mirrored salmon bags contain 3 wavy blue bags, 2 striped green bags, 3 dull beige bags, 5 light tan bags.
clear red bags contain 5 vibrant lime bags, 1 faded maroon bag, 2 striped lavender bags.
pale black bags contain 4 mirrored crimson bags, 3 drab lavender bags, 4 drab blue bags.
wavy green bags contain 2 drab lavender bags, 4 light teal bags, 1 mirrored chartreuse bag.
muted crimson bags contain 3 dim aqua bags.
dull red bags contain 2 pale cyan bags, 5 dotted indigo bags, 4 drab violet bags.
dull purple bags contain 2 dull gray bags, 3 dim turquoise bags.
dull beige bags contain 3 bright white bags, 2 dark orange bags, 3 dull chartreuse bags.
light silver bags contain 2 muted gold bags, 2 clear chartreuse bags, 1 faded maroon bag, 2 pale plum bags.
mirrored turquoise bags contain 3 faded black bags, 4 light teal bags, 2 striped plum bags.
wavy blue bags contain 3 faded indigo bags, 2 wavy white bags, 2 bright aqua bags, 5 light yellow bags.
faded lime bags contain 2 drab black bags, 4 shiny indigo bags, 2 light black bags, 1 dim green bag.
plaid brown bags contain 5 light turquoise bags.
drab gold bags contain 1 mirrored silver bag, 3 dark coral bags, 2 muted green bags.
vibrant aqua bags contain 5 muted salmon bags, 2 clear gray bags.
clear turquoise bags contain 4 dark coral bags.
dark cyan bags contain 2 mirrored silver bags, 1 wavy blue bag, 5 vibrant purple bags.
striped indigo bags contain 3 dim violet bags, 2 bright aqua bags, 5 shiny orange bags.
wavy red bags contain 4 dim indigo bags, 5 light gold bags.
clear cyan bags contain 1 muted cyan bag, 1 muted magenta bag, 2 faded cyan bags.
shiny violet bags contain 1 mirrored bronze bag, 3 wavy red bags.
wavy indigo bags contain 1 vibrant cyan bag.
posh fuchsia bags contain 1 dotted silver bag.
mirrored white bags contain 2 shiny fuchsia bags, 5 drab indigo bags.
dotted black bags contain 4 clear magenta bags, 2 dim plum bags, 5 dim red bags.
vibrant turquoise bags contain 3 dim aqua bags.
bright green bags contain 3 drab black bags, 3 light magenta bags, 3 dark purple bags.
bright crimson bags contain 5 faded indigo bags, 2 dim indigo bags, 4 pale purple bags.
posh beige bags contain 5 dim orange bags, 2 vibrant chartreuse bags, 2 bright crimson bags.
faded white bags contain 5 drab fuchsia bags, 4 faded cyan bags.
striped turquoise bags contain 1 muted olive bag.
bright chartreuse bags contain 5 plaid turquoise bags, 1 muted tomato bag, 1 bright gold bag.
muted red bags contain 2 faded maroon bags, 2 light chartreuse bags, 5 dark olive bags.
dull turquoise bags contain 1 striped lavender bag, 5 dark purple bags, 3 dim coral bags.
pale yellow bags contain 5 muted indigo bags, 2 dull black bags.
dim indigo bags contain 5 bright aqua bags, 1 shiny silver bag, 2 drab purple bags, 1 muted aqua bag.
faded blue bags contain 1 pale maroon bag, 3 faded maroon bags.
plaid olive bags contain 2 plaid cyan bags, 3 dim plum bags, 2 bright salmon bags.
drab black bags contain 1 faded black bag, 4 light yellow bags, 4 dim bronze bags, 4 drab indigo bags.
vibrant plum bags contain 5 mirrored lime bags, 4 dim yellow bags, 4 posh tomato bags, 3 light gold bags.
dotted lime bags contain 5 posh lavender bags, 5 faded purple bags, 4 dim salmon bags, 3 clear tomato bags.
pale turquoise bags contain 1 muted tan bag, 5 dark orange bags, 4 vibrant salmon bags, 5 dim bronze bags.
drab blue bags contain 2 posh white bags, 1 muted aqua bag, 2 light fuchsia bags.
faded olive bags contain no other bags.
posh black bags contain 2 faded bronze bags, 5 mirrored red bags, 3 dim gray bags.
shiny orange bags contain 5 dark olive bags, 5 drab indigo bags, 3 faded indigo bags, 3 striped brown bags.
mirrored blue bags contain 3 posh crimson bags, 2 striped lavender bags, 2 mirrored yellow bags.
drab purple bags contain 2 light teal bags, 5 striped magenta bags, 3 striped aqua bags.
bright gray bags contain 2 striped tan bags, 4 bright coral bags.
dim gold bags contain 2 dull brown bags, 5 mirrored crimson bags, 2 bright tomato bags.
posh aqua bags contain 2 bright magenta bags, 5 posh orange bags, 2 wavy silver bags, 1 posh plum bag.
wavy gold bags contain 2 drab purple bags, 5 posh plum bags.
wavy lime bags contain 4 drab teal bags, 5 drab bronze bags, 1 wavy maroon bag, 4 wavy silver bags.
muted black bags contain 5 drab gray bags, 3 pale salmon bags, 3 dull indigo bags, 3 pale brown bags.
bright aqua bags contain 3 dim salmon bags, 1 dark orange bag.
vibrant brown bags contain 3 dim gray bags.
striped teal bags contain 1 muted tan bag, 2 pale plum bags.
drab olive bags contain 2 dotted lavender bags, 1 muted green bag, 4 wavy gray bags.
shiny blue bags contain 1 pale turquoise bag, 3 faded olive bags.
dotted yellow bags contain 5 dim blue bags, 2 vibrant silver bags.
vibrant lavender bags contain 3 posh fuchsia bags, 4 mirrored crimson bags, 5 posh gray bags.
bright black bags contain 2 striped blue bags.
pale salmon bags contain 5 bright maroon bags.
dull white bags contain 2 striped salmon bags, 4 wavy turquoise bags.
faded teal bags contain 3 vibrant brown bags.
shiny olive bags contain 3 muted tomato bags, 5 light cyan bags.
shiny chartreuse bags contain 3 pale olive bags, 2 vibrant chartreuse bags, 3 striped cyan bags.
muted turquoise bags contain 3 light white bags, 4 pale maroon bags.
bright tomato bags contain 2 mirrored bronze bags, 3 light aqua bags, 4 bright aqua bags.
light black bags contain 4 mirrored chartreuse bags.
bright turquoise bags contain 4 shiny silver bags, 4 wavy blue bags.
dim coral bags contain 2 dull coral bags, 1 shiny yellow bag, 2 dark lavender bags, 3 light magenta bags.
clear indigo bags contain 2 faded maroon bags.
vibrant coral bags contain 3 mirrored teal bags.
dark red bags contain 3 drab lavender bags.
posh chartreuse bags contain 3 posh bronze bags, 1 posh crimson bag, 5 dark gray bags, 4 dark silver bags.
shiny purple bags contain 2 dull silver bags, 4 light aqua bags, 4 posh white bags, 1 clear chartreuse bag.
dull crimson bags contain 4 bright blue bags.
vibrant cyan bags contain 4 pale maroon bags, 4 mirrored yellow bags, 4 dark teal bags.
pale magenta bags contain 1 bright lavender bag, 5 wavy gray bags, 2 dark bronze bags.
shiny black bags contain 2 striped blue bags, 3 shiny brown bags.
pale lavender bags contain 3 dark gray bags, 4 vibrant beige bags, 1 dull coral bag.
dark beige bags contain 2 vibrant tomato bags, 1 shiny chartreuse bag, 4 light coral bags, 1 light violet bag.
bright violet bags contain 3 plaid lavender bags, 2 faded white bags.
pale silver bags contain 5 faded maroon bags, 5 clear coral bags, 3 light beige bags.
clear tan bags contain 4 wavy tan bags.
striped white bags contain 2 drab indigo bags, 1 faded olive bag, 3 dull chartreuse bags, 3 dotted beige bags.
muted chartreuse bags contain 4 bright crimson bags, 1 dull bronze bag, 1 dark aqua bag.
plaid black bags contain 2 striped brown bags, 5 wavy crimson bags, 4 plaid olive bags.
muted olive bags contain 1 posh white bag, 2 plaid plum bags.
dim brown bags contain 3 wavy lime bags, 2 bright orange bags, 4 striped aqua bags, 3 bright teal bags.
striped silver bags contain 2 wavy tan bags, 1 light coral bag.
drab tomato bags contain 2 dotted fuchsia bags, 4 plaid aqua bags.
dim chartreuse bags contain 5 pale beige bags, 5 bright brown bags, 1 dull lavender bag.
clear lavender bags contain 5 wavy maroon bags, 5 drab coral bags, 5 muted tan bags.
light magenta bags contain 4 wavy white bags, 2 pale salmon bags, 5 muted gold bags, 2 pale cyan bags.
pale crimson bags contain 5 striped blue bags, 4 pale lavender bags.
plaid crimson bags contain 5 mirrored black bags, 5 pale magenta bags, 4 wavy plum bags, 3 bright green bags.
pale cyan bags contain 5 light tan bags, 1 drab purple bag.
pale teal bags contain 4 wavy magenta bags.
wavy salmon bags contain 3 muted aqua bags, 1 dull purple bag, 1 drab teal bag, 2 dull gray bags.
plaid blue bags contain 4 plaid gray bags, 4 dim fuchsia bags, 3 muted purple bags.
dotted magenta bags contain 3 dotted lavender bags, 4 striped magenta bags.
striped olive bags contain 3 striped teal bags, 5 faded maroon bags, 4 plaid maroon bags, 4 muted gold bags.
dotted turquoise bags contain 3 dull cyan bags, 3 shiny yellow bags, 1 striped maroon bag.
dotted plum bags contain 5 bright plum bags, 4 shiny yellow bags.
pale bronze bags contain 3 faded salmon bags, 5 muted gray bags, 5 shiny beige bags.
mirrored beige bags contain 1 vibrant gold bag, 2 posh plum bags, 1 plaid purple bag.
vibrant purple bags contain 4 bright crimson bags, 3 faded coral bags, 2 striped lavender bags, 3 wavy turquoise bags.
dim tan bags contain 4 posh indigo bags.
faded violet bags contain 3 clear silver bags, 5 faded salmon bags.
dim turquoise bags contain 5 light beige bags.
faded salmon bags contain 5 shiny purple bags, 3 dim bronze bags, 2 light aqua bags, 5 posh indigo bags.
dull gray bags contain 4 dotted magenta bags.
dark purple bags contain 4 striped magenta bags, 4 faded maroon bags.
muted silver bags contain 5 posh lavender bags.
drab green bags contain 3 dotted tomato bags, 4 muted gray bags, 1 dim maroon bag, 1 plaid chartreuse bag.
mirrored indigo bags contain 4 shiny crimson bags.
muted purple bags contain 4 plaid plum bags, 4 dull gray bags.
plaid indigo bags contain 5 drab bronze bags, 3 light turquoise bags, 1 dull chartreuse bag, 5 bright blue bags.
drab bronze bags contain 5 light cyan bags, 1 faded yellow bag.
clear violet bags contain 5 bright silver bags, 3 mirrored yellow bags.
faded brown bags contain 5 wavy red bags, 3 muted aqua bags.
dotted red bags contain 4 clear chartreuse bags.
drab teal bags contain 5 striped aqua bags, 3 pale salmon bags.
wavy beige bags contain 3 bright brown bags.
striped green bags contain 3 wavy blue bags, 5 light aqua bags, 4 light tan bags, 3 mirrored lime bags.
dark blue bags contain 2 bright crimson bags, 3 striped salmon bags.
dark bronze bags contain 3 plaid yellow bags, 2 wavy white bags.
clear crimson bags contain 5 dull white bags, 5 plaid crimson bags, 3 mirrored yellow bags, 3 wavy lime bags.
dark lavender bags contain 1 striped green bag.
light maroon bags contain 1 faded fuchsia bag.
dull coral bags contain 1 mirrored lavender bag.
plaid cyan bags contain 5 faded maroon bags, 2 light indigo bags, 4 light brown bags.
drab fuchsia bags contain 4 drab turquoise bags, 2 bright white bags, 3 vibrant chartreuse bags, 2 posh white bags.
clear orange bags contain 5 clear red bags.
posh plum bags contain 4 dim indigo bags, 4 muted coral bags, 1 light aqua bag, 5 muted tomato bags.
dotted salmon bags contain 5 drab aqua bags, 2 faded cyan bags, 4 light red bags, 2 shiny aqua bags.
clear aqua bags contain 2 shiny red bags, 2 pale white bags.
clear yellow bags contain 2 dark orange bags, 4 light silver bags, 1 plaid fuchsia bag.
striped lime bags contain 1 drab lime bag.
posh silver bags contain 4 posh yellow bags, 4 light orange bags, 3 striped fuchsia bags, 5 dull silver bags.
wavy black bags contain 5 dim crimson bags, 3 muted violet bags.
dull silver bags contain 4 vibrant silver bags, 4 dim salmon bags, 4 drab lavender bags.
light lavender bags contain 4 bright lavender bags, 3 dim gray bags, 4 drab lime bags.
posh tomato bags contain 4 dark bronze bags, 4 dull silver bags, 5 dull bronze bags.
wavy brown bags contain 2 clear lime bags, 3 mirrored tan bags, 2 dull coral bags.
clear salmon bags contain 5 dull white bags, 4 drab purple bags, 3 shiny violet bags, 3 plaid chartreuse bags.
bright beige bags contain 2 dull tomato bags, 2 drab chartreuse bags.
dull cyan bags contain 5 bright plum bags, 5 light lavender bags.
light turquoise bags contain 4 muted green bags, 4 wavy maroon bags, 5 dotted beige bags.
dark maroon bags contain 2 bright fuchsia bags, 5 dull crimson bags, 5 plaid crimson bags.
vibrant black bags contain 3 muted red bags.
wavy aqua bags contain 3 pale plum bags, 5 shiny lime bags.
plaid turquoise bags contain 3 shiny red bags, 5 bright tomato bags, 3 muted olive bags, 5 pale maroon bags.
dull tomato bags contain 3 dim yellow bags, 4 posh violet bags, 4 plaid yellow bags.
drab maroon bags contain 4 drab olive bags.
dark orange bags contain 2 clear gold bags, 1 striped aqua bag, 2 muted aqua bags, 2 striped magenta bags.
vibrant chartreuse bags contain 1 dim indigo bag, 1 drab purple bag, 2 shiny gold bags, 3 faded salmon bags.
striped chartreuse bags contain 3 drab gray bags, 1 drab red bag.
plaid tomato bags contain 2 dark gray bags, 5 dim bronze bags.
drab red bags contain 4 light silver bags, 2 drab turquoise bags, 1 striped lavender bag.
clear green bags contain 1 vibrant magenta bag, 3 plaid beige bags, 2 mirrored tan bags.
dull teal bags contain 1 vibrant green bag.
vibrant fuchsia bags contain 2 dull purple bags, 1 drab gold bag, 5 light aqua bags.
vibrant salmon bags contain no other bags.
posh teal bags contain 2 light magenta bags, 4 dotted fuchsia bags.
mirrored gold bags contain 1 posh crimson bag, 5 dull beige bags, 3 plaid salmon bags.
pale orange bags contain 2 plaid violet bags.
vibrant maroon bags contain 3 drab teal bags.
faded coral bags contain 4 muted gold bags, 2 posh white bags, 5 plaid plum bags, 4 mirrored lime bags.
vibrant teal bags contain 3 faded black bags, 2 posh green bags, 3 plaid fuchsia bags.
shiny red bags contain 2 striped orange bags, 2 light purple bags.
mirrored cyan bags contain 4 muted bronze bags, 1 shiny green bag.
dotted silver bags contain 2 striped indigo bags, 2 dotted magenta bags, 3 striped plum bags, 2 faded brown bags.
mirrored purple bags contain 2 plaid red bags, 3 dotted beige bags, 3 drab black bags.
clear lime bags contain 5 faded salmon bags.
muted fuchsia bags contain 2 dim gold bags, 2 clear gray bags, 1 posh red bag, 2 drab indigo bags.
mirrored lime bags contain 1 drab turquoise bag, 4 dark yellow bags.
bright teal bags contain 3 wavy plum bags, 3 plaid red bags, 2 bright tomato bags.
dark teal bags contain 2 muted coral bags, 1 light tan bag, 5 dotted tan bags.
faded plum bags contain 4 pale indigo bags, 1 bright plum bag, 2 shiny crimson bags.
vibrant tan bags contain 3 muted violet bags.
shiny magenta bags contain 4 posh tan bags, 4 mirrored tan bags, 3 plaid chartreuse bags.
vibrant orange bags contain 1 vibrant crimson bag, 3 shiny tan bags, 4 dark crimson bags, 1 dotted silver bag.
muted aqua bags contain no other bags.
clear silver bags contain 2 faded olive bags, 5 vibrant purple bags.
plaid fuchsia bags contain 4 vibrant beige bags, 1 mirrored bronze bag.
muted gold bags contain 2 striped aqua bags, 1 light yellow bag.
posh cyan bags contain 2 vibrant gold bags, 2 light lavender bags, 5 striped green bags.
bright tan bags contain 3 pale maroon bags, 4 dim coral bags.
drab crimson bags contain 3 mirrored chartreuse bags, 5 faded maroon bags, 3 dotted magenta bags, 4 bright brown bags.
dotted coral bags contain 4 muted aqua bags, 1 striped white bag, 1 dim bronze bag.
dotted gray bags contain 1 mirrored white bag.
shiny beige bags contain 2 dim tan bags.
light brown bags contain 1 dim violet bag.
shiny fuchsia bags contain 3 dark teal bags, 4 drab purple bags, 2 mirrored bronze bags, 2 dim salmon bags.
wavy magenta bags contain 4 vibrant gray bags, 5 clear salmon bags.
light teal bags contain 1 dull beige bag.
dark yellow bags contain 1 clear chartreuse bag, 4 mirrored bronze bags, 4 dim salmon bags, 4 wavy white bags.
bright fuchsia bags contain 1 pale magenta bag, 5 muted plum bags.
muted cyan bags contain 2 shiny tan bags, 5 mirrored blue bags, 1 mirrored chartreuse bag, 2 plaid chartreuse bags.
dim aqua bags contain 4 pale bronze bags, 2 muted blue bags, 3 clear red bags, 3 light lavender bags.
pale brown bags contain no other bags.
plaid salmon bags contain 3 posh coral bags, 3 dim white bags, 2 drab olive bags, 4 shiny violet bags.
dull fuchsia bags contain 5 striped red bags, 1 pale black bag.
light purple bags contain 3 plaid orange bags, 5 vibrant red bags.
dotted lavender bags contain 2 light gold bags, 3 shiny gold bags, 3 dim tan bags.
dotted gold bags contain 1 muted gray bag.
wavy cyan bags contain 1 drab teal bag, 2 wavy yellow bags, 1 striped blue bag, 3 dull blue bags.
striped orange bags contain 1 striped lavender bag, 1 posh white bag, 5 bright aqua bags, 2 shiny silver bags.
clear bronze bags contain 2 striped gold bags, 3 light tomato bags.
mirrored teal bags contain 1 bright lavender bag, 4 dim green bags, 4 bright brown bags.
vibrant green bags contain 4 vibrant violet bags, 5 pale bronze bags.
muted gray bags contain 5 pale brown bags, 5 mirrored bronze bags, 3 dim tan bags, 3 bright white bags.
shiny brown bags contain 3 light chartreuse bags.
pale maroon bags contain 3 drab lavender bags, 1 bright turquoise bag, 1 dim tan bag.
light fuchsia bags contain 4 plaid bronze bags.
pale olive bags contain 4 striped teal bags.
plaid lavender bags contain 5 posh gold bags.
light yellow bags contain 4 striped aqua bags, 1 dotted aqua bag, 2 dark orange bags, 4 faded olive bags.
dull indigo bags contain 2 bright indigo bags, 2 dotted plum bags, 3 pale black bags, 5 pale turquoise bags.
light white bags contain 2 bright brown bags, 3 pale brown bags, 1 faded olive bag.
mirrored crimson bags contain 2 faded maroon bags, 2 dim maroon bags, 5 faded indigo bags, 2 striped aqua bags.
dim black bags contain 1 muted silver bag, 4 plaid magenta bags, 3 muted fuchsia bags, 4 dim olive bags.
dotted fuchsia bags contain 3 mirrored salmon bags, 3 drab purple bags.
faded tomato bags contain 4 dim gold bags, 4 light olive bags.
vibrant bronze bags contain 5 mirrored turquoise bags.
faded red bags contain 1 bright bronze bag, 2 dotted aqua bags.
vibrant silver bags contain 2 dull chartreuse bags, 3 faded olive bags, 1 shiny blue bag.
muted green bags contain 2 posh lavender bags, 2 faded indigo bags, 2 mirrored black bags, 5 clear magenta bags.
pale chartreuse bags contain 2 wavy olive bags, 5 faded orange bags, 1 pale indigo bag, 4 bright plum bags.
dim bronze bags contain 4 striped magenta bags, 5 faded olive bags, 4 pale brown bags, 4 muted tan bags.
posh purple bags contain 3 posh indigo bags, 4 faded white bags, 1 dull salmon bag, 2 pale aqua bags.
drab coral bags contain 5 posh red bags, 4 clear plum bags, 1 faded tomato bag, 5 wavy maroon bags.
striped fuchsia bags contain 3 pale brown bags.
striped blue bags contain 4 drab lavender bags, 2 plaid gray bags.
posh indigo bags contain 2 muted white bags, 5 striped aqua bags.
mirrored magenta bags contain 4 posh tan bags, 1 light magenta bag.
dim blue bags contain 4 vibrant purple bags.
striped maroon bags contain 5 drab black bags, 2 bright beige bags, 5 posh tomato bags, 3 plaid red bags.
dark lime bags contain 3 drab indigo bags, 1 bright teal bag.
clear plum bags contain 1 pale cyan bag, 3 wavy white bags.
muted brown bags contain 3 light indigo bags, 3 light olive bags, 1 light lavender bag.
posh lavender bags contain 2 striped magenta bags.
striped tan bags contain 4 pale bronze bags, 3 dull aqua bags.
dim cyan bags contain 3 dark violet bags, 2 dull brown bags.
dotted teal bags contain 5 posh gray bags, 2 posh purple bags, 1 vibrant gray bag.
muted yellow bags contain 1 plaid red bag, 3 faded black bags.
dotted beige bags contain 2 dotted tan bags.
wavy plum bags contain 2 mirrored black bags.
wavy olive bags contain 4 shiny silver bags.
dotted orange bags contain 2 faded indigo bags, 3 posh lavender bags, 5 plaid fuchsia bags, 1 bright magenta bag.
dim tomato bags contain 2 faded olive bags, 3 posh tan bags.
light tan bags contain 5 drab lavender bags, 2 striped lavender bags, 3 posh indigo bags, 3 shiny silver bags.
posh orange bags contain 3 vibrant green bags, 1 dim orange bag, 5 dull silver bags, 5 wavy orange bags.
plaid maroon bags contain 5 dim gray bags, 3 muted red bags, 5 posh violet bags, 3 dark green bags.
dark white bags contain 4 drab chartreuse bags, 2 striped lavender bags, 4 dull aqua bags.
vibrant indigo bags contain 1 clear plum bag.
"""
}
