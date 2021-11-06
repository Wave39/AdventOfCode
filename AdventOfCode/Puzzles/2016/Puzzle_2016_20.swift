//
//  Puzzle_2016_20.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2016_20: PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        func findSolution(addressPairArray: [(Int, Int)], startingAt: Int) -> Int {
            if startingAt > 4294967295 {
                return -1
            }

            var addressPointer = startingAt
            while true {
                var addressFound = false
                for pair in addressPairArray {
                    if addressPointer >= pair.0 && addressPointer <= pair.1 {
                        addressFound = true
                        addressPointer = pair.1 + 1
                        continue
                    }
                }

                if addressPointer > 4294967295 && !addressFound {
                    return -1
                }

                if !addressFound {
                    return addressPointer
                }
            }
        }

        let lineArray = PuzzleInput.final.components(separatedBy: "~")
        var part1Array: [(Int, Int)] = []
        for line in lineArray {
            let arr = line.components(separatedBy: "-")
            let lowerBound = arr[0].int
            let upperBound = arr[1].int
            let pair = (lowerBound, upperBound)
            part1Array.append(pair)
        }

        let part1Solution = findSolution(addressPairArray: part1Array, startingAt: 0)

        var part2Solution = 0
        var part2Position = findSolution(addressPairArray: part1Array, startingAt: 0)
        while part2Position != -1 {
            part2Solution += 1
            part2Position = findSolution(addressPairArray: part1Array, startingAt: part2Position + 1)
        }

        return (part1Solution, part2Solution)
    }

}

private class PuzzleInput: NSObject {

    static let final = "2365712272-2390766206~2569947483-2579668543~1348241901-1362475328~2431265968-2450509895~2146385-2259474~2935960035-2940597034~448888033-460770571~1993433098-1995841061~1479295247-1481053053~2315798162-2331724795~553124643-558300256~2221609952-2221736791~2528284970-2536413665~1003828483-1008019254~2460073010-2461391392~1756403373-1774263374~181708677-181820620~4105906368-4108964079~2803753677-2810396331~3872622758-3876157728~4222455331-4230019102~2566685080-2569947482~2546666999-2560222508~2563776047-2567373420~669206125-670672126~3047016482-3068254467~2412767568-2415681466~3832227190-3836056110~1752672085-1778896581~3612964446-3613428692~473462452-473507720~558414399-558825886~174888587-188726755~3681687609-3688894180~482298773-513769024~1105376539-1109259196~2626549708-2635018162~2221569800-2221688559~3217908441-3218365608~1839378196-1839704131~4006631148-4018637666~1033070477-1039079720~3614366173-3619803122~1651631132-1657688516~3148614241-3149307836~2922404131-2925650734~2967474818-2979959263~3674334884-3677432948~2194863661-2195245017~1723397977-1746877683~246394156-253325513~577459246-594741177~410425445-412372582~1287281042-1288450150~2546572083-2552459138~3284505169-3292205355~2572957308-2615378907~2689345749-2699114021~3296227141-3297518289~3695819772-3697468770~412372583-422306605~2699114022-2714857638~2059138236-2060952632~117089981-120121935~2848444484-2857342976~352052590-358986830~2656447256-2685668729~454980721-460461657~1027539209-1041751363~1913417-3826887~1062494257-1082863054~2282966419-2286017938~394757734-421655845~2106693263-2115236723~1124719891-1127653202~3292205357-3293681013~117011952-119543627~2181915940-2184656064~1045705528-1078679114~290113491-291311039~2278026399-2284902493~841914150-848969885~3952731875-3959197013~1938643863-1940674602~1036550327-1041084034~63607243-63644812~3769265734-3769975585~51653989-55144083~1799892196-1812471751~1371739118-1372165373~3561636732-3569279384~1823678708-1830435069~4012340693-4047186502~3697468771-3719107288~1963424400-1964720496~254179574-261945026~2639565460-2643861101~2489776747-2498561347~1528974499-1529888310~2272121277-2279366265~2063178650-2063502047~2631423649-2635927617~1360641171-1369732967~352866001-362403909~2982988833-2999220870~2226316378-2236701767~3581998091-3588302160~3905167888-3909688736~2410405177-2416922214~2221793009-2222205811~1682009735-1689579607~2551217715-2555588513~4111825736-4139764825~1495499947-1496504480~1126815599-1132033603~262946528-267481743~2190431207-2194125961~3056852838-3057666713~3852657771-3855744213~814188270-815660610~1370082674-1372874146~2698266605-2707295552~2623491116-2632182274~556237979-558470744~4221727965-4242434586~1373248698-1389927798~3269334240-3276265066~2266535688-2268367969~3098582122-3101205009~1909408103-1909548530~2822711293-2831177968~848969887-859626993~46887186-54157057~2762897904-2771117185~289933294-290354931~1088830930-1093432672~2443230763-2461276873~3160139479-3173260442~1527097290-1531435951~1799540955-1800006056~1369732968-1371815843~2622838271-2625104782~1173393865-1173503336~1909254997-1910983838~1299664180-1322001993~1688665208-1691812251~1887810466-1890884113~2869886503-2875645396~582392092-606025972~4267022320-4275265906~3859201994-3893484463~3589262267-3596650599~912537182-912907636~2221654107-2222088287~4057523345-4060042618~3697080984-3697115223~970916665-977773714~1357371244-1357771399~300561490-351155869~1312775715-1335513565~117013732-119708846~425465828-460547231~1934707608-1943900203~1872455505-1883131224~1265429510-1270058235~1351349572-1360842989~3949672363-3965375662~757393179-769131755~1140550254-1155907063~2362581541-2384858143~3767349312-3769448384~1010152192-1021680403~3719107290-3724947612~793186065-798493071~3543437818-3570393128~2142580414-2155598642~570014715-594180691~2268145476-2268275380~682993360-688547687~882429283-885295513~2061317899-2062340917~3080454969-3087996304~1509787381-1515229305~1792788995-1805479181~471893034-478588629~2469289299-2469834064~3435184443-3439758093~1972314440-1984109813~897623204-906019235~3309685433-3316891985~2022851-2168311~3425944138-3434725507~1573705848-1574774103~1843461004-1851252409~275830302-287491224~1099676859-1106356804~3201885249-3216240573~890516875-914189870~1045475561-1045705526~858602633-861745342~1722754472-1729362918~1999030390-2001346788~2295812200-2297395314~545671618-547361797~1925762580-1932504567~2469834065-2488585001~962891401-973508116~3056544703-3057098061~1964666710-1968283715~4153249699-4156067673~2269509587-2272121275~113577026-129098597~2544925116-2547575012~3930954397-3932696547~1940360721-1941087983~989005807-1006335777~1715546619-1723575645~946249856-956419020~2580089074-2609078369~118138523-133562721~1418940971-1433573243~3116049988-3117047351~2819201530-2820204193~609029102-631859346~1236996385-1243667312~2071060282-2090563034~3275297026-3287385948~557242553-558842013~2340595893-2346006065~1763694009-1772957054~3039028781-3066739550~2678983882-2689345747~1496448610-1497010926~3783756301-3783968438~4011127020-4023009734~2455737032-2469289297~911816966-912509075~2275917994-2288190359~1405416423-1419176714~2642680237-2644300616~3826507233-3826769507~3791085814-3803870306~3990925848-3994761120~1574446563-1576228425~1634308286-1635388054~3770072854-3783827763~859626994-872001663~1678998549-1682009733~3615640609-3625220434~3756046034-3759831577~4219956234-4225730655~1944691819-1972314439~3232924024-3243647347~2819804415-2821623032~1041187113-1041438684~1234384868-1251566238~1707319358-1710481231~3338081719-3342039539~3919045080-3932932694~1618322267-1618915594~1196499550-1204759606~354238054-359105442~2788225259-2807617695~1817797800-1818404115~3314463142-3319629375~3220899130-3223901824~463163318-471893033~2108731258-2118466370~2531905696-2534895562~872001665-885348477~3618924494-3633614536~1286808229-1287787318~1686812571-1709789731~1667289113-1675800071~1288046293-1288760085~115133053-118531268~3084925009-3087972171~2107005650-2118671640~2206689406-2208120987~2965687206-2969477736~2789286984-2795621824~1510800557-1520242850~1372577266-1373248696~3908185397-3914112662~3027341861-3028862050~2551506862-2563776045~3457830284-3476082138~2330638928-2335068417~3754091818-3760153804~1700898897-1708456845~2653919552-2678983881~1718586248-1752672083~1909974346-1911447514~740859879-743318742~632094677-641123609~2717310519-2722969125~2429156614-2450453303~3573769011-3581998089~804909837-807598669~2645933387-2650206634~3906744049-3908084382~1088710392-1093793913~2945948817-2961003764~2154975171-2170652704~705358087-723167844~2623774017-2637924339~1527448631-1531925852~541284581-550148134~822228123-845259076~2725319909-2726283018~90504693-97857953~2151018859-2156845889~3875175237-3880661438~2174472127-2175522174~1053913106-1073312877~4151957167-4159217706~408096359-410929997~3494935822-3518493936~4018415387-4034413199~1318527150-1335393593~4094276281-4100264566~3296618992-3305730207~3827540382-3834020598~1792716600-1804353554~486286244-509649426~2820166268-2822489545~943117353-944243402~4250879477-4288162587~1092150174-1096445797~659715146-669206123~424405829-425465827~2903268723-2916344920~2825756580-2827850093~2197813619-2221567221~2222205813-2242661939~1909398015-1909639813~2085646-2171133~3237410359-3243293444~2488585003-2500532520~1719496111-1733109286~3101107881-3101724703~4292290133-4294130012~2682533716-2682557737~478588631-499658423~2056703122-2057132500~10759205-22974868~288949273-290120633~3295342764-3300711505~4144392189-4146507469~1377845154-1383061661~1470042236-1484545053~2929570686-2942193911~663447966-667304777~2250137488-2260767053~2916852498-2920130617~560916716-582392091~3826421034-3826753059~4205391625-4209582225~3098065613-3099195513~1523618109-1529220622~1280876899-1287180580~2896461712-2914779142~3059619066-3072535463~3594066104-3603694944~206442883-222778068~4057343389-4058593137~3040726007-3067509699~783978732-804864426~3782497016-3783855888~3771309186-3798156648~1806086747-1808455979~2509648237-2520128379~2655519435-2688778011~466454947-475885979~764443451-778431348~942699799-943817373~2707406125-2710335531~3532789271-3534889466~161216255-168066537~3959810178-3972378256~1216245-1730562~820810878-827132162~3840466779-3849871670~241662240-244306234~1308539-1732730~2644300617-2653919550~1245139600-1257000695~472344288-476821359~360421650-365291918~4157074002-4160043617~3475229162-3494935820~4021239535-4026837101~1122221983-1122467302~3524503684-3534615536~294914250-297074740~3315785542-3320016807~3207399725-3218904107~3399796042-3432628902~2415031178-2417587472~637037746-641909503~4125051011-4125349366~2792226042-2796333812~1090609063-1093811054~3826753967-3826928901~2845981709-2846071766~1884551628-1888679834~1867383722-1901804607~1138049177-1150698174~2489168484-2503275369~3844741449-3859201992~2059227603-2061190162~2725980853-2726316169~3950461578-3982076979~2964040486-2971816053~3117022269-3125872507~4205459617-4208901905~3223901825-3259939574~2043681871-2056703120~2862497588-2874433217~1545573025-1550810115~558470745-560916714~2204957059-2206941462~687956243-693820818~1006335778-1027539207~1683104091-1691973027~1281662230-1286185165~2457027525-2467523425~3910944384-3915139260~1812471753-1823678707~3439758094-3449375742~4180271874-4183028052~3145750655-3149232555~1063127835-1081739469~912453784-912787957~757841367-763656320~970465196-984461751~2682535644-2682561899~1103041548-1124501094~711829065-712418631~786434450-810431275~526718776-547605908~411642224-419649420~442563986-451494166~3916556398-3932893207~4178915874-4181659654~931371848-932759051~226571744-227466085~586436371-589611958~2138685204-2148239206~2786369133-2807032221~3902400566-3910944383~356708623-360421649~1195358721-1201587206~2986693403-2997511709~1160749272-1164268031~1138794253-1160582337~1316625314-1322081912~2546426233-2547478858~631117298-638088180~490462991-510876262~1585596253-1598442115~1691404689-1708777514~21958182-34768708~3033283449-3033532644~850358573-850941928~2532323467-2533835875~2571607510-2576905211~3838468698-3844741448~3633614538-3658935402~1267571462-1273337904~820046167-821948762~1818557964-1821003970~1656682467-1658689820~3572000906-3576107308~3518493937-3521124207~2316622941-2320028763~3234261481-3244439202~1762170451-1767000441~403695570-413282241~1446563227-1455229013~994814766-1020194067~1103304248-1123109762~1358159388-1364262240~2643072595-2647827063~1761152300-1771038779~814235534-818070036~3658935403-3674334882~1143690782-1167938223~956027555-959929296~78736212-103134510~897919912-910244590~991162491-1009670900~3730115132-3731119302~3693059535-3697085999~310695719-311355138~3792190887-3811128942~3236342985-3241419480~932285275-939464714~1690112643-1694719438~964486517-974083673~2886004632-2887772395~400201502-410632385~4151877322-4155177505~4146634947-4148274967~4142431183-4151685720~108233930-110782083~11764001-28124816~255280185-265644134~1604894700-1610024510~2746388028-2755644917~257526100-265688716~2979959265-2981174695~3675625153-3678243537~946960127-957058942~158966202-168896939~885386378-890516873~3944559186-3950461577~3436884337-3440035586~1998995929-2004489839~1029028825-1029925818~860116537-869330710~534657657-536577765~2792605215-2809178574~83479693-101592615~206521107-208527729~3681963513-3682865724~2913358381-2916852496~3172620089-3183275609~649130727-656267839~1264638271-1274096286~1029718677-1030140380~3643603238-3653831146~3061231145-3063632127~2585980608-2609955243~1316394181-1319520040~211076367-219280164~3240385969-3251259062~2120060-4441033~3278363479-3278515140~3831551420-3838468696~1173779057-1176512368~4071597616-4101375293~2781084212-2783642342~2743354447-2760958028~4114529275-4137230617~3752969032-3767349311~424150040-425393208~26532978-29480043~1006115405-1009958851~2845371314-2850260793~1267920977-1271152591~3709512503-3716036930~3368253421-3392905399~2452693801-2465509837~3534255481-3543437816~4160043619-4178915873~3954591115-3974152768~677298953-691027000~1685806773-1690772816~436652774-450179768~3588302161-3612662806~83367242-100910390~1633907668-1651631131~443592135-463163316~369907897-388846763~388962875-390004346~2306861374-2315798161~591078-868213~1229951959-1242298204~3014332113-3031527143~1171615958-1176617364~3062064123-3063637314~2087862269-2089342604~1672729270-1679677272~3733541117-3748642488~3075188797-3083692289~2520128380-2544925114~1997250353-1999097991~2326010770-2328459525~3335649815-3359666038~1093811055-1099676857~1939453065-1940109461~2260767055-2269509586~1694740480-1710532828~48862588-54135685~2194651149-2194876489~3261664286-3284505168~712077073-718032346~2714857640-2733949192~3084808742-3090381388~2326056027-2328734209~2966286735-2970371217~3682357002-3688783396~222778070-246394155~255495869-263746137~778431350-801595041~554816671-557769418~2287063002-2290447136~1204759607-1221061934~3191695158-3195022731~1937411520-1939682964~3683208458-3683317560~3724947613-3752969030~2655947194-2686070304~3319632926-3320555728~3874349431-3892283480~3524323559-3534255480~3392910453-3425944137~2864015808-2880343338~3603278173-3607977481~2221685432-2221741276~3821784373-3831551419~2340560220-2355630152~117804595-135520674~970739667-977759407~612826307-617050682~2420630784-2422511751~4041221294-4053276651~1783176414-1792788994~1661820734-1672783713~2285020555-2288812517~1145717399-1147147799~1160582338-1171067340~2969768222-2978509720~2241558918-2248366876~3842088825-3849544675~3220876335-3220899128~3612828177-3614366172~1848099469-1860064576~1453352598-1457451860~4131921387-4136290418~1186411872-1221604187~4271276227-4274727942~1972041789-1977505124~3130652998-3145750654~4206797669-4211676679~3382975599-3392910451~3075497812-3098065611~2819298198-2826283738~1358156767-1363896494~1209838280-1225553470~3101724704-3130652996~2874696153-2876992505~1279193633-1279368007~2044384098-2052585053~1778896582-1783176412~365291920-384429458~1410453073-1423638312~3149307838-3160666386~3115765500-3124715535~2524674650-2540040296~312386716-315692662~3195022733-3220876334~1528945394-1531524966~1190783271-1221823104~1374677110-1382957599~496392908-504137572~3152103031-3191695157~1706509680-1714907014~2642314466-2645833233~3893484464-3898889230~3331226932-3338281520~3421612598-3423251948~2376098338-2382856038~30669693-46887184~3701470920-3709586949~974101275-985095687~3754694204-3762024757~3199920021-3213832756~3937237796-3943044170~519102356-526718775~3595418820-3608680530~3132319868-3142292446~2415135665-2422698971~2512723394-2531872720~2831177970-2843852399~4067331024-4083628214~974512957-981076935~1939102143-1939797065~3362465663-3382975598~1081727915-1086599484~62892604-66661231~3596147589-3597403547~2427949019-2455737031~734503945-751972019~4274360201-4275638496~546152564-553124641~1672412404-1675035441~1799317782-1799878394~3899929168-3902400564~2090563035-2093365570~2502990872-2504573807~196879713-202383888~1041219675-1045475560~288505150-290311818~2335068419-2337479072~3115770397-3116114052~1759780530-1779756738~3848355565-3857570445~2887262512-2892926939~3297920188-3304753747~2837362258-2846430149~2365620967-2397295181~2130880010-2144109636~850356647-852183547~2547575013-2555977963~3293681014-3298307912~2838677121-2848444483~1378317671-1378385207~3932893208-3942847442~2775955760-2802739818~3000621764-3001860005~3878325586-3889110731~1634960329-1635718125~3570393129-3575649486~3359666039-3362465661~2221578838-2221700311~307265752-314765240~823227617-824317407~923124066-946249854~4151685721-4154340765~424138334-424809502~2057132501-2071060280~647961093-660004652~3307622347-3312520961~3259939576-3281494745~1887577612-1888900146~1189371904-1198571936~1234031907-1247954865~610600287-612214510~1630355907-1632283896~1634415839-1636037634~3824506379-3826246351~3847566968-3849532976~1588959146-1616167991~4142261326-4149638559~1813668039-1819668003~269833124-284269645~1445572315-1448859107~3312520962-3326324517~4134904662-4142261324~286352057-295053323~2093365572-2104458852~2964496323-2978996654~1589041634-1610897669~4017779362-4023249218~710580357-719926955~3695217573-3697711534~3119922419-3128398873~1973300202-1979672054~2647661251-2652365333~1618800796-1618963161~914189871-916240439~70592825-75578072~1931515004-1937254405~2472726189-2479284501~2073603890-2087967511~4288162588-4289142874~1651148640-1652304033~384429459-393421986~208944718-214460830~250825858-254179572~2845961347-2846405094~3683052176-3689023082~2548531964-2548558043~3326324519-3343805565~351155871-359398929~4232721631-4250879475~3459529479-3474108150~1909441969-1909689691~1932119221-1939290766~2762860344-2765962584~942511347-943894644~3682865725-3687083046~742172772-743598853~382176907-388584692~4086908517-4100905688~2961073615-2978624771~3753936484-3758588765~357622008-361838888~393421988-409475636~4210437626-4216399302~3866457812-3901968872~943727563-944059707~2919715277-2920771136~1627803704-1630982586~1111194889-1126815598~1637697658-1639829508~518330921-521079203~558771603-558831008~1627521188-1629733196~2531822532-2533342258~1722060329-1725371759~916240441-923124065~2267284366-2270810897~4289142876-4294967295~496711691-511059121~297074742-300561489~74957232-86751750~67820201-89362971~879194017-883306027~874758234-886383957~518363334-546855682~606025974-631117297~27195455-41332971~2870905604-2878387377~3084839165-3086179322~4152483704-4155490661~3992240000-3998336821~3612662808-3613179304~2144109637-2171654935~2912881674-2913811866~3683215934-3683776929~744692065-746814759~648698022-654389148~770363291-773532218~1961187739-1981201058~833212292-844968840~2279366266-2306861372~1525437167-1529355367~783203836-797187462~743069797-747604954~2726435221-2743671505~716822331-723267087~236924668-243049788~1819907565-1821265293~2459006570-2462769060~261945027-269833122~2251634561-2252542708~3077512678-3082900025~4178034955-4178140732~517575846-518330919~1833921219-1854646670~1863586802-1867383721~1688123912-1691016809~3613097833-3613214641~182210169-189009626~299267101-339546807~829601778-834904352~481358143-505095971~2224935194-2228740812~4083628215-4105906366~3938942245-3941751692~983920144-989005805~113931896-118379003~3330676862-3358266446~3778252069-3806861354~751972021-764443450~4108964080-4140242300~1576228427-1585596252~2268397999-2270766178~1924059333-1931515003~3938054379-3940855319~4216399304-4232721630~203859682-211512236~1506317175-1508820099~2082159387-2091680640~3509536520-3513399808~152981470-173147952~1984109815-1997250352~2104458853-2130880008~2998034397-2999606176~2081152422-2086162418~1628568484-1631818535~1469298549-1472797586~2706655046-2709540287~2171654937-2192635909~3997842771-4006631146~3806238246-3814481469~3687035617-3693059533~1714907016-1715546618~2268214620-2268517442~4168814485-4173314719~4290592397-4294496881~3026587742-3028212258~109629716-117011951~2227635708-2258663804~4153336546-4157695457~4183028054-4210437625~1359555284-1365047163~385317924-388866137~956914163-980424242~971923920-984657935~3372104235-3387022483~2459697795-2461023615~4054424978-4061962114~2531190780-2540332177~981076936-984403766~1943900205-1955571856~1092170655-1096453697~4188253293-4210273531~1476473552-1484327172~422306607-424937626~3616461090-3629002324~280581464-294914249~1814486124-1821348543~538601282-545721176~4165166009-4178721021~1988368657-1999218926~3683738155-3686068920~2339202139-2341973045~1618530377-1618985589~1061405927-1067161088~1586686087-1588534608~4187607606-4189350663~1129004649-1138049175~3769446976-3770072852~2023963853-2036589722~2154869719-2158914742~4239846195-4246356778~4051209708-4054424976~2896089935-2914808278~1435815375-1450285026~145909747-170128283~1885652106-1891564474~1282644829-1292952382~2286826126-2293672278~818070038-841914149~3335638754-3341961960~1618857702-1619359406~3939705062-3944559184~2203145858-2219094358~3769401246-3769482197~2922943756-2925135318~3468068444-3477636928~3778956860-3790280017~4073540020-4096504022~3814481471-3828523511~1415617645-1423826462~3031527144-3033419898~4062168143-4068151354~1286492281-1286940405~2428194387-2465453645~801595042-817285567~63581388-63635672~4117266117-4119442082~11602511-25799879~1092570588-1093985932~3296956776-3307622345~2221567222-2221613969~558232945-558709807~3639754422-3650743589~3437931121-3440846855~3675035968-3681981311~1433573245-1442758111~1471139709-1473858291~629519040-641689686~4117209430-4119122433~52713726-57736371~2706992741-2707821184~3602086332-3604188767~3915139262-3922929260~1634469269-1636558185~2200025248-2210330662~3521124209-3529596728~1086599486-1093798819~1309801249-1314575942~3656835500-3663825208~1519294415-1521662532~3848027323-3849548785~1907694975-1914277280~1318019570-1322413873~3338464003-3356847371~3982076981-3997842770~1267783432-1278940858~1658689822-1678998548~2857342978-2887262511~4061962115-4062168141~1459666268-1492181176~2615378909-2638121319~4134040495-4139294664~1278940860-1279210793~670672127-703998141~1279368008-1294345099~1816032308-1825117169~5682-591077~3367275968-3384214515~64315567-67820199~2502622426-2509648235~2384858144-2400945744~2328968349-2329640362~3697104193-3697121849~2192635910-2197813617~948400714-955452470~1616167993-1628568483~2344207001-2347832306~4065174279-4066995234~2501136056-2507987954~238478069-238584796~2983949242-3005737605~2500532521-2503210360~1393768957-1418940970~4267061677-4267804887~1878114-2022850~1632283898-1647333210~2400945746-2409724446~2869179197-2876746583~1106490177-1115256489~4061093101-4061131252~2810396333-2822711292~885348478-889915910~1830435071-1837694596~1837694597-1863586800~2658513248-2682334850~2924284916-2928154608~2880061840-2880744733~2598258370-2614301028~2919390200-2945948816~724929680-734503944~2662412166-2665780598~1178177517-1198965930~1557905942-1573183772~3563817129-3577035331~486771190-517575845~3645420942-3645846054~703998143-706055398~2004489841-2043681870~2409724447-2427949017~3620235480-3626019843~1551168080-1572791868~3438270145-3440465241~2043792287-2048576193~4189961855-4207923535~1572791869-1573838792~1560630061-1568705988~1945995416-1972395216~3154257326-3170804412~2638121320-2639565458~641909505-659715145~706055399-724929678~1322001994-1348241899~178460965-196879712~4290596074-4292022319~951225450-964656102~1286720286-1299664178~4267798816-4281427565~2473150224-2483209210~1466959722-1495499946~202383890-206442882~2980151171-2982988832~3724920258-3748749341~3449375744-3467888004~4793565-27195454~2763578266-2769445414~3551501696-3577270805~103134511-108233928~3985777319-3995983153~4056112707-4056303018~1113372127-1127291361~3450126345-3475229161~4289501916-4292619355~2447323006-2456025596~3080941568-3084548509~3455764745-3467066059~2180674525-2191641368~4011611611-4029364618~2171134-4793563~315731014-335056809~3397886846-3414158394~2762557710-2767579504~1521662534-1545573024~1442758112-1459666266~1415183222-1422510841~1396869120-1432423701~173147954-191770601~307244055-331462148~303700109-329107070~3367139562-3375242354~1257000697-1267783431~3441110255-3441542687~868214-1216244~2348268821-2362581539~135520676-152981469~3590167439-3598674695~1497010928-1519294414~2990327259-3014332111~1174787708-1178177515~3724679263-3737472563~3530672381-3532472131~2337479073-2362367605~204565716-213455559~2725271867-2749432076~3527158276-3529338030~1732731-1878113~2234307311-2250137487~3503793539-3507292135~2764054784-2767560591~0-97802~3497142772-3509229752~2252345137-2252983294~2511786509-2525437254~534322385-552469473~2032077105-2039311638~1930871028-1935831989~1999927802-2002593859~2034870570-2046166201~2416773420-2418971941~2326019770-2327054298~3587252557-3596385967~3004640283-3006650230~2504389437-2504604683~1389927799-1393768955~458800944-461346308~1225553472-1229951958~1901804609-1911376516~628245201-636898070~1241514379-1244482846~1911376517-1924059331~2179314-4534265~2590117386-2604230483~1171067342-1174787707~1526785599-1531893226~3055633094-3057199924~1568124522-1572160758~2966347008-2978486706~54831687-66550552~1550497473-1551168078~2892926941-2903268722~2771117187-2775955759~1234521852-1241992108~1691973028-1696406355~2837877932-2849517138~2480932114-2481698709~2845946431-2846057821~1233941434-1246198098~3002861655-3005365109~3434725509-3435993674~2173341542-2184849378~3896230707-3900645720~822740965-823550270~4110021562-4121150778~63603171-63635151~3132070451-3134002144~4152899097-4154706289~3072535465-3075497811~2963912450-2969754776~3143800036-3144360416~3033532646-3059619065~2870120437-2886869710~3274547143-3278505007~2749432077-2762094882~1081689983-1081835641~850604533-852396063~238560784-238982766~3023322565-3025688956~54157058-66147301~820647222-823031869~2961003766-2967474817~1576566644-1606323350~2582544240-2595513897~4151772914-4155462854~71629773-74290540~2762094884-2762897903~3179890008-3180299038~4012179467-4051209707~1967679449-1971418911~2845141471-2846053808~2816320795-2827745715~3780956085-3792190886~3098898720-3099568383~3275561729-3284901540~1402054763-1425346693~1070235712-1081689982~2897914307-2900470075~2823031175-2825449030~3751706906-3751753267~970815395-976275417~47997723-60304756~3794263864-3796550694~2743705045-2750732810~76689052-80924970~2919462546-2939875618~376886072-388318966~1787682465-1808426641~856379509-864589444~2378537309-2380543166"

}
