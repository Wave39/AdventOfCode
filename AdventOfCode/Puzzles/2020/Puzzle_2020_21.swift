//
//  Puzzle_2020_21.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/21/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

// Parts of this were lifted from https://www.felixlarsen.com/blog/21th-december-solution-advent-of-code-2020-swift

import Foundation

class Puzzle_2020_21: PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, String) {
        return solveBothParts(str: Puzzle_Input.puzzleInput)
    }

    func solveBothParts(str: String) -> (Int, String) {
        let lines = str.parseIntoStringArray()
        var foodArray = [(Set<String>, Set<String>)]()
        var allIngredients = Set<String>()
        var allAllergens = Set<String>()
        for line in lines {
            let arr = line.parseIntoStringArray(separator: " ")
            var ingredients = Set<String>()
            var allergens = Set<String>()
            var allergenMode = false
            for item in arr {
                if allergenMode {
                    allergens.insert(String(item.dropLast()))
                    allAllergens.insert(String(item.dropLast()))
                } else if item == "(contains" {
                    allergenMode = true
                } else {
                    ingredients.insert(item)
                    allIngredients.insert(item)
                }
            }

            foodArray.append((ingredients, allergens))
        }

        var allergensToIngredients = [String: Set<String>]()

        for allergen in allAllergens {
            var ingredients: Set<String> = []
            for food in foodArray {
                if food.1.contains(allergen) {
                    if ingredients.isEmpty {
                        ingredients = food.0
                    } else {
                        ingredients = ingredients.intersection(food.0)
                    }
                }
            }
            allergensToIngredients[allergen] = ingredients
        }

        var allergenFreeIngredients = [String]()
        for ingredient in allIngredients {
            var foundIngredient = false
            for (_, v) in allergensToIngredients {
                if v.contains(ingredient) {
                    foundIngredient = true
                }
            }

            if !foundIngredient {
                allergenFreeIngredients.append(ingredient)
            }
        }

        var part1Answer = 0
        for food in foodArray {
            for ingredient in allergenFreeIngredients {
                if food.0.contains(ingredient) {
                    part1Answer += 1
                }
            }
        }

        var removedAValue = true
        while removedAValue {
            removedAValue = false
            for (_, ingredients) in allergensToIngredients {
                if ingredients.count == 1 {
                    for a in allergensToIngredients {
                        let countBefore = a.value.count
                        if a.value.count > 1 {
                            if let firstIngredient = ingredients.first {
                                let filteredIngredients = a.value.filter { $0 != firstIngredient }
                                allergensToIngredients[a.key] = filteredIngredients
                                if countBefore != filteredIngredients.count {
                                    removedAValue = true
                                }
                            }
                        }
                    }
                }
            }

        }
        let sortedByAllergyNames = allergensToIngredients.sorted { (ele1, ele2) -> Bool in
            ele1.key < ele2.key
        }

        let part2Answer = sortedByAllergyNames.map { $0.value.first ?? "" }.joined(separator: ",")

        return (part1Answer, part2Answer)
    }

}

private class Puzzle_Input: NSObject {

    static let puzzleInput_test = """
mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)
"""

    static let puzzleInput = """
dkgkc qxsgkzt zsqn mhlm lzxpk rmd bhxx gbzczpn jbxvkvf gqsj qpdb bdjxjvj rkcngr ztdctgq lgllb jlmlz qcrf vmz fllmxc krg rltc djsvj gxml prgh kcfjnr pjzqbc rqccts sgqj zclh xsfpzncj qqttxln mpqtc hzkdqz hxbl fgjxhf xlknfh mdbq dggmkht cdvjp dlgsd jbdqm xgtj lpts cz qrmvtk nhnsh jfddkg bdnrnx (contains nuts, shellfish, dairy)
rjrn jzjhcm rtcdm pzcgr gvfsv bdnrnx djsvj ztdctgq dnrgnnr ffqndb gpmvkrt dzhf sndrz vmnfpd bzxvd xlknfh xtzqb jdggtft ckbsg fjndlnv qsqcjd vhsp jqhzc mdpql qdqfl dggmkht vgfknzx sjpcmz spqqb qpdb dkgkc lsnj bchsc rkcngr jfddkg ppb pzh lflv tzqxpq rglpnc zclh hcsmg qxsgkzt cdvjp dqxvmx vlsprc qhgg ztpvmk lgllb dfzbpz sbbkvr xsfpzncj sjpx lvmm jbxvkvf bxv gbzczpn zzlfrts rqccts kjsll xgtj lzxz pllnld mxkfs mdbq nprb mbnr drpn dfvkm hxbl dzqvbsq kfft ccqf lcbbcb jtmlcg zsqn rltc cz dlgsd qddlv (contains fish, eggs, soy)
fllmxc xsfpzncj jsqng tzzfktn jdggtft jfrkn cmzlkx dnrgnnr vtbdr qqttxln drpn jtmlcg rjrn rqccts rmd hzrzc qpdb pzcgr ckbsg kspzjr lflv skhxhp hzkdqz gvfsv jpztz nbkdh hxbl ggmgdv bchsc xtzqb qrmvtk jbxvkvf gzzb spqqb sjxlr fsmhfr fjndlnv lzxz mdbq sjpx jlmlz gbzczpn qsqcjd lzxpk bdnrnx vlsprc qtsq vmz xgtj vbxnml krg cmrlm lmrbfm rdkvvnb jqhzc ktgf lxhpmc rkcngr sjpcmz tzqxpq vpqxh ztdctgq chbpkvt pzvbfr gqpdph kht jhcr cdvjp tpgm mvhlr xvbdz vgfknzx bdjxjvj kjsqxp jrkbs bzxvd fdndh dzqvbsq ztpvmk zclh hbxq rglpnc fgjxhf vsns dfvkm pjzqbc mnptn dkgkc qhkq cqlpzd kjsll (contains shellfish, nuts, dairy)
fllmxc nhnsh rglpnc gqpdph lvmm dlgsd jsqng pjzqbc hbxq xsfpzncj fbllk qhkq hfmkj rmd xvmsx cglt jzppz qcrf cdvjp kkcz ckbsg cmzlkx mdms vrhrt xjgv zclh lsnj qddlv lmrbfm jqhzc jrkbs gzzb qxsgkzt jdggtft bdnrnx vpqxh rltc rjrn ztdctgq lgllb ppb rkcngr dzhf xqdl sbbkvr pkknn sjpx skhxhp kcfjnr jlhpkg xvbdz bhxx cz nbkdh djsvj vhsp dkgkc ghshq pzcgr xgtj kmkcksz jbxvkvf jpztz dzqvbsq cmrlm gmzjtc vgfknzx gqsj drrvln (contains eggs)
gbzczpn tzhq kkcz ztdctgq rkcngr cglt jfrkn jtmlcg vpqxh xvbdz fdndh pzvbfr dfvkm vbxnml rglpnc gbv hxbl dfzbpz tpgm chbpkvt qhgg bdnrnx sjpcmz dnrgnnr qsqcjd sbbkvr jndts qxsgkzt mhlm zclh dkplsn zbqhtv fsmhfr kht vgsxs djsvj mxkfs bhxx mdbq jknscx jdggtft pzh mvhlr drrvln kcfjnr cmzlkx rdkvvnb vlsprc mxnjztb sjpx lgllb lzxz bdjxjvj dkgkc tjsvdhn jzppz fllmxc jrkbs xgtj hzrzc gqsj rqccts kspzjr sndrz cdvjp sgqj (contains peanuts, dairy)
vtbdr qhgg bzxvd zbqhtv gsdm jknscx cglt fnr xtzqb rjrn lvmm ztdctgq lzxpk sjpx qglnp qpdb fdndh dggmkht jbxvkvf vsns nvdlxkc ggmcmz gzzb qcrf pllnld jbdqm pzvbfr lxhpmc jzjhcm sjfht jtmlcg sjxlr pbfzgfx xlknfh zsqn vbdnhp prgh dzqvbsq chbpkvt cdvjp qdqfl rmd rtcdm mdpql bdjxjvj gbzczpn kcfjnr vrhrt xgtj tzqxpq jrkbs dfzbpz jzppz mdbq bdnrnx lcbbcb pkknn lflv rglpnc dnrgnnr vmz jdggtft rkcngr sndrz ppb ffjb rqccts jqhzc mbnr lgdv vbxnml sdgjxm xmpqj cz (contains dairy, fish)
jbxvkvf spqqb bzxvd mxkfs lvmm kjsll jlmlz ztdctgq dkgkc pzh xmpqj tzzfktn prgh jtmlcg lzxpk sjpcmz mkv vpqxh jqhzc rtcdm djsvj sjpx lgllb ghshq mdms lcbbcb jfrkn rjrn ggmcmz zzlfrts xtzqb mbnr jdggtft kspzjr tjxrc kmkcksz hcsmg jlhpkg cdvjp bdnrnx kjsqxp dlgsd tzhq xvmsx jzjhcm pjzqbc qdqfl skhxhp ktgf nsndth jdrlzk ngmk gqpdph dfvkm mhlm rmd jbdqm mdbq gqsj mvhlr (contains peanuts, soy, fish)
qrmvtk hfmkj kkcz rmd qxsgkzt mdbq rhjhmvj cz pkknn jdrlzk nsndth ggmgdv tzhq xqdl gpmvkrt mpcsjs xvmsx xgtj mbnr mhlm xxzjz qdqfl zclh rjrn tjsvdhn vbxnml jjnd bmqvll ggmcmz kcfjnr jdggtft bchsc bdnrnx drrvln zsqn ckbsg tzzfktn pzh lgdv mkv gmzjtc jlmlz pzvbfr ztdctgq jfddkg fxbxj xlknfh lcbbcb nvdlxkc lpts fgjxhf lxhpmc cqlpzd tjxrc rdkvvnb xqsn dzhf qtsq qglnp bzxvd sjpcmz vpqxh zlqcps ppb lgllb vlsprc mvhlr jhcr (contains soy, fish)
gpmvkrt vmz mnptn pbfzgfx bxv vbdnhp fllmxc tgtzx dkgkc cdvjp xmpqj jhcr mdms cqlpzd jpztz xlknfh kjsll xgtj bchsc bhxx rmd pjzqbc xsfpzncj mdbq mpcsjs kht dfvkm cmzlkx vrhrt jzppz sjpx rkcngr mhlm kspzjr prgh zbqhtv lgllb jdggtft pzh qglnp jlhpkg vpqxh bdnrnx mbnr (contains fish)
gqsj vbdnhp xgtj ztdctgq gvfsv xxzjz jsqng gmzjtc hbxq spqqb fdndh mxkfs kjsll mvhlr lcbbcb sgqj pzh dggmkht bdnrnx jlhpkg zjj lgdv jhcr qtsq sjpcmz nbkdh mdpql rdkvvnb gsdm dzhf lgllb vbxnml jdggtft mpqtc ckbsg cdvjp mdbq kht hcsmg sjxlr chbpkvt pfmnx cmzlkx ppb mpcsjs jzjhcm qglnp gbv hzkdqz rtcdm zlqcps pjzqbc vmz dkgkc fxbxj xqdl kspzjr qhkq rqccts qpdb gqpdph zbqhtv djsvj xlknfh ggmcmz qrmvtk dkplsn vgfknzx bmqvll (contains nuts, eggs, fish)
dzqvbsq vhsp kmkcksz vsns pzh mpqtc sndrz gzzb xtzqb vpqxh mdms bdnrnx tzhq ktgf djsvj lgdv tzzfktn qhkq qtsq jbdqm jndts rtcdm xxzjz vbdnhp lmrbfm mxnjztb sjfht bchsc sjxlr vmz drpn spqqb mdbq gbzczpn dnrgnnr gbv pllnld cdvjp qhgg ggmcmz cmrlm qddlv lvmm kfft tzqxpq gsdm vlsprc jdggtft xgtj zsqn kjsll pzcgr kjsqxp fxbxj dkplsn ffjb gmzjtc xqdl mdpql dqxvmx fnr jhcr cglt gqsj gbcsmlr tjxrc dkgkc lflv bxv xqsn hxbl jjnd sjpcmz qcrf jzjhcm pjzqbc jlhpkg vtbdr qdqfl chbpkvt mpcsjs lxhpmc gqpdph rmd kspzjr ztdctgq prgh jsqng vgfknzx fgfl bdjxjvj nxc lcbbcb (contains fish)
fgfl kcfjnr fdndh fjndlnv gbv ktgf kht skhxhp chbpkvt qpdb mdbq vrhrt nvdlxkc mxnjztb jdggtft lgdv rltc bdnrnx vpqxh hzkdqz ztdctgq sdgjxm jjnd dlgsd spqqb sjpx rmd nprb vmz bhxx cqlpzd pjzqbc mkv qxsgkzt xgtj fllmxc zjj jzppz tjxrc gxml fbllk rqccts hxbl qhgg lgllb mdms gpmvkrt ggmgdv tgtzx ghshq nbkdh pgdb bxv drrvln rglpnc jknscx dzqvbsq (contains peanuts, eggs, fish)
lgdv nbkdh dggmkht qcrf kspzjr qpdb lpts drrvln jhcr fllmxc xjgv rdkvvnb xxzjz jbxvkvf pgdb mxnjztb xmpqj pjzqbc jfrkn rtcdm dkplsn bdnrnx vbdnhp rqccts vgsxs hcsmg dfvkm xtzqb mpqtc kjsll ktgf cqlpzd kmkcksz jdggtft lflv lcbbcb bchsc rhjhmvj ffqndb xvmsx tzzfktn gbzczpn jfddkg kfft cmrlm rmd nhnsh hxbl vmnfpd dqxvmx jknscx pkknn vmz dnrgnnr lgllb mdbq gvfsv zbqhtv xlknfh fsmhfr jndts mkv fdndh qqttxln xgtj fgfl nprb mdms sjxlr fxbxj sbbkvr lzxz rglpnc cdvjp lsnj kkcz hbxq gmzjtc sgqj qrmvtk (contains fish, peanuts)
cdvjp kjsll cmzlkx bdnrnx jdggtft gbcsmlr kjsqxp rglpnc jtmlcg dfzbpz bhxx xvmsx tzhq nsndth tgtzx xvbdz lflv djsvj pzcgr ztdctgq pfmnx jdrlzk zlqcps xgtj pjzqbc dnrgnnr qddlv vrhrt ckbsg lmrbfm lzxz dkplsn dlgsd fbllk rmd ggmgdv tzzfktn pzh dkgkc qtsq vgfknzx mdbq jsqng gxml lsnj (contains sesame, peanuts, shellfish)
cdvjp xgtj mvhlr tzzfktn qddlv vgsxs bhxx tgtzx vgfknzx xqdl gsdm xvbdz mxnjztb mdbq fdndh vtbdr chbpkvt tzhq kkcz vrhrt mnptn pfmnx mkv xxzjz pzcgr ztdctgq bdnrnx pgdb nhnsh fnr hbxq lgllb prgh cglt rmd ppb jdrlzk gbzczpn vsns gzzb jlhpkg lpts vbxnml gjvhr ztpvmk ffqndb kmkcksz krg lzxz pbfzgfx jzppz mxkfs djsvj ghshq dkgkc rglpnc jlmlz (contains fish)
cqlpzd ztdctgq pzvbfr dkplsn zclh djsvj lzxpk kjsll tjxrc zlqcps prgh kjsqxp gzzb vmnfpd nhnsh sjxlr bdjxjvj sgqj kht xgtj mpqtc vbxnml jbdqm gmzjtc jlmlz chbpkvt dzqvbsq pzh spqqb pbfzgfx rjrn zbqhtv jknscx lgllb sjpx drrvln qglnp dlgsd sjpcmz rdkvvnb cglt bdnrnx vbdnhp nsndth dggmkht hbxq mxnjztb cdvjp xvbdz jbxvkvf zzlfrts jzjhcm fgfl hzrzc gqpdph nprb skhxhp hfmkj dzhf vsns bzxvd pjzqbc dqxvmx jtmlcg pllnld ckbsg jdggtft ffjb fnr lxhpmc vtbdr mpcsjs ktgf mdbq (contains sesame)
tzqxpq sjfht ffqndb jpztz jlmlz lgdv ppb sndrz qtsq rkcngr jtmlcg nbkdh dnrgnnr ztdctgq hbxq gzzb vbdnhp cdvjp cz nhnsh fjndlnv ngmk tzzfktn sjxlr zsqn xgtj hcsmg cqlpzd ffjb sjpcmz bdjxjvj xvmsx drpn mpqtc sgqj gxml xqdl mdbq pzvbfr bdnrnx sjpx jrkbs gsdm vrhrt chbpkvt kcfjnr sdgjxm tjsvdhn xsfpzncj djsvj rmd fgjxhf vpqxh ckbsg tjxrc jjnd kfft vlsprc pzcgr pfmnx jknscx vhsp jdggtft jfrkn hfmkj kjsll drrvln gbzczpn xmpqj lcbbcb lzxz mkv kjsqxp tgtzx jdrlzk (contains eggs, dairy, sesame)
spqqb qtsq cmrlm nhnsh mkv rtcdm cmzlkx bxv zjj lmrbfm mhlm fjndlnv gqsj kfft xgtj zzlfrts xlknfh lzxz cglt hzkdqz nvdlxkc lvmm gxml qqttxln dkplsn vgfknzx fxbxj hcsmg jbxvkvf jdggtft dqxvmx ghshq zlqcps jndts bchsc cqlpzd djsvj cdvjp mdbq pzvbfr jlhpkg qpdb rjrn dzqvbsq ztpvmk tpgm lgllb rmd kcfjnr xxzjz jlmlz bdnrnx (contains peanuts, dairy)
ckbsg jdggtft sjpcmz nhnsh dnrgnnr bmqvll ztdctgq qsqcjd rqccts cdvjp fdndh sndrz lflv mdbq dzqvbsq jlmlz qcrf fnr vlsprc qpdb cz jbxvkvf jfddkg bdnrnx jsqng vrhrt dzhf skhxhp nvdlxkc mhlm ccqf jknscx lgllb kkcz xmpqj spqqb tjsvdhn jqhzc ggmgdv mxkfs rmd tgtzx kht jlhpkg vbxnml lvmm vtbdr (contains soy, eggs, fish)
bdnrnx lxhpmc qhgg vbxnml ggmgdv zbqhtv qpdb kht vlsprc jdrlzk dnrgnnr zjj mnptn zclh xtzqb ccqf bdjxjvj pgdb jdggtft fnr xsfpzncj fgjxhf qglnp kspzjr rltc hfmkj pkknn mdbq mvhlr ffqndb ckbsg hzrzc kfft lgdv gpmvkrt ztdctgq vsns dfzbpz pjzqbc rmd mdms hxbl gxml mdpql xmpqj gqsj ghshq xlknfh dzhf lcbbcb bxv sbbkvr dzqvbsq dkplsn qqttxln mhlm rkcngr lzxpk chbpkvt vrhrt vgfknzx ztpvmk sgqj cdvjp vmz bchsc pzcgr zzlfrts sjpcmz vgsxs lgllb jzjhcm kmkcksz gvfsv (contains sesame, eggs, shellfish)
jdggtft sbbkvr ppb lsnj mxnjztb kfft kht kmkcksz cqlpzd ztdctgq mpqtc bdnrnx jbdqm vpqxh dggmkht vgfknzx qdqfl bzxvd bxv rmd kcfjnr nxc pjzqbc lmrbfm zsqn rkcngr tzqxpq bmqvll pbfzgfx vtbdr ghshq pzcgr prgh zzlfrts lgllb cdvjp mdbq hzrzc (contains soy, sesame, fish)
zbqhtv mpqtc fbllk jdggtft xsfpzncj rhjhmvj hzrzc xqdl zclh sdgjxm bhxx jsqng vgsxs dlgsd ppb xmpqj tjxrc fsmhfr mdbq ccqf jzjhcm tjsvdhn jbdqm cdvjp lzxz lgllb qsqcjd jrkbs bdnrnx sjfht mdpql vmz pzcgr jlhpkg jdrlzk mdms drpn nvdlxkc jbxvkvf sjpx sndrz jtmlcg xgtj nxc kspzjr mhlm mpcsjs dnrgnnr mvhlr ztpvmk mxkfs rglpnc gqpdph ffjb rdkvvnb qpdb mxnjztb gsdm xlknfh sjpcmz rmd jjnd qhgg djsvj dggmkht cmzlkx tzzfktn (contains shellfish)
xgtj hfmkj ppb hcsmg rglpnc vbxnml mdbq jqhzc jrkbs rdkvvnb prgh bxv gbzczpn qglnp vsns jdggtft vlsprc gxml nbkdh mkv gvfsv zbqhtv zzlfrts pbfzgfx vmz lgllb gzzb xqsn cmzlkx fsmhfr cmrlm cglt kspzjr fdndh chbpkvt rkcngr qpdb hzkdqz kjsqxp bdjxjvj ztdctgq kmkcksz rltc kht qhgg xjgv bdnrnx zlqcps rjrn kcfjnr bhxx nhnsh mpcsjs tjxrc lzxz rmd (contains peanuts, dairy, sesame)
ckbsg jjnd mdbq xvbdz kjsqxp drpn vmnfpd lzxpk ffjb drrvln dlgsd zclh pjzqbc mvhlr vsns dkplsn mpqtc jhcr gzzb mkv rdkvvnb zzlfrts jsqng lgllb tzzfktn zbqhtv djsvj xqsn hxbl gqpdph qglnp hfmkj rmd xjgv sjxlr qhgg jrkbs kkcz fdndh kspzjr bhxx tjxrc vpqxh xxzjz jdggtft jlhpkg lcbbcb pllnld qtsq rhjhmvj rkcngr nbkdh tpgm nvdlxkc jzppz zsqn cdvjp lgdv dzhf xqdl gqsj fsmhfr jzjhcm gxml pfmnx lxhpmc vhsp jlmlz gbcsmlr ztdctgq bdnrnx (contains sesame)
xsfpzncj hfmkj rhjhmvj lmrbfm sbbkvr ggmgdv jdggtft xgtj mpqtc rkcngr rtcdm ztpvmk cdvjp zbqhtv zjj lvmm cmzlkx gxml mdbq sjpcmz fsmhfr jzppz bmqvll ktgf vbxnml gbzczpn bdnrnx cmrlm kspzjr gsdm qxsgkzt ztdctgq vtbdr jdrlzk gpmvkrt rmd tzzfktn gqsj jtmlcg dfzbpz skhxhp dkplsn (contains shellfish, nuts, dairy)
cdvjp sndrz cqlpzd pjzqbc xqsn bdnrnx mxkfs sjpx pfmnx jknscx mdbq kjsll rkcngr jndts qrmvtk lgdv nhnsh xsfpzncj hxbl xgtj qpdb qddlv lcbbcb vmz tjsvdhn prgh fjndlnv fdndh vpqxh dfzbpz zlqcps rmd nbkdh zclh dfvkm hbxq gsdm lzxz jlmlz vhsp zzlfrts mxnjztb rltc ghshq qhgg gpmvkrt qhkq tjxrc mpqtc rtcdm dkgkc xtzqb pzcgr bdjxjvj xvbdz sgqj xvmsx dzhf ffqndb vbdnhp vsns gbcsmlr jdggtft fbllk lgllb dggmkht gmzjtc vgsxs lzxpk nsndth ztpvmk nvdlxkc bhxx drrvln lflv tpgm hzkdqz vtbdr (contains fish, sesame, shellfish)
djsvj xtzqb tzqxpq jzjhcm kmkcksz bmqvll zjj jknscx lgllb sbbkvr pzvbfr krg kfft xvmsx xgtj tgtzx xqsn sjpcmz xqdl zclh bzxvd rtcdm nsndth vmz rmd lgdv qcrf ggmgdv pfmnx jdggtft fnr tjsvdhn kcfjnr rglpnc pjzqbc nxc jfrkn nvdlxkc xvbdz zbqhtv zsqn lzxz dfvkm spqqb fllmxc ztdctgq bdnrnx lvmm pbfzgfx lzxpk gvfsv fxbxj vgsxs mdms cglt dfzbpz qrmvtk mdbq (contains eggs, soy)
rmd vtbdr dnrgnnr mpqtc qhkq hbxq jtmlcg tzhq rkcngr gsdm qqttxln hfmkj jhcr lzxz lgllb pzcgr dqxvmx lxhpmc mvhlr vlsprc mdpql gpmvkrt gqpdph gmzjtc fxbxj cmrlm jzjhcm xgtj zclh vbdnhp vmz bmqvll kcfjnr ztdctgq fnr bdjxjvj sjpcmz cz dzqvbsq drrvln gzzb gxml prgh bdnrnx qtsq jbxvkvf bchsc ghshq pbfzgfx drpn rdkvvnb sjfht sndrz krg pzh dfvkm jqhzc mdbq zzlfrts sbbkvr pllnld ggmcmz dzhf tpgm tzqxpq vmnfpd lpts kspzjr vbxnml ngmk tjxrc hzkdqz xsfpzncj jsqng qhgg qdqfl bxv pfmnx qglnp nsndth ppb ztpvmk spqqb dggmkht cdvjp lsnj zjj dkgkc mnptn vsns dkplsn (contains sesame, dairy)
jfrkn gpmvkrt lgllb pfmnx ktgf kmkcksz zclh lzxz sjxlr xvmsx lxhpmc gmzjtc qhgg lflv dggmkht rkcngr tjxrc xtzqb gbzczpn mdbq krg ffjb xgtj bxv hcsmg pzh vbdnhp ngmk vsns gjvhr jdrlzk mxnjztb ccqf drpn ztdctgq kfft kjsll jdggtft drrvln nprb qglnp ppb jbxvkvf pzvbfr kspzjr spqqb bdnrnx jhcr ghshq qrmvtk mxkfs gzzb ffqndb skhxhp sbbkvr chbpkvt mbnr rdkvvnb rmd fnr vtbdr tjsvdhn ggmgdv lpts prgh zjj xqdl (contains dairy, peanuts)
bzxvd xgtj kmkcksz fjndlnv qhkq qtsq dggmkht jpztz vpqxh kfft djsvj jjnd cdvjp rqccts qsqcjd qddlv mdbq lmrbfm zbqhtv xlknfh vmz qglnp xjgv rmd vgsxs ccqf gbcsmlr ckbsg jqhzc nsndth gjvhr gsdm mdms ngmk fdndh tgtzx sndrz krg jtmlcg ffjb xtzqb dzqvbsq pbfzgfx skhxhp mkv xmpqj tjxrc hxbl lgllb gvfsv kcfjnr mpqtc pkknn sdgjxm zlqcps dfzbpz vhsp sjpx pllnld tpgm jdggtft jdrlzk tzhq fxbxj qpdb ztdctgq bdjxjvj tjsvdhn pjzqbc xqdl (contains sesame, soy)
jpztz ggmgdv mhlm fbllk pzcgr vpqxh dkgkc fjndlnv qrmvtk kkcz xgtj qqttxln jtmlcg nsndth sjxlr lmrbfm gsdm bdnrnx lgllb ffqndb cdvjp jsqng bchsc lxhpmc dfzbpz jbdqm sdgjxm rjrn nvdlxkc bdjxjvj ckbsg mdbq nhnsh bxv xmpqj ztdctgq qtsq qpdb rmd pjzqbc (contains sesame, soy)
bdnrnx sbbkvr kmkcksz cmzlkx fbllk ffqndb xgtj mpqtc hxbl ztdctgq jndts kjsqxp vbdnhp jtmlcg tgtzx pfmnx qcrf vpqxh cqlpzd hzrzc mbnr mxnjztb bhxx jfddkg bmqvll xsfpzncj zsqn qhgg fnr jlmlz lflv rdkvvnb zclh lgllb jbxvkvf rhjhmvj kjsll xqsn tzhq hcsmg tzqxpq zjj sjxlr mdbq xtzqb kkcz rmd gjvhr vgsxs cdvjp xvbdz prgh xqdl qhkq vbxnml (contains soy, shellfish)
qpdb chbpkvt hcsmg ztpvmk tjxrc hfmkj ffjb qdqfl prgh vmz mnptn nvdlxkc kkcz gbcsmlr xmpqj xqsn drpn gmzjtc gbv sjpx zlqcps xsfpzncj lcbbcb spqqb jrkbs lgllb xgtj vpqxh jzppz jpztz sjxlr dfvkm rmd ghshq kspzjr rltc vmnfpd ztdctgq lzxpk jbdqm ffqndb fgfl nxc rkcngr gvfsv bdnrnx pgdb mdbq vlsprc sgqj cdvjp lflv drrvln zbqhtv jdrlzk qddlv qqttxln (contains fish, eggs, sesame)
"""

}
