//
//  Puzzle_2021_08.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/8

import Foundation

public class Puzzle_2021_08: PuzzleBaseClass {
    // segments
    //  aaaa
    // b    c
    // b    c
    //  dddd
    // e    f
    // e    f
    //  gggg

    // segments  digit
    //    2        1
    //    3        7
    //    4        4
    //    5        2, 3, 5
    //    6        0, 6, 9
    //    7        8

    // digits   common segments  different segments
    // 2, 3, 5  a, d, g          b, c, e, f
    // 0, 6, 9  a, b, f, g       c, d, e

    // how to get segment:
    // a: get single 2 segment number (1), get single 3 segment number (7), find character in 7 not in 1
    // d: find 2 common segment characters in 5 segment numbers that are also in common segment characters in 6 segment numbers, leftover character in 5 segment commons is d
    // b: get single 2 segment number (1), get single 4 segment number (4), eliminate 1 characters, eliminate d character, leftover character is b
    // g: get 5 segment common characters, eliminate a character, eliminate d character, leftover character is g
    // f: get 6 segment common characters, eliminate a character, eliminate b character, eliminate g character, leftover character is f
    // c: get single 4 segment number (4), eliminate b character, eliminate d character, eliminate f character, leftover character is c
    // e: leftover character from all above

    private typealias Mapping = [String: String]

    private let displayDictionary: [String: String] = [
        "0": "abcefg",
        "1": "cf",
        "2": "acdeg",
        "3": "acdfg",
        "4": "bcdf",
        "5": "abdfg",
        "6": "abdefg",
        "7": "acf",
        "8": "abcdefg",
        "9": "abcdfg"
    ]

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

    private func solvePart1(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        var counter = 0
        for line in lines {
            let components = line.parseIntoStringArray(separator: " ")
            for idx in 11...14 {
                let stringLength = components[idx].count
                if stringLength == 2 || stringLength == 3 || stringLength == 4 || stringLength == 7 {
                    counter += 1
                }
            }
        }

        return counter
    }

    private func solvePart2(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        var mapping: Mapping

        var total = 0
        for line in lines {
            mapping = ["a": "", "b": "", "c": "", "d": "", "e": "", "f": "", "g": ""]
            let components = line.parseIntoStringArray(separator: " ")
            var inputs: [String] = []
            var outputs: [String] = []
            for idx in 0...9 {
                inputs.append(components[idx])
            }

            for idx in 11...14 {
                outputs.append(components[idx])
            }

            // 1
            guard let one = inputs.first(where: { $0.count == 2 }) else {
                print("BIG PROBLEM!")
                return -1
            }

            // 7
            guard let seven = inputs.first(where: { $0.count == 3 }) else {
                print("BIG PROBLEM!")
                return -1
            }

            // 4
            guard let four = inputs.first(where: { $0.count == 4 }) else {
                print("BIG PROBLEM!")
                return -1
            }

            // 5 segment numbers
            let fiveSegmentNumbers = inputs.filter { $0.count == 5 }
            var fiveSegmentCommon = ""
            if fiveSegmentNumbers.count == 3 {
                let flatmap = fiveSegmentNumbers.compactMap { $0 }.joined()
                let dict = flatmap.characterCounts()
                fiveSegmentCommon = String(dict.filter { $0.value == 3 }.map { $0.key })
            } else {
                print("BIG PROBLEM!")
            }

            // 6 segment numbers
            let sixSegmentNumbers = inputs.filter { $0.count == 6 }
            var sixSegmentCommon = ""
            if sixSegmentNumbers.count == 3 {
                let flatmap = sixSegmentNumbers.compactMap { $0 }.joined()
                let dict = flatmap.characterCounts()
                sixSegmentCommon = String(dict.filter { $0.value == 3 }.map { $0.key })
            } else {
                print("BIG PROBLEM!")
            }

            mapping["a"] = String.uncommonCharacters(str1: one, str2: seven)

            let fiveAndSixCommon = String.commonCharacters(str1: fiveSegmentCommon, str2: sixSegmentCommon)
            mapping["d"] = String.uncommonCharacters(str1: fiveSegmentCommon, str2: fiveAndSixCommon)

            let fourAndOneUncommon = String.uncommonCharacters(str1: four, str2: one)
            mapping["b"] = String.uncommonCharacters(str1: fourAndOneUncommon, str2: mapping["d"] ?? "")

            let fiveAndAUncommon = String.uncommonCharacters(str1: fiveSegmentCommon, str2: mapping["a"] ?? "")
            mapping["g"] = String.uncommonCharacters(str1: fiveAndAUncommon, str2: mapping["d"] ?? "")

            let sixAndAUncommon = String.uncommonCharacters(str1: sixSegmentCommon, str2: mapping["a"] ?? "")
            let sixAndAAndBUncommon = String.uncommonCharacters(str1: sixAndAUncommon, str2: mapping["b"] ?? "")
            mapping["f"] = String.uncommonCharacters(str1: sixAndAAndBUncommon, str2: mapping["g"] ?? "")

            let fourAndBUncommon = String.uncommonCharacters(str1: four, str2: mapping["b"] ?? "")
            let fourAndBAndDUncommon = String.uncommonCharacters(str1: fourAndBUncommon, str2: mapping["d"] ?? "")
            mapping["c"] = String.uncommonCharacters(str1: fourAndBAndDUncommon, str2: mapping["f"] ?? "")

            var chars: Set<String> = ["a", "b", "c", "d", "e", "f", "g"]
            for key in mapping.keys {
                if let str = mapping[key], !str.isEmpty {
                    chars.remove(str)
                }
            }

            mapping["e"] = chars.first

            var translatedOutputs: [String] = []
            for output in outputs {
                var outputString = ""
                for char in output {
                    if let found = mapping.first(where: { $0.value == String(char) }) {
                        outputString += found.key
                    } else {
                        print("BIG PROBLEM!")
                    }
                }

                translatedOutputs.append(String(outputString.sorted()))
            }

            var entry = ""
            for output in translatedOutputs {
                if let found = displayDictionary.first(where: { $0.value == output }) {
                    entry += found.key
                } else {
                    print("BIG PROBLEM!")
                }
            }

            total += entry.int
        }

        return total
    }
}

private class Puzzle_Input: NSObject {
    static let test1 = """
acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf
"""

    static let test2 = """
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
"""

    static let final = """
bgcfda gecbda abdgf aedfbg eda efcbd ae agfe bdefagc fbeda | ae egdafb ea fcdeb
gfadb fbagcd cagf agecdb adg fdbcg bdcfaeg bcgfde ga efbda | cbfdge dfcebga aedcgb dgbfa
bgdeca agdbe gfb fdbgce bf eafb dfgab efbgdca gebafd dgcaf | gfbdea gfb bacedg adcgf
fbc becgdf fcbdg adcgf edafgb bgec dcgfbea gbfed bc cbeafd | gfacd gcbdf bgedfa cbdefa
ad dcafeb adcef feagc egdbaf aed cadb bgcedf cbeafgd cdfeb | dabc gabefd ecfdb ecgfbd
badcgf gdaf gadbc ebfcg fceabd gacdbe gedfbac dbf df dfcgb | df adfg cbfgad fdb
cfdb dca bdgca efgbad bafcgd fgdba cgdfea cd abdfegc bagec | agcbe adc dabcgf adc
egdab gcefd ecbgd gdebcaf eacb cb bagcdf abgfde dcegab bdc | bc gedbc dcb fgdec
gefa gedabf cfdbea bdfea bdegcfa dgbfa gfd gdcab fg fecbdg | fgd gf dbfage afbdec
fagdb be abdfe agfebdc eab aefdcb acfed bdec fceadg afegcb | be aegcfb efbcag eb
fdce fcadeg afegdb adceg cgafdb de ebcga dae cdagf abdfgce | efcd efacgd edfc afgcd
gefc defca aefbd ec gfdceba dcabge fgcad cae fcadeg bagfdc | fgcad bdfea ebadgcf ce
cdabe dcg cgef gc beadgf fegbd gcbde edgcfb gecfabd fdgcba | dcg deacb fdegab bdafgc
aefc ebcdfa eabfgd deacb ac dac gdbce gfbadce fdeba gcfbda | adc afdbe aefc ecdafb
eabfdg fdgba fac fc ebdac bfcg fcdabg bgdface bacdf fgedca | fdagcb cedba cf fc
db dbg debag fcgdeb gfeba dagfec ceadg bdfecga deagcb acbd | gbdae afebg cfedgba ecdagb
cabegd befcd aefdcb defbcag dgfb gd edg bfgecd gfdce eagfc | dbgacfe efcdg gd bdfagce
abde fbecag gcabde cefdg bgedc bgcea bgd becgdaf gdcfba bd | baegc egbdc cedgf gdfec
gedc eagbd bgadcef aebcdg dfbag eacfdb cabde fgecab ge aeg | gcbeda gabdfec dgecba gea
afedgc deabf gbfceda fg cgdea dgf bdgfec edgaf ebacgd gafc | fgd gfac cbefgad cagde
gfcbeda bfecda dgca ebgacd gbfae ecg gc gaebc cfgebd dbeca | dfcbea cegab cg cge
adefc eabdf bcafeg bd edb fcbeadg dabegc fdbg baegf fgaebd | fcead fcdea fbgd ecdbga
ac bedgc acdb gacbed bfgeadc degcfb aec cafdeg eagfb cegab | agecb gdbec abgcde agbef
cfgbead cfgdeb gafb baecd bg cgdba bgc adcfbg agfecd dcagf | dgcefb bgaf fdbcgae agcdf
agc dabc dcbgef efadgcb ebdgc baefg ac abgce ebdcag facdeg | ecbdgf ac afdgbec decfbg
fgdcb cbdeaf eabfcg cefdb gcbeadf cdeg gc afbdg cfg ecdgbf | cg eafbcd dgec cbfdge
da dbae fdaecb cdebgf afgced bedfc adf cbfeadg bdacf bfcag | dfbec egbdfc bdfca cefbd
abgfced cf cfdbe geacfd bfac bdacfe gdebc bfedga dcf bdafe | bcfa dbfce cf egdbc
dcagb feagbc dbef edafg fagebd bf fedgac fba bfagd dbcefga | fbdga dgafe cfabge fdbe
gbfce bfc acgb fbgaec bc acfedbg gface cgefad bfacde defgb | cbgfe bgfeca gacb degacf
cfgeda bac dbafg dbcfa bdfcage ecfb acedf cb ecfadb eacbgd | gafbd faced dacfb bcef
fbgec eca cbag cfegba ac efacb bgcedf caegdbf fecgad fdbea | ca acgb ebdfa agcb
acgbf cdabegf egbfd dc dacbef dacg gecabf fdc dbgfc dfcagb | dgabecf befgd acgd abgdefc
dagbfc bc agcdf cgbd bfc ebfad dfcba befgac gaecdf becdgaf | cdgb dbcg abfcdg cfb
bdcga ebdgca da cdeafg dac acfbg daeb cdbgef egbfcda bdegc | bcgad adgcbe fedacgb cegdb
gacfeb aefbg fbaegd cedgfb dfcba gc cgae abcdegf gacbf gbc | cfabd debfgac cega egca
abcfeg fdbegc ac bdafgec ebfad fcdae dcga fcged gdceaf ace | gbcfaed ebfda ac gefcab
gefbc gdeacf cag ac acgebf ceab adebcfg bfcag cgbfed bgfad | cga cagdef gac fcgba
gcbe gacfdbe dfgaeb bfecd ecdgfb dfcgae bef fcedg bcfad be | fadcb ebgc cbfda dfcab
ebcgfd dafe adcfg gfacde cfabge bcadg dfc fd fbdaceg gefac | fceadbg fcgabe fade fbeacg
fbacg cef cagebf gacefd ef bgced cfbeg dagcbf fbea cegfdab | eabf fce cdgeabf agefcb
bca gcadbfe ca edca fbgade dcageb ecbgf egacb ebadg dgcfba | cgafbd feagdb gabecd cba
fcebdg cgefb fagbce edcbg bfed eacbgfd cegda db bcd dfgcba | becdg cdbafg bedgfc cgbeafd
fcadebg edbafc cgfda decba egab gcadb gb debgfc cgbdae gdb | bgd agbe eadcbf gdb
cedfa gad ebcfda aedgc defagb gdafceb gebca dcfg dg edgacf | cdfg fadec gedac bcgae
dafegbc dcfbae dce fcebgd egdaf ecadf dfcbag acbe ec cafbd | ced dce ce ec
fegb ef bdcefg fabdgce efd fegdac cbdaf bcdef ecbdg acbedg | debgac edf ef dfacb
afgedb caedbg egfba baecf efgdb gbcadef fagd age cfegdb ag | afbec degbafc fceab eagbdc
cebd dfb dbecgaf gefcb afbegd bd fdcgb gfcebd cgdaf gfeacb | abecfg gacbfe cgfda bfceg
acdfgb ecbga ba ecgdafb deafgc aedgc aedb aecgdb bag gfecb | cgaefd gabce cdgbae ab
be fcgdae fcbag efdbcg ceb cfebg degb cdebfa fgdec gdcabfe | eb dfegc debg bce
fdecg dafgebc fgcae fgd bcfd bcged edbgfc aecdgb fbgade df | afbdecg bgfaed fcged bgedaf
cabd egdfa fbgac bcgafd ebdafgc bd eagbfc dgb fdabg cgbdef | bd bd dbg cbad
fgecba bd dgcbea gfeda gdb geacb ecbd bfadcg efcabdg bgade | dgbae befgacd ecbag afcebg
ga abefc afg fecadbg egfcbd dgfbac edgfac adbg fcgdb gbcfa | dbag fag fgdbcea dcbfeg
geacf cadfe bfaced fg fcdgae fged ebagc cfg edbfgac bfdacg | afcbged efadc fg fcg
cbd cdefbag cfadg bd bfdac abed fdabce dbegcf egabcf ecbfa | gcebdf faegcb ecdgbf fbeadcg
fagcde cgdfa daef acgde ecgadb dbcgf fca eacgbf gcafbde fa | cdage cebfga adceg deafcgb
feadgcb efcag dbfge edba dfcabg ebgfa ba gefbad ebgdcf bfa | abdefg daeb bfa fdgaecb
dgfcea becdfg bdefg abgdfec beg cgedf eb decb bgefac fgdab | beg fedgc egfacd fcedg
fcagbd adbfeg gbeda bgfde ebfcdg dfae gaceb gda ad fdbcaeg | agd gdeba fdgeab ebcga
dbcefa bfaegd fdcb fdeca agceb fcabe cfaged beagdfc fab fb | edabgf gcabe adefbc fba
eac cfgeab agdfc cdgbe gdbefc dabe gefdbca abcged ea agecd | baegdcf bfcegd gdbfce gfcebd
cdbeaf cd dcf adcgfeb defab gbfca dgbafe cead fdcab bcefdg | dfcabe fcd dc cdfgeb
gdcfbe bag dcebg dgabce cfgdba geacb bdea ba febcagd faegc | gcfea dgbfec fecag cefbgd
ebfdgc baecdfg gabfe acbg bce dgabef cdeaf gfabce ecafb cb | eabcf gdfebc egfabc gafbed
dbgacfe adgcf cedafb ecbad bdfe bf egcdab abfgec fab cbfad | bdfe fba bcfead abedc
dca afdcb befagc gacedf dbecf cgfabd da dbag ceabfdg afbgc | da adgb gfedcba dabfcg
fgcda bcgf cgfeda bfdcga gbd badfg cebafdg gcadeb bg dfbea | fcbg geacfd abfgcd bafgcde
cf gacbfe feadcb cdgaeb fbcd fcdae efdag ecf gcabedf edacb | ecabgd gbcfaed gebcad efdac
ae abcefdg faedbg agedf dgbfce gabcfe adfcg dfbge efa bdae | dcfebg fae agfdbe egfdba
fegdcab dgcaf bfd fgdab edcgaf eadgb fbcg deacbf fb gbdcfa | acefdb gdcaf fcgda gabde
ca cefa bgcfed facdbe dgbfeca adc dbacfg cabde edabg fcbde | dcbefa bedfc dfcgab dbfacg
ce bgcedf cgdef gdabfe cabefd dec aegfdcb dgcfa gcbe fgbde | cegb dce aedbfc ce
fcgaebd ef febdac feb cafbd edcfb fabecg acbdgf dfae ebgcd | feb bfe fegacb bafdec
fgdec adcb dfbega afcgeb egcbd db bcaeg beagdc dbgfcae deb | bd egcdab fecdg bed
ad dcaeg edcbag fgbdeac acd gcdfeb afegc ebda cadbfg dgbce | bfgadc dca ad cda
bdegaf egfdb afb acbegdf fgdba af feda bcfgea fbdecg abgdc | fdegb fabecg degabf adgbef
gdfbe gcf gbcda cadfbg cfdbg gceafb dfca badegc cf cedgbfa | fc fcg egcabfd bdcag
fcbag ebdcgfa ce fgaced fbgeca gfbec cgdfba fbgde efc aecb | beac ce cgbfe bfegd
dcgaef gedfb fegdabc eabfdg dgc cefgdb bafdc cg gecb gcdbf | debgcf gbcfd gbce baefgcd
bfacdeg cedgf gfdbec eca edgcfa dbeaf ca fcdea dcebga cgfa | cefgd gcedfa bdfegc aefdc
cdfea ebgdf ab adebfgc bdcegf gbda fab dagfeb ecgabf ebfad | defba cfdea ba ab
gbefcd cbedf fcaed dgfb dacgbe ebfgca fb bfecadg cfb gcbde | eabgdc egcbdf dcgbef fb
afgedb cabdefg afcdb efdgca ef abgde edf ebfad agdbec fegb | edagcfb cdfba efdagc dcebga
dcfg afbgedc efgdb agbfe fde dgbce dabegc gdbfec df fadcbe | dbfeg gdfc efd faegb
ebgdf acfge bae gbafe efdabc ba feadbg bgda gfebdc gedacfb | fbdcge dbag ab bafedc
abedcg dcagfb cf dagbc afc fceabd fbcag dfcaebg dcgf abefg | afcdbg dcfabe fcabg adgcefb
fdbc egabc bfegc fc gbfced aefbgd gfebd gfacde bgdafec fec | fbcd fedbg daefcg cef
bgacde fegad febc gfacedb gebca gaebf bfa efbgca gfadcb fb | bf dcgfeba fdcgeab fb
cgdfe fagec fbace afecdb acg fgcbead ga abfcge bcgdfa ebga | gabcef cfgde dfgcba gcbdfa
bgae ae acegfdb dbfeg dbcgfe ebgafd dfcba cgefda adebf eda | aebfdgc bedaf feabd fbadc
dfagcb cbdgea efabdcg ecdab gceaf daecbf df cdefa fad befd | afd gefca adgfcbe fd
dcfeg acgf aec degfbc ca efbcgda fcdea gfdeac faedb cegdab | egcdaf gebdcf bdaegc aefdc
cgebaf cbdagef cadgb efda degbaf fgbea dbe bgfdce edbag de | de feda dagbe agfcdbe
eagbcfd eag efcad acefgb ag gadce fadg bdgec baefcd aefgcd | bgecd edcfab baecfg ga
adbcfge eadfb faecd ab dba aebgdc ebdgf ecbfda fcba gdfaec | efcad febdg bfdgeca dba
adgfc dfegc cdfeag edf dbecagf fdabge fbgce ed dcea cagdfb | agdfbe def efd deac
cgb bfgde bdcfa fgcbd fgeadbc fcabed befcag cg dacg bgafcd | cg acfedgb bcagfe bdfagc
fcbdge egdac acgfe efgcad fc cdaf gacefbd fcg faebg dcebag | ecdag efcgda fdac dgcbea
dgabef fdabg bcdagef dcfbg fgac adfcbg fc gdbec cbf fedcba | bdcagf dfagb fabgd cf
defc cgafed ecafbg fbdag aef cdgbae gecad facdgbe ef dgaef | fe fbecga gfdba adgebc
gbdfac gcfbd dgceb bcgdfe fedabcg gdfe fbceag eg baced gec | gacfbe cdgebf cge cge
acgdbe cfa gfba cfdab cbgadf cefdb bcfadeg fa fedgac agcbd | abfg agcbd gcfeabd dfcbe
dagebf defcb dgecaf edfbac aecbdfg deacf be aceb bfdgc fbe | ebac dcfagbe feb bcae
gbcfad fadgbce ag fdcegb gbda ceagfd agc cfdbg gfcba eabcf | dagbcf gdacfb dafcgeb eabfc
dbgcea ag acg dbag aegcd bgdefca bdgce ebgfac cgbedf acefd | agecfb abdegc dgcefb agbd
dgebfca cgdfa bgafe eda cgedfa dfage fgdbac ed ecbfda egdc | befgdac daefg acfdg acdebf
fgadce dcb abgdefc cedgf fecdb cb dgcfbe bgdeca gcfb defab | fcegbd cb gdfce gfebcd
cfbdgea ec dacgf fdeab adfec dbce dbegaf cfe deafbc ebfgca | ec decb ebagfd gcfaedb
gd bcegad afdec dgbf efcdagb cdg fgdcba fgadc abfgc cgafbe | gacfb bdcgea fabcg gd
dbega afebdg ca ecabdg deca cfgbae bca gebdfac gfcbd adgcb | cab caed abc cead
cgdbfe ab fgade gefcab afcdebg agdbe dcbeg bdca abe cgabed | ba debgc gcefba cegdab
cdfegb dbafe abdgce cbfgea bfg fg cgbed dfgc bfceagd dgbfe | gf fadgcbe aebgcf cafegb
ecafb efgcab gbdecaf fbega egabd gef dfbcge fg dcbfae cafg | dcgfeb bafdceg agfbe gf
efdcbg fgbca dcgbf dbfcag faebcd abegc afc egcdabf fadg fa | fa afc adefgbc fbcedg
dfa gcdbeaf dgbafe gacfbe dcagb adcbfe febca df dbfac cefd | adgefbc daecfbg efbca bagefdc
aec fecbgd aegdc fgcad bcedaf bdcge gbea defacgb ae acbgde | ae deacg edgcb afdecb
cdab bedgf dcbegaf gdfac bc efabgc fbc cdbgf afgcbd efdagc | cfb fgebca cgfdab faedbcg
ab eacbgf bdfa fcaedg fdebagc degba bcdeg afdgeb dgeaf gab | gfdbea afdb afdb gcebd
acbed bfeacd aedgc aeg ag gdbfae egbadc bacg fcdeg gcdbfea | gdaec aefbcd gae bdaegcf
fgadbc geafb dafbgec ecdb ce bcega deacgf egc geadbc cgdab | ecgba cdbe gacedf aecgb
gbea eb cfdbaeg cebad gbdac fcdae dgebcf fcabgd adgbce ceb | dagecb ebc dagbc ebc
fbeda ga aeg aebgd agfd bdgcfae fedgab dfeacb fbaceg begcd | ga ag afcbeg bfecad
efabcg bdc fedgc adebgcf gcabed cfdbg dfba db cafgb bfcgda | dcb bdc agfbc afbegcd
fbade bcagfe cgfea cdag dfc cfade begcfd cd gecbdaf dfceag | cgda gcda fcd dc
dbcfa bg gafcde bdceafg gaecbf cbg bgde bcgad aegdc bceagd | gcdab eacgdf bg cgb
ecfagd fbadcg fgbae bdgae gbf befc facgbe gecbfad fb eagcf | gabed fb egabfcd facbegd
abef dcabf ecfdba afbcgde bgdfce af acf cagdb gaefdc bfcde | cfadb abef bcfde cgfdbe
acedbf abcfdeg bdceag bgade acdfgb aeb bgdfe eacg ea gdabc | begda dfbge ae badcg
fcda abgef da dea dacgeb fbdae cedfab bagfced ebcgfd cdfeb | bcedf edcbfg dbaceg bdcfe
dgcfba cadeb agcdb aebfgc gdaf bcfdg gac ga fgebcad fdcebg | dgacbf ebdca egfdcb bcfdg
afbedg egbd bfcdag edgcaf gbdcfae afegb fgdae gbf fcbea gb | dgbe edbg bg efdag
acb abcfde fcgead efacd eabfc dbfa ab egfcb bedgac fdcaebg | defca acb caefd acbdge
afcde dbe fbcaed aecbfgd bfec be eadbc afgdbe dacbg gcfead | be ecfb fgdabe aedgfb
fdeacg cbgfa gefb bfc bf gbafce bdefac agefc aegcdbf agcdb | bf gceaf efbg bfcaeg
fdce gacfb agbdec cgafd df caegd gdcefa bcgadef agfbde adf | fagbc fcgdea fd bfgca
gdfacb aebcg ga dgae egfcbda cedbg dbegca acg gbedfc ecbfa | ga eagd eagd edgfbc
cgbdf eb caged aegfcd egb badecg gdbce ecba egfdba dfbaecg | cagfdbe geb dgcefa dafegc
cd gbecaf acfdb cdfg cda gbdface gfbac dgacfb bfade dgecab | dfcgaeb dc bgdacef bfacd
geab fecdb gb feabcgd ebgcda gdcae gecdb gbc afegdc gbfdac | debcga bgdaec dceagb cbaged
edgfcba agd bacd afcdg degbfc acefg efdgba bgadcf da gdfbc | gcfbd dbac cgfdb gecaf
bfca fcbged dfgab cgbadf cdfabge degcab adfeg cgfbd ab bad | abcf afbc gafdb acfb
gc fdgac fgeadb afdcb gecdfa gac gecafbd cabged gfce gaefd | ecbdgfa cag bgfeda eafgcd
eagdc efdacbg cdgbe cbfdg egadfc egb aebc be gefabd dbecag | bafcgde beg gbacde dcbge
ac afbgcd gfdba fabecgd ebdafg bac cfag adgcbe abcfd cfdeb | adbegf egacdb bac acb
cafbed gf gfd cgdba eadfbcg gfdcb gbef cfdbe fdgeac gedbcf | facbegd cbdag fg fdg
fbgcd fadb fcd fd dfcbga decabg egbcf gacdb fcgeda aecfdgb | bedcafg cgdbaf fabgdec dcbgf
gb bcgeaf aebfcd cdefbga cbaef cgafb gbf dfacg gbcfed bega | bg bfacg bdfcge geba
cadfe afbgced aedfcg cebfg aeb fdageb bfcade bfaec ab bcad | bacef bcafe bfgeda baefgd
cgbde abcg cea dbegca ac agced befdgc bgafdec efgda badefc | cae eca gdfae dcega
ab fgcbed agb cafge cegba deabfcg dbgec aedgbc gfadbe bdac | ab bdca cgfedb dgceb
bfgadce cfadg fa cagdfb bcgdf fagbec gfa fbad bgcefd degca | fa ecgad gceabf dcfgb
gfd dcabegf fg cefdg cbefgd gefb ebgdc egacbd gcafdb dcfae | ebfgdc cegdabf cbafged fdg
dfecagb fbag bdcega gecdaf fg cgbad gfdacb fbcde fgd dfcgb | gfd gfd dgbeac fg
gfaed gad feacg dfaebcg deba efgbdc gefbad ad agdfbc fbdge | dga bdae fegbcd dgfabc
agdbc egdcafb caegdb afgdec cbadfg fdgba efdba bcgf gf fga | dfabg cagfdb eadbf cdfaeg
bgefac fecdabg cebdaf de aedfb ade bcefa gcafed bcde adgbf | ebcgaf fbadg ead dea
edbgc dcba egcfbad cfdage abfegd caged ebd bd gdaecb cgbef | cdebg badc edgbc ebcdg
cgfabe dce fcdba efbcg bdcef bagfecd eabgcd ed ecgbdf dgfe | fdcgbae egfd edc bfegc
fgecad gebda ebgcd egc dbecgf ce cbef cgdfb egacdfb agdbcf | edbfgc cdgbe edgfcb bcefgad
geafcd cdage ec cdegbaf gec cgafeb abgcd gebfda gafed dcef | ce gdbfea egdabfc gec
be abdgfc daecgfb bae dbfag gfdeba dbafe gbfeac egdb dfcae | bdge eba ecfgba gcaedbf
bcge gbeadcf acg bfcdga bfcaeg cfaeg gc feabc bfaecd gedfa | bfeac begc fgdbca bgfedac
gfbed ce ced fceabd dabegf bcdgef egcf becfagd gcdbe gcadb | ce ec bdfaceg cdeafgb
gfdea db cfdgbe badc gbaec ebfagc bde dgbcae egbda cbgedfa | badegc cbeagdf bd egfbcad
deabcg egbca agfdbc edagfb abe eb afbdceg efcag becd agcdb | bced eb be bea
ebfgda bgade dbcea geaf gcbadf dgfba eg gcedabf geb cgfbed | edabg ebg cedgfb bgdcfa
fc adgbecf fbcd abgfdc cgfab aedcfg dgcab gfeab cfg cbdgae | fcg badegcf bgdac fgc
edg egbda dafbgec begc aedcb cadgeb eg eacdfg gafbd cebadf | dfgba bdegac cbge afdbec
bgfecad gdbaf afdbeg egafcb db dba fdbace egafb gdeb dcgfa | fcbade fdagbe bad cdbefa
bcgedf ecba bagcef beg cgafed eb gfedcab gfbad efgba egafc | bace fbgdec cbgefa beg
dgfecb fcd edfbag bcfade fc caegd bcgedfa defab caefd cbaf | dbeafcg fc fabed dcf
ceafg fbad cfeba edbca afebdc bf cegbad bcdfge cgdefab feb | gdbecf faebdgc dcaeb ebf
cgdfba cdabf gfedca efgcadb baegfd bcfg fc caebd gdafb caf | cgfb dgcfab befgadc debgcfa
ebfgca abcfe gca bagde bgcae dbgcfa efbadc gcef agefbcd cg | abegc cbfae acefbgd cag
dfegac gedc bcdaef abgfd egf ge fagecb agefd fecdbga ecfda | gbafd dacbef gdefac gef
feb begcdf fcab edcafb bf aefdc gbade bfead daegfc feagcbd | bcfeagd gcdbfe fbceda fb
baefgcd fedcb cfbaed dgc abdgf bdfgc bcedgf gc gcfe aegdbc | ceafgbd fbcdge bgdface efbdgc
fd gbdae bfda ebfgdc edf gfdea caegf aedgcfb fadgbe bcagde | abedg adegb efd fcaedgb
befg gecdb dbcgafe adebcf dge ecfbd bcefdg aecgdf ge bgcda | bgfe gdebc dge ge
cfdgb be aecfg gefdbc bgfec afbdgec cdabfe egbd cgabdf cbe | fbdgc eagcf eb faegc
gfdbae aedcfg gbcfed bcde dbefgac gfacb ceg bdgfe ce efcbg | efcbg ce edcb ebgadf
ba fecba dbcgfae gcab gfcade febdc adfegb fab aegfbc gcfae | adfgbce gebdaf cefba fba
eadbf acfde cfdeab bagfcde bgfcae eab gafdce cedb dbgfa eb | bea fgeacd eb fegabc
ecb baedc ec adbfgc cedf faedcb acdfb fdgaebc agbde aegcbf | fdce cbfdage bdacgf cedf
fegc cefgdb fdbge bfg badgcf eabcdf fg begad dafgceb fedcb | bgf fdbec gf ebdacf
gfecdab gbeac aebd be eacgd ebc dfegca cbagf agbdce bcdgfe | bec ecdga ecb gabec
cb bcfg cgdfa adegfc bca aegdb afcebd gcdfab dbgca becfdag | bc badcgf bca fcbg
gabdce dc fbgdc gbfec cfda fgadcb bafgd fbdeag abdcegf cdg | fcda adbfg cfgbead dgacfbe
ecgab gbdecaf bcfa cdegbf eabgdf fgeabc ba egfcb gedca gba | fcbeg gacbfe ecdbafg deacg
agc bgfca cg cgafdbe dcfg dcfagb fbdag cabef gdbace gdefab | dcfg agbfc bcfea cag
cagb ga dfcga fdaebc fdebga cbdafg gfcbdea fcgde cfbad afg | cbga cedgf cdbfa afdbcge
cafgdeb aebfd gfbeda ebcgdf agcbf egf decbaf egda abgfe ge | bgacf bdfea agfbe beadcf
be agbefdc aedfgc gabfc adgfeb egb efdag afgbe deba bgfedc | fedgacb dcafge bdae ebad
cfbae dcaegf cdbfaeg fcebga efgca cdfab ageb gcbfde ebc be | acfgde be be bcfagde
bafdgce cea gdbcfe ae agecd agcdbe ebfcad agbe bcdeg fgadc | cebgad ecbgd cbdeg gaeb
bgce agefcbd egbcfa eg fadgb bfcae dfbcae egfab gae fdcega | age gafcbe eacfbg gea
fgacde gfaedb ebacf gc gdfc dcbeafg fadge gec bdcgea cgfea | fdagcbe gfdc aefgcbd gc
gb acfdgb bga aedgf bafdg abdfecg gacfeb bgdc bfcad fcedba | fgaecbd dabcf bcdg bg
"""
}
