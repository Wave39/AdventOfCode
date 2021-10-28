//
//  Puzzle_2016_06.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/9/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2016_06: PuzzleBaseClass {
    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (String, String) {
        let puzzleInputLineArray = PuzzleInput.final.parseIntoStringArray()

        var part1Array: [String] = []
        for line in puzzleInputLineArray {
            if part1Array.count == 0 {
                for _ in 0..<line.count {
                    part1Array.append("")
                }
            }

            var idx = 0
            for c in line {
                part1Array[idx] += "\(c)"
                idx += 1
            }
        }

        var part1Message = ""
        var part2Message = ""

        for element in part1Array {
            var dict: Dictionary<Character, Int> = Dictionary()
            for c in element {
                if dict[c] == nil {
                    dict[c] = 1
                } else {
                    dict[c] = dict[c]! + 1
                }
            }

            let maxValue = dict.values.max()
            let minValue = dict.values.min()
            for k in dict.keys {
                if dict[k] == maxValue {
                    part1Message += "\(k)"
                }

                if dict[k] == minValue {
                    part2Message += "\(k)"
                }
            }
        }

        return (part1Message, part2Message)
    }
}

private class PuzzleInput: NSObject {
    static let final = """
vhrvabtc
rzzdexux
pixjplcd
imtxrwpe
jlowiwho
iqrfoytc
ulplfkix
beracsou
lnpbjpsd
tjkoiwfm
mbdwdtvc
ijzmhthl
afuxnmmo
oalhgvyf
cvnrvmmy
phapcaaz
qolkozza
cslnokax
cxmtylqr
celecybh
lhsefcli
ncuttavx
dwmgplhj
dqclavvr
jgxgitqy
lkermczl
pjaqasku
nscotnwr
lskrxypk
rqufleiu
dpebqpqm
zrzqaknv
ejtyokhl
zezxsymz
vprfwlmo
qbzpmtvp
ctrmxbgb
vfuzasvt
eksijxxj
rmehmkmw
qtyvhcgk
rlzkcewq
vhnnobqv
fxpeanog
anldlmad
irzcakuk
bqwlsnlm
ajqajujz
jdfncuag
uogfnhhn
kgovasxn
ahnehmpt
dupgxqzj
ffvmbzcb
hwwhqvuj
ftbirfob
sfpupoze
dcqqagnh
lqcfxgui
slaqsusj
zfnlsbod
gkkgjgoe
bhhwadtt
lkcahmbn
bygxiuuq
yfziyvix
tgxfibtw
kkmtqoko
dnpradkn
whjuxqnf
quxihhbp
fvucbrjf
seeczrga
xxdtjtzm
gibfcpip
pebojxbf
sqwjhqau
zcyoibrj
vvrdfjlu
noiuyxer
dqthjgoh
tujhtems
goqyxish
icyzsfvv
tidfdydu
wmkqxvhg
orojnwzl
soffzhen
kcfpfeig
dutcqtwp
nskossbo
jdvatkfz
lvamapuv
olvjpcyz
zkdaaszm
xnutyfxf
jqfrlpdb
atjrmgbl
srmrnnez
tahfxtwy
cgmbsgtt
mjidtwrh
ttaarqbz
ecpeurzx
bmperkew
wrpkpzxy
jxqukdgp
padrejjf
cykpjmti
gawyzbwk
ndwrqcnn
qatvgyoo
opptpjeb
knfzqjsw
jwqvgpfu
ngvxvahq
zcxpstzk
scizdgxf
rpijsqob
fshiaxsc
bkwyudab
xndzhivu
qabuelir
xbbknsmi
aymcyblg
udoozwuy
bxwhsfnq
rxfuclda
oviehgte
iwgomjxf
jxesodal
tkkbgzvu
cnbwowrp
vsswuzxw
qtgktieq
nzgnvskg
ealykgra
feynkmtk
lbkbojuq
lawckzdr
nserkqvj
ppnnvegc
qgifeoix
xztbecrg
tiylyrsn
jfiramgc
ugezzfle
mhsbmxqz
iaubkzne
hozhztpo
vujimqsj
jycbwqmv
zeiuejjb
byuvzcyj
ikhpmoqb
ufjcsjgy
cmcrbvst
ayunldxp
gipqzdno
qmsdgeal
sycayzfs
mszlvokk
xqwossfj
jnqfghnm
pluhjlnk
czlzxzbm
kyywqhju
dajubdhf
kehffmfy
mybcatox
zctxuwwk
ybkxkawc
zzwguxvv
vlsswpcb
vthsokmh
zbwsbxws
xstkrrwe
hvsvgsgz
qlqgzzmr
hzuhclce
yhfgpewt
eboyknhs
nqjvjcqf
nschhfdp
giupqixh
dbzkbrsm
ulhllnde
fzhmfhrr
uiparxqh
dxnnpfra
ludoygix
doqggixp
omvihuem
anijqdak
hovtlipy
jvhulxyz
azvkpvyc
ozutdhjc
sjaaziki
hghouxnn
tuudbkez
cfbjttzq
smtovjnc
ucipmtlj
gxmatiyy
kipdggkw
gpnweeun
fyzkpqbk
dctgbfih
tuhfntly
xoanamuk
jlwxdjqp
qzrnrjjz
zffubqwg
yujkbodi
srgfxrag
txvkzysv
eedczuuz
gosmfeex
eesqfxhg
bjldoflf
vvcbcnex
wriyojbf
utdjpovq
dxrbgdff
ivwlxlfx
uljthgnu
asruzhqg
qtxcvstv
yfaylaqg
wmnblvqo
huscfikc
eyqdkcvu
njbdiyhc
hvmeacpb
ocxsnfca
eybztcgg
rkqvbcst
umfkdhhp
qepkcwqa
xdnsscpw
bsoaexkb
kacsruck
mwainqut
pdoqwphw
uvblhueb
cwrbiibu
opcbzfgv
zzyqzgrq
qfgcrmpm
peujlgqi
nrfglgja
tfnfbtbi
cyqyqrtb
eqypdsvt
ovdmqqvt
hnukchfg
bpfhlilo
lkvwiusp
zzhpkwbp
gotqgblh
mgcihbsc
cvkatsjo
nmtwcazc
azenyubh
ujtoqfwh
qdwkjcaf
hurclzab
mrbbwxxa
rtosiexf
vjfyfzol
kwzltbnp
akjpxpnd
rclhgeyv
udsvnvkd
trlzccds
mdmcycpm
yuqetosm
yuyfnnbn
jwylebau
ybtynvca
pzsbkdxs
ipstuhyr
rcnnyzrl
ajgsynyt
bzpifcnm
ebhvzfpm
laehwkbw
fpinzejm
hmevkjyz
pijsuvoz
kpnjusky
imhxxryz
bbykcphd
eddgzrlt
xofnilfp
pdclvqub
xvqviwku
ahnximil
zqmdysji
sqoczvww
xkmqsems
qqraorxr
dapbjpyi
klospspq
ugqocfpx
ftjlpduh
hpvzalgr
lodrkkov
xjtoerjr
urfojzyy
jmbwqsdp
tybiwbro
nqguwpsg
wzjdbtvp
uamnromw
iiouocfq
vbrifvdj
zeylejin
iueydkui
ncyypjha
oalcyjvc
hjtigsai
yqbuzvod
hzjxaoxm
ozdtjqrv
umltuvsn
cyfxwaut
fpnrkktw
bsrtevsi
mwkpttud
lnmxrvnz
ohawlazx
pgwxgzva
wiqpvalw
lckdpqpj
fzfadbcn
mivmracr
xlezdrfw
escxeztx
dehufqkb
ykaidzee
kjxzlhxn
wxearyjh
fbtppgjb
jatslhys
mxiwwyoj
wjxsoisz
qvlainlc
wrpwzzds
ojylxjlk
mnjgamga
itdemmgx
eppmhvav
zudnruzi
fqhjdhrx
rgsjwufu
cfmcdsnl
qmyludch
diczbwrc
bptsolbs
gregrfuk
ggtdtdsr
vekxaxzq
iirnwtmj
jwimmqtl
ezrartxw
mgzkopvx
qtxhdjzl
ueoefpys
wryfgobw
gibrxmfq
kuozniuj
ezctgdra
fpxjfgww
soeicyjv
pookxsgw
ctatvacc
ymlpgowi
aekhewub
bogedhje
aygzjewd
bftmclcg
twspjgiu
xflvkyzm
weeihqco
bzqissdv
knhseano
powynbnq
ylvewtrj
jwidlbzx
drienpvr
rbndvvcn
ynhpvfds
sgvvoexs
ynrsiahi
yipvpmmm
ixxdnogd
ramwrfef
ndlumxte
tvkqfyeo
llkyyijo
gfcamayi
fdbicttv
giudovqr
jduryykk
ozsisrkr
vymcyjnr
fpoguwjh
zzehbxvq
bbzxtuco
creeinoi
pfgwqrcv
ljypthio
esyytrqx
vilobaon
yharsrty
pcgygoak
kdfzpikl
olrosiss
osivuyzn
ovevojlo
cwnxmqdo
pfmjddkq
znvujmtf
vkalccja
nvzhfpia
hyujfngl
ydefvfop
kwiwltvo
qjmowuox
menbophm
zmljxiea
icighnas
nssgwyle
wpxpiyjz
vxnupnmu
bbqsjnas
toveeodf
ootrclyu
jyklyedc
rbktfwqd
kbskmwua
shnkkdta
vxfkdxhh
debrhmid
itrzmodt
ylaankij
qcvlplpy
xlwksxxk
xdznurxi
olwomzpf
igqtqome
xchlumws
edcumpaz
pwjmdors
lhxozxei
hufvylqn
edfevfzc
gigdwfgf
xggpedlq
mlghgbfa
gjacxeph
sxvheyge
ckisqokq
xndeieus
gnxvdkwg
ahqogfbx
nxzgxhep
xpsarftf
zmgrmeqr
bhalyhol
ulejpxpy
vhehrjzm
wyqzpixv
nkpjwbgq
slwzvmua
tubeisgw
ojgqkxdv
krjwyfcw
mcittkjw
sndxlapd
xgdqjlcj
rgozyuiz
fprzkwln
gwbgwqxm
khwmbdkn
rwnqxwvk
agxbmadn
hyqnrdhw
dbomlwal
fbvmeuwt
qsfgenhl
udrfskjk
arajwwmn
fghpeqbe
bsjbfkdb
gaixdesy
ewchhofv
trjuuipw
eeumxzeh
heqrqakk
chjmlloy
smxcvpfi
vxwonanp
piygrizh
snxsnnfy
txsifcfx
rqitketb
mcbljita
mwmgeogt
sgvmpaph
prmpddbr
rxevhtdm
lyejgafv
myveantx
woyyuycb
srovvzml
vtudbulh
xfouthsi
kwgvwkzl
mtwmvmxf
ddtwlrzr
gtzwowtm
huzqtveo
dcgmqyrn
gtzzlhpe
ruvncyfs
lwsxibps
waymjoru
mmfdoxny
rizwihlk
cxaiotfr
ypoqbnry
anlquyqk
bhhffkkp
kkqhromq
tqowsiao
fqkzblsd
toxdebej
hozmnqou
rcdonbwf
usnojcyl
ufmpsswg
iefukrrp
kuysztiv
hnkytlvg
nabjcyil
tjtymamd
zghngkdd
mwbpuwmj
jlpqmghg
aslbbgqd
dbutwlae
oqdimirz
npraupgz
dakbvrfy
yzrdqvag
hrpaqgqj
qakbxmpq
utsimneu
yjqtkmdz
fqxlynyd
wknsbcet
kehwvrxu
vxxrvhcd
ctpfdlsc
atjmqkye
pkaaqbvv
fnmyewwe
dtlqqbjd
wsfyghha
nndsvqbi
wbaltpka
zjuhspig
isrerule
qugfdfjt
efjenzge
wadqbjcc
tvlcndmn
cbveiint
kkujfulr
wtnyfzoe
lmzgpulq
ihajkabg
pqiahufq
ravmkrdo
ldmftjct
rhgdweob
ahjzgzkw
vvgrueiq
hiyxhnim
gwynwuoc
wonxvgee
jxwtxmau
rggtslej
pbkwjyqf
ykanbgrg
xqcwldyk
nmlqdjws
yvpcihki
vwljaurh
wucszart
sshxhwid
lfxnrqmt
jvvkxeht
siobukus
edchngzp
mkmuhoyd
hidqtpid
wvocqxbp
jvwqvvpt
grxtjncl
eyqiipyy
yuxcubml
fksvcuss
apdkwcqd
bokchryh
ipbukstv
ifsynwcy
odcgknnc
omcsclgb
zhjrucwj
zloeydhr
"""
}
