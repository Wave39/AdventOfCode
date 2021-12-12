//
//  Puzzle_2021_10.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/10

import Foundation

public class Puzzle_2021_10: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.final)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.final)
    }

    private func isOpeningCharacter(_ char: Character) -> Bool {
        char == "(" || char == "{" || char == "[" || char == "<"
    }

    private func isClosingCharacter(_ char: Character) -> Bool {
        char == ")" || char == "}" || char == "]" || char == ">"
    }

    private func solvePart1(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        var score = 0
        let scoreDict: [Character: Int] = [")": 3, "}": 1_197, "]": 57, ">": 25_137]
        for line in arr {
            var stack: [Character] = []
            for char in line {
                if isOpeningCharacter(char) {
                    stack.append(char)
                } else if isClosingCharacter(char) {
                    if let lastChar = stack.last {
                        if (char == ")" && lastChar != "(") || (char == "}" && lastChar != "{") || (char == "]" && lastChar != "[") || (char == ">" && lastChar != "<") {
                            score += scoreDict[char] ?? 0
                            break
                        } else {
                            stack.removeLast()
                        }
                    }
                }
            }
        }

        return score
    }

    private func solvePart2(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        var incompleteLines: [[Character]] = []
        for line in arr {
            var lineIsCorrupt = false
            var stack: [Character] = []
            for char in line {
                if isOpeningCharacter(char) {
                    stack.append(char)
                } else if isClosingCharacter(char) {
                    if let lastChar = stack.last {
                        if (char == ")" && lastChar != "(") || (char == "}" && lastChar != "{") || (char == "]" && lastChar != "[") || (char == ">" && lastChar != "<") {
                            lineIsCorrupt = true
                            break
                        } else {
                            stack.removeLast()
                        }
                    }
                }
            }

            if !stack.isEmpty && !lineIsCorrupt {
                incompleteLines.append(stack)
            }
        }

        let scoreDict: [Character: Int] = ["(": 1, "{": 3, "[": 2, "<": 4]
        var scores: [Int] = []
        for var line in incompleteLines {
            var score = 0
            while !line.isEmpty {
                if let lastChar = line.last {
                    score *= 5
                    score += scoreDict[lastChar] ?? 0
                    line.removeLast()
                }
            }

            scores.append(score)
        }

        scores.sort()
        return scores[scores.count / 2]
    }
}

private class Puzzle_Input: NSObject {
    static let testValid = """
()
[]
([])
{()()()}
<([{}])>
[<>({}){}[([])<>]]
(((((((((())))))))))
"""

    static let testCorrupt = """
(]
{()()()>
(((()))}
<([]){()}[{}])
"""

    static let test = """
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
"""

    static let final = """
{<{[<((<[<({<{(){}}(()())>[<<><>>((){})]}(<<{}{}>(<><>)>))(<[(<>{}){()()}]{{{}[]}(()())}>[
((<{[<([<<{[<(()())([]())>)<<<{}{}>{[][]}>{<<>>(()[])}>}<(((()[])[{}<>])[<[]{}>{{}[]}])[[({}{})
({(<[([((<(<[(<>{}){()[]}]<[[]<>]<(){}]>><{(<>())[<>{}]}{(<>[])(<>{})}>)([(<(){}>[(){}]){{()[]}{<>{}}}][<<[]
{{{[(([{{{[{[(()())[<>[]]]{([]{}){()<>}}}]{{{((){})[[][]]}[[{}{}]<[]()>]}(<(<>()){{}{}>>([{}()
[<{{{[[(<[(([<{}[]>{()()}][[<>{}]]))]([<<{{}[]}>>([(<>[])<(){}>][[{}{}](()())])]{[{[<><>]}((<>{})[
{<[<[[<<(<<<<(<>[])(<>[])>{([]())}>[{{[]()}}<({}())[<>()]>]>{[((<>{})[[]<>])([()<>]{<>()})](((<>()
([({({[{(([<[<[]>]>]<<({[]()}<[]<>>)[[()[]]{[]{}}]>>))((<<{<<><>>}{(<>{})<[]()>}>([[<>{}]<<>{}>
{(<([{{{{(((({{}[]}))){[(({}<>))({<><>}<[][]])][<<[]{}>[{}{}]>{<[]>{[]{}}}]})({[{([]<>)([]<>)}
{([{{{(([<[[[<(){}>{()[]}][([]<>)<[]{}>]]<{(<>())[[]()]}[{(){}}[()<>]]>]([({[]{}}{()[])){{<>()}{()[]}}])>[<[
[([{<{(<({<{[[<>{}][<>[]]]<{{}<>}<{}{}>>}[({()[]])[[<>()]({}<>)]]>{<([{}<>]<[]<>>)[{[]()}{{}[]}]>[[{[][]
{{<(<{(<[<(((<[]<>><{}[]>))({(<>{}){[][]}}([[]()]({}<>))>)>[((((()<>)<<>[]>){(<>{}){<>{}}})(<({}(
{{[{<{<([{[<{[{}{}]{(){}}}{{[]<>}<()[]>}>]<[({[][]}<{}<>>)(<{}{}><[]()>)]<[{<>{}}(()())]([[]{}]<[]<>>)>>>[{[{
<(([<<{{<(([(({}{})[[]{}])[<{}>(<>{})]]<([{}{}]{()[]})>))({(<(()<>)<<><>>>(([]<>)))}<<<[()
<<<(({{([{({({()()}<<>[]>)<{()[]}[<>()>>}){[<[<>{}][<><>]>[{()[]}[<><>]]]<<[<>[]]{<>()}>>}}[(<[[(){}](()
<<[[{{([(([([[<>{}][(){}]])]{({{()}(<>{})}{{{}<>}{<><>}})(([<><>])({{}[]}<<><>>))})([{({()<>}<[][]>)}]))
[(<<<<<{[<({[{{}[]}<()<>>]<[{}[]][[]<>]>})>[<<{(()())({}<>)}{({}())(<>[]]}><<<{}<>>([]<>)><[
<<({({{([(<([[{}()]<[]{}>]<<<>()>>)><{(<{}<>><{}()>)<{(){}}[<>]>}{([[]{}][[]<>])<({}()){{}[
{<{([[[[[{<<[[{}{}]([]<>)]{{{}()}[<><>]}><[<()()>[{}{}]](((){})<()>>>>}]<{({{([]()){{}<>}}<{<>{}}({}{}
{[{[[<[((<(<<{<>}{()[]}>><{<<>[]>[()[]]}{{()()}[()[]]}>)(({[[]](<>[])}{({}())<{}()>})([[{}[]]<[]()>][{
[{[(({[{{([[[<()()>{{}{}}]{([]<>){<><>}}]](<<<(){}>(()())>{[[]]{<>{}}>>))<[<((<>{}){(){}}){[{}<>]}>([[<><
<{<(<([(<[({<<[]()>[[]{}]>(<{}<>>)}(<[{}[]][{}[]]>{<{}[]>[(){}]}))[<(<[]<>>{{}<>}]([[][]]<()<>>)>{({{}<>}[<>[
{({({{<({[{[{<<>()>[[]{}]}](([{}<>]{()()})[([]()){[]()}})}[[((()())[()<>])(<<>{}><{}>)]]]<([{([]
(<[([{({<([<(([]<>)<()[]>){{<>{}}[()()]}>])(([({[]()}<{}{}>)][<{{}[]}({})>[[<><>][<><>]]])<[({()[]}[[]{
{{{<{{[[{[[<({[]()}{()[]})<[<>()][()()]>>(({{}{}}))][({[(){}](()[]]}){{<<>()>({})}{<{}[]>[{}<>]}}]]{[<
{<([((<{<<<{(({}{})<<>[]>)(((){}){[]})}{({[]<>}[[]{}])<[{}[]][()()]>}}[{([<>()][<>{}]){(<>
{([([(({[<[[[(())(<>[])]{[()()][<>]}]]>([{[(<><>)(<>())]<(()<>)[<><>]>}({{<>{}}({})}([{}][
([[[({[{{<{{{[{}()]{(){}}}[{()}({}[])]}[{[[]<>>(()[])}<{[][]}{[]}>]}>}}]}{[<[[[[(({}{}){{}[]}
<[{<([<({((([[<>{}]([]())]<[()[]]<()<>>>){<<{}{}>[<><>]>[((){}){{}<>}]}))}({[({[()())(<>[])}{({}())}){([()[]
{([[{[<<[[<{([<>()][{}{}])<([]{})(()[])>}{{{()()}{[][]}}<[[]{}]<<>{}>>}>(({<()()>({}())}[{<>[]}({}<>)])([[<
({[<{{[<{{(((([]<>){<>()})([()<>]([]{})))){{<{()()}[{}<>]>}({<{}[]>}{([]<>)<{}[]>})}}<<([{{}()}[{}[]]]<{(
<({{([{[({<([({}())[()[]]]{([]{})})(([[]{}]{{}[]})([{}()><()<>>))>(<(({}{})<{}{}>)[{<><>}{[]
[{[{<{([[[<[[{[][]}(<>{})]{{[]<>}[{}{}]}]><{({{}()}<[]()})}>]{{(<[[][]]{[]()}>{(()())(<>[])})(
(<{(<[[<{[[<<([]<>)<{}{}>>({{}[]}({}()))>]({([[]<>]([]())){[<>{}]<{}()>}}[{({}())[(){}]}(({}{})[[]]
<[<<([{[{<{{<[[][]]<<>[]>>({<>{}}[<><>])}([[{}<>]<()()>][<[][]>(()[])])}[({[()()][[]()]}[{{}()}<[]<>>])]>{<
<(([[{(([[([[{{}()}{[]}]]<((<><>}({}[]))((()())[()[]])>)[{{<[]<>>((){})}}<(<(){}>{{}[]})({()}{{}<>})>]]<[(<{
[{<(((<(<({(({{}()}{<><>})[{[][]}{(){}}])({{[]{}}[<>{}]>)})>((([<(<><>){{}<>}><[<>{}]>]([[<>[]][{}{}
[<{{({([({({{{()<>}([][])>}((({}<>)(()[]))<(<>()){{}<>}>)){[([()()](<>[]))]{({[]}[[]{}])([[]<>
{({[<{(<<([[[<{}{}>[{}{}]](<<>>(()))]{[([]<>)<{}{}>]<[<><>]>}]<[[{{}<>}<<>{}>][([]<>)<(){}
([{{{[[(<<[<[[<>]{[]}]((<>{})({}[]))>({{()[]}<<><>>}{{<>{}}({})})]{{{{[][]}<{}()>}}<[[<><>][{}<>]]<
[<{<{<[{{[([(([]<>))[{<>()}<{}{}>]]{[<<>{}>[(){}]){<[][]>[<><>]}})](([<([]{})[{}()]>(({}())(<>{}))]
[<[<{(<(([{<{([]{}){[][]}}><{[{}[]]([]<>)}[[()[]]<()()>]>}][{(<[(){}]{()<>}><<[]()>[[]()]>){[[<>[]](()[])
<(<<<([[<([[({[]<>}<[]()>){{<>[]}[{}{}]}]([[[][]]<[]()>])]<{{(<><>){<>[]}}}{(<[][])(()[]))[([]{})[[
(([{<{{([<<{({[]{}}[()[]])[<()()><()[]>]}[(<()>[()()])[[<>[]]]]>>{{{{<[]()>[()<>]}}{{<()[]>[()[]]}<[[][]]
(<<[([[{{({<[([][])<{}()]][<()()>(()())]>})}<([[{(()<>)<[]()>}((()[])[<>{}])]]([<{(){}}({}<>)>][<
[<<((<[<<{(((({}()))({<>{}}([]<>))){{<()<>><{}[]>}{(()())}}){({([]<>)<<>{}>})}}<{{<[()][<><>]>{{[]
<{[<[((([{<{{{<>[]}[[]()]}([<><>])}>((<<<>()>({}<>)><[{}[]]<()[]>>)[{{[][]}{()<>}}[{()<>}(()[])]])}(([<{{
{<{<[(({([<[<[[][])([]{})>[{(){}}[[]<>]]][(<{}<>>{()<>}){[<><>]{{}[]}}]>([[<[][]>{[]<>}]({[][]}(()()))]{
(<{{{[{<{(<[({{}[]})]><<{(()<>)[{}{}]}{<()()>}>>)[[(({()<>}(<>{})))([<(){}>(()<>)]{((){})([][])})]
<<[(<([<(({[{({}{})}<{()<>}{<>{}}>][([[]()](()<>))]}[[({{}()}<[]{}>)[<[]()>[()()]]]((<{}{}
<<{[{[<{{{([<<<>{}>{()[]}>({{}[]}<<>{}>)][[<()[]>[{}[]]]({()<>}(()()))])[<<<<>()>{[]{}}>><{{[]{}}<()<>>}(<<>[
[{{<({[([({{{(()())[<><>]}{[()()][(){}]}}}{[([<>[]])[{[]()}((){})]]([<[]{}>(()<>)]{[<>]})})(<
<<<{{(({<{<[<<<>{}>>(<<>[]>{()()})]<([()<>])>>[(<({}[]){{}[]}>{[{}{}][[]()]})[<[<>[]]<()[]>>(<
[([<<<(<[[[[[([]{}){{}()}}<<[]()>{[]}>][([<>[]]({}))[(()<>){()()}]]]]]>{[([[<([]())<{}<>>>({<>()}
[([{{[[(({[<{[{}[]]{[][]]}<{<>()}[<>[]]>>(<{<>()}<[]()>>)]}))<<<<<{{()[]}{{}[]}}[<<>{}>]><{[{}<>]{(
[{{{<((([{([{[[]()][<>()]}([[]()]{{}()})]{([{}{}](<>{}))({()<>}(<>{}))})<[({(){}}[()<>])}>}(
{<<{{({[[[[[{[()]({})}<[<><>]{{}}}][[{()<>}({}{})][<<>[]>{<><>}]]]({<(<>)<<><>>>({<>()}<<>
<[[[[({([[{<[{{}()}]{(()<>)<[]()>}>{[{<>{}}(()[])][{()[]}<()()>]}}]]<{[(({<>{}}{<>()})<[[]()]<<>{}>>)<((()[])
({{{<{[({[[[<{()<>}<<>[]>>{[[]<>][<>()]}]([(()<>)[[]()]]({{}[]}(()[]))]]][{{{<<>>({}<>)}<<<>{}
[{[((<{<([[{<<()[]>[[][]]>}<{({})}[<{}[]>[[][]}]>]]<<{(([]<>)[[]()])}<{<{}()>{[]}}{[()[]]({})}>>
[{([[{[({<[<(<<>{}>({}[]))([{}<>]{(){}})}({<[][]>}{[()()]<{}[]>})]<<[<(){}>[<>{}]][<<>{}>({}{
[<([{<<[((([<[<>()]({}())><([]{})<{}[]>>]))[{[[[[]()]]]}{{[{[]()}([][])]{<[][]>{{}()}}}}])<(({{(<>()){
{{[[<{{(({{{(<{}<>>{()[]})[<[]()>]}[{<[]{}>[()[]]}]}<[{[[]<>][[][]]}<<(){}>((){})>][([()<>]<<>>)<
<<{[(([{<((({([][]){[]<>}}{({}())}))({[<<>{}><<>>]}{<[<>{}](()())><<{}[]>{()<>}>)))({[<(<>[
<[<((<<[[<[((([]<>)<(){}>)[<(){}>])({<{}{}>{<><>}}<(()())<[]{}>>)]{{({(){}}(()[]))}<({<><>}({}()))>}
[<{(<([{[({[{({}{})<{}()>}[{[]<>}({}<>)]]})[<[([{}[]][()[]])((<>()){{}<>})][[[(){}][[][]]][<
<(({([[(<[[{(<<><>><{}()>)<(()()){()[]}>}({[()<>][{}[]]}([<>{}]<<><>>)}]]{{[<[<>[]]>({<><>}([]{}))][(([][])<
{[[[[<<[{(({{{[]()}[{}[]]}}{[[()()][{}{}]]}){[{{{}()}}[[[][]]<()()>]]}){[{((()<>)[{}<>]){<<>()>[()()]}}(([{}<
[[<<<{<({[<([[()<>]]({()<>})){[{{}[]}]}>][({[<()<>>({}[])]}((<<><>>[<>])[({}())<{}{}>]))]})>}>[{{(({{[
{{[[{{(([[[[({[]()}<{}()>)<(()[])<<>[]>>]]<(<{[][]}<{}()>>(({})[[][]]))>]<<{({()[]}[(){}]]({
({{((<([<({<(<[]<>><<>[]>){[{}<>]}>(<[{}{}]>)}[<{{<>{}}{[]()}}[<<><>>[[][]]]>[[<()()><(){}>]{<
[[[(({{<(<{<[{()[]}]({<>{}})>[<<<>()>{{}{}}>{({}<>)<<>()>}]}<({{()()}}<(()()){<><>}>){<((){})(<>()
{<{{(<{{<[[({<<>>}<[(){}]({}())>)[<{()<>}[{}()]>[({}[])<()()>]]]]{<[({<>{}}{[][]})]{[(<>{})({}())]}
[<[<{<<({[[(((<>())[{}<>]))<(({}[])(()[])){{{}{}}[[]<>]}>]<[(<{}{}]{{}{}})<(()<>)>][[{<>{}}<[
[({<(<[([<({([<>()]{[][]}>{<<>[]>[[]()]}}[{<()<>>([]<>)}])<<<[[]()](())>><[<<>[]>{{}()}]{<()
{{[{(<<{[{({[<[]()>{{}<>}]([()<>]{{}[]})}<<<[]()>[[]<>]><[<>{}][()()]>>)}<{<[{[]()}{<>{}}]>{({[][]}<[]
[[{[<<<[{[[<({<>()}((){})){{<>[]}<(){}>}>[<(()<>)({}<>)>{<[]()>(<>)}]]]{<<{[<>[]]>>(<<{}()>(<>())>(
{({{[([<{{{<((<><>)<()()>][<{}[]>{<>[]}]><({<>()}(()<>))({{}[]}<()[]>)>}([({{}[]})({{}()}[<>[]])])}
{<[[({{((<[{[{<>()}(<>())]<({}[])<<>{}>>}([(()())<<>[]>]((<>[]){{}{}}))]{({<()()>(()<>)}[{[][]}([]())])<<[()
([{((({<<<{<{{<><>}(()<>)}>}>)[{{[[[[][]]]][<(<>{}){[]}>([{}()][[][]])]}<{([()()][<>()])(<[]()>
<(((<(({<<[{<(()())>[[[][]]<[]{}>]}[{{<>()}(<><>)}(({}())({}()))]]>((<({{}[]}(<>())){({}[])
<<{[(<([<(<{{[<>{}]}(<<>()>({}{}))}><({<<>()>(<><>)}<<[][]>[[]()]>)(([<>()){{}()})<[[][]]{<>{}
<<[[([{{{{[<{[(){}]<[]()>}>[[([])<[]<>>>[({}{})([][])]]]}<<({<()[]><{}<>>}<{()<>}(<><>)>)>(([
{[[[{{[{{((<{[{}[]](()[])}<(<>{})(<><>)>>){(<<<>{}>>)(([()[]]<[]{}})[({}[])(()())])})}}]}{[{{({({([]
([{[{((([[{{([[][]][{}[]])[{[]<>}<<>[]>]}}]][<[{[(<>{})[[]<>]][{[]<>}[(){}]]}]{<[[{}[]]{{}[]}]><(({}
{(<(<{<<([<<<[{}{}]<{}{}>>><[{<><>}{{}<>}]([[]<>]{{}()})>>])>>{{[{{{<<<>()>[{}()]>{<[]()>[<>{}]}}}}<(<[(
{<[{<<({[({(([[]<>](<><>)))[[[{}()]<()[]>]<{<>{}}[()<>]>]})([<([(){}]{<>[]})<<<>()><(){}>>><([<>[]>([][]))(<<
[[[[<<(<({(<[{(){}}[()[]]][[{}[]]{[]{}}]>([{[][]}([]{})][{{}[]}<[]()>]))[{[{()()}({})]({(){}}[<>[]
{<{(<[<(<<<{<[()<>]>{{()[]}}}<<([]<>)[()<>]>>>[{[<<><>>[{}<>]][<<><>>{(){}}]}[{[[]()]{<>()}}
<[[<{<<[{{[[(([][])[[][]])<({}<>){{}[]}>]](<<({}[])[[][]]>((<><>))>[([()[]]((){}))])}}{[([((<>())
{(<{[[((<<<{<{<>{}}([]{})><{()}>}[{(()<>)[[][]]}{<{}{}><{}{}>}]]<[[<{}()>]<([]{})>]{{[<>()]{{}{
<{<{<{[{(((<(<[]{}>)([{}{}]({}{}))>([{[]<>}[[]{}]]<([]()){[]<>}>))<[(<[]{}>[()[]])]>)<{{[{{
{{<([<{[(([(({[]<>}{()[]})<(()){(){}}>)[{({}<>)<[]<>>}<{{}()}<<><>>>>][{<({}<>)[()()]><<()<>>>
[[[<([<<[[[{<<[][]>{()()}>[[(){}][<><>]]}{[{<>[]}[[]{}]]}]{<<({}<>)[[]]>[(<>[])]><<[()[]]<[]>>[{[]<>}({}{})]>
{{{[{(<<{({{<{<>[]}>[{<><>}[()[]]]}[({()()})([<><>]<<>[]>)]}({[{{}[]}{{}[]}]}[(<[]()>[<>[]])({<><>}[(){}])]
(<<[{[{[({<[{{(){}}<(){}>}{{()[]}[<>{}]}]{{(<>{})<{}>}{((){})}}>[{([<>()](<>{}))<{{}[]}[[]{}]>}{(<[][
(<[[{<<{({<([<<>()>[<>()]]{{()<>}[<>[]]))>({<<<>()><()<>>>}({{[]<>}{{}()}}{<(){}><<>{}>}))})}<([<({[[]]{{}<
([((<[((([{<((()<>))[([])]>({(()<>)([]{})}([{}<>](()<>)))}{<[[[]()]([]{})]>}]({([{[]{}}][{(){}}{(){}
(({{<[<{<{([<([]<>){()}><([]<>)<[][]>>]<<[()<>][[]<>]><{()()}>>)[(<[[]{}](<>())>{{{}()}{[]()}}
"""
}