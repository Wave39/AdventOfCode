//
//  Puzzle_2022_03.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/2/22.
//  Copyright © 2022 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2022_03: PuzzleBaseClass {
    private let allChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

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
        let sacks = str.parseIntoStringArray()
        var priority = 0
        for sack in sacks {
            let sack1 = sack.prefix(sack.count / 2)
            let sack2 = sack.suffix(sack.count / 2)
            for idx in 0..<allChars.count {
                if sack1.contains(allChars[idx]) && sack2.contains(allChars[idx]) {
                    priority += (idx + 1)
                }
            }
        }

        return priority
    }

    private func solvePart2(str: String) -> Int {
        let sacks = str.parseIntoStringArray()
        var priority = 0
        var sackArray: [String] = []
        for sack in sacks {
            sackArray.append(sack)
            if sackArray.count == 3 {
                for idx in 0..<allChars.count {
                    if sackArray[0].contains(allChars[idx]) && sackArray[1].contains(allChars[idx]) && sackArray[2].contains(allChars[idx]) {
                        priority += (idx + 1)
                    }
                }

                sackArray = []
            }
        }

        return priority
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""

    static let final = """
mjpsHcssDzLTzMsz
tFhbtClRVtbhRCGBFntNTrLhqrwqWMDMTWTqMq
LltbngLGRSBgSgGRCJdSdQHvdfmQccmjSQ
lBslsZDDWdGdGpSMts
grQhDvqLQHDNGJJtbRMQQJ
HChCTnnLCgCrTZPPFzzVPcVD
ShrzjhNGrNqrhWnHHfVHbhnHbbhH
RBsvcBcDCdsRTsvgCgcPFRQpVQGQJPVFbnJfbJ
DvsTsdlCBsGLrjzmlqqz
WJJqZTgCnBLGCZBJCJnTLggTDDSDDMNdDSdbdSSsWDFfMsFf
PVjqpVHmPpvmcjhrRprFmQQffbfNbQMMsSMQNQ
cwcpRvrVlVgwtBwZqBzZ
qfJJmpqpmhsggvvpVPZCrhdFLFzZFDdLLh
CtCTBctGcGLSzZddGZSW
RlNjBCnjttBHHMMcQHCsRfsbfwgggmmJvmgfpm
ZmcgBBZhZMsnqnCPjpHPjLHp
dGbNwNtlTMTzGfNvTvdwNGVLPpQHPjLQPCpCjPqjLbpLPR
dvDTdfvNBhDZMBDZ
cvvRvbqcllbBVlvVVbVVlbVDjRjDjdMsHPZPGdDPGPHrDP
FwtpfwJtWwNtTTNnwFCtjDJsQdQPPPPMrjrPJHjH
CwFpnppgntShgbsscbms
cWMFMQpFNcvNDdBDgdsT
MPrrfrCHBBsDZCBJ
LmLjMLjjLWpVcRVR
ZrRZqlZMqTWrMDqwvnvVtnsvddvVnlVf
pQNhhLNNGmLjhhcfvndDpffdfdVf
QGjCLCQGmNgPBQDFFgTMJWWwMRTrTZWWBWTr
WrZWZPHHWZHprZVmVvqddBttBBhGhtvh
gzDlMTJDMfqhBGllhl
jJLqMMDDbbqjLpPHcsHLWZspPr
bsSVRVGsrDstrrSjcQjcjlPwzjQl
gHBggFNTTvTgfqgCFzljWwLWQQQnrwQWnf
NvJHgpgHvqBhNBJhHTvpBCJCZmtdpDsGsZdZMZRbVbbMdrZs
MPPtPwPnRnMPPnwrtNSGgLSCGGGNSLtSgD
hBhWFjfCsTbbbWqFFWBBqBhsWZVGSVglZHLSVDlNWDNHHGgV
zsCfTsTCMdmRPwzQ
JVQVvvszzvTsVsVJjctppcCtjtPRcTlP
MdFgqSddMqMDbtDlNjRDSR
qFZWZqwHlZfZvzvZfLZn
vpqwQSsHSHDQzDpgzwZlRLRZRRZTnTrrvGhh
JBcdmbmFMPgPbgfrZRZnRFFnrnLRln
JNdBNgbdJmPMWSSDzwVDtwSWWW
BDMcDDppHCStpWcHBDNtzPJjqGlllPMJzPGjwjlq
CZdZLmgCdqbPzjblZj
vndLfnghRQmVrhdvgBHpSCDWHBBCVHNppD
WrhrJJGSWzpTWwts
VlLPmqgmRNZRGwsvttjgcwsT
PDZmlbdVqLmPlddVNRDmmmbbSFHrCFQCnFBFJHSJGrDQCBrr
hvPdpvhHvHvPrNfVhDfjggFfRV
zlGwJGslsSDRfjsg
MJMWjMJzwqWGzJwMqJBTCmHndPPdCBvmdCpmHn
PVWFpQhJhFJpGbRCvRHGCp
jgslDjftsqhNglTgllgTqMnlHwCcvwZwRccSRCbGSGbCMHRw
TgjhNNnjlTfjTdDqTfhjnmzmWPzWrLdrQBPJFWJWBB
qPPRMPlfSzSSSPPnnLnqMlpQQtrrtmWpbFtQrdzrtrWt
BBvCcwsVThsBgswDBCFQHQpdmQvtrFpWFvWp
gCghTJgVCgDGVMlRGMqZnSWqlM
RWbHvrbHBsbWBHJWvJwMtmdZwdtmdvwMZQff
DRVjcqhRchhGGllhCgdGQQzfttzGQGwQfg
cDRljchpqTcjDFTFVcPcPCWBHpNnJNNSnbWbHHrSpWHr
dtHrRrBHrCRhddftjgBrRhgjsbbbMpbSWSTjWcsDTWDbcW
GQPFVQVQnJlqVMDcMzpDfzpDVD
qZZJFLlLnvFFGPGLPqnJvwQldfgHrBRBmBhgNBRHghNhhwRg
rLbrZhPgqZhMdVFSFTSGCqFG
zsszfRzjtHtzvRTSDdFFCtdDdtND
fcwllfmwzRHlfmmzFvQQLrgLMLBZhJQZPrZhJLhW
sllrCfpQQJpMHLgzwDwpNqzzVDpV
RZPFZPGcSMFtGPRGMwNDVwdRgzvNwgqNvg
hBmbMcBmcThmcGtSFTZfQCJjrHLJfsjhWJssJl
DqGCbGfCRhfZCVbbqDJJGJBgRNpNdpBNNgNBBNwHnRgt
rcWSsSSPSQtwBwHD
MLscLMzvvTvcTLzvWWFDPTTrGqmFGGqCZJGbblbVbVZZVmFJ
FprpsLQTrstQHNmVSVml
JMggWPggWcRbwgJPCGMcGcfmzHlMNSjfzVNhHfVtzSMz
cwnPnBwgnGRgRCgRbWJLpFsLtFBLFrDLFZZDrL
lVgjLLLMgFMDCwCFqCRbngsvnGSvnSGndbsfgf
WZJcTWcNTmJZphmTJJNQHcdvfdbvnRRGbGthdrbttfSv
ZPQTJTpTNPJNQTmJRBZJNBHjwMVwPCMwVlVzjwwzqqjVjL
hznNhNQNQFDWVFmDQm
SMqZBMMbBvDbHPzzdVPH
zzzTBTMLNTgpnTTh
NLCdmsdCVLGHCHdQzzmznnFwRjFMDMwpTBjDRpnpTBMJ
PrcfcrglcfWbSqgrlqvShrwpJpDBFJHpBWjTDTRTRTTB
crSgSHtPttfdLGmtzzZNNV
BTlTVqCBqtTcBqVhWlsJjDvsnLsvlvpJPj
gMgggGZbSMzNRRRLmZZnQZQPPDvnsnDvJwwQ
dMRRmMgbNfRgmfSdGFgNgTBtrhrhqfWtLCCWLTWWHc
zcfVrPwnwrPmrvnjdFdBbHFFdd
CCqpSSQQpQZLDCSHPpBFvFBjTHRvRR
DMLGthLZMLtQGhGNMPqGSDflzfwcVmzJzsfgNVrswcrr
hSgvMTQvChSqPvhTrRLlVHJgfgRJlHHHJH
jmzsZzZzwmmLGGtwtVJWNNDRDtVcfVRl
GnBBLbzzzFszBFpzvSdrQQCTCQbhMvSQ
VHpTMrZMMbDbbpTZmQmTnmzhTqjqlWWQ
GGvgNsvNCNvvGvlqqdzWZmlsmZqZ
wNNNgccNGJSNBSRNBNvNcvJHLDDZMFRMppMLrfHDLbrrHF
spssbPMLpPllspGNsNWMrnwddnfcqrnwwwwMwM
VmQBFCjzzjmfnwbrngcVrd
FQbSFjBvvzsWvWGlvWNl
JLFSwfwRLLfGhnQJBQshvn
pZgNcpCWpWtcvhjGGjtVvszD
CccMcPcgTTCWmcZcWMcmTNZPmHdrqSHFRRrqwrSrRqwrHmsH
BPMhflJRhqnPNGjNRNRjgSRm
VdVsDswTVZbCwCZBrcDCczTwtjtNNjmjmgpmjpQggpGVSgQm
sTbWrsTBbrTPPnqlJnPPhW
nvrgjMWBvQWPvQnsZfGcZcRFdGFtdtZB
bHVDwmqNNDhHNzqpphLNHVLpSJcdZtfffRZdDgRFGSddcRZt
HNLNqNqLNbhqVVbClngjnQWPTWgsCgvT
tfstpcScscBTFTpFnsWSmgdzJlgmgBmPPzJmvdPm
jnrqrLHRwGrwhdPvvPvhjJmP
qqCLRCGrZZqCHRVtVWQptFWppnbcWb
wCDJZJgDwHpdqHhdGHBhhH
WSPmJMlmbSmztQlQsvPhnhGGdBddBqdGddTbVB
WzWQftWMSWtmvmmSWtMQPgggpZwLwZjggJFgrpFCfj
MvQBJMBQhjQFNFnjnj
dtlZmRtLmjSTSLLtTtNVwWzDRzDVwwWFwnNn
dmmLCqTdcLqtLGqjBhpfHqBGpv
PBPRhjTPPlLRBvlvfwffqJGfpG
rHtMtrszFtSgbFrrggrFgMnwWGzmQqWvGWzGQpJGfNqqNz
FggcbSMntVgMdRCwZcjChLCT
lCqqBlCwlnDqPZTZZBLNdjJLwttNWjjdzJzc
fVfMbvbvmbVsmSsmMVWNtzzcjgLWgjztMMtg
VVmFhFRSfbQsvVQmvSfhSsmzHlCZqrrBrDBrHZPRTZnnzB
CRrDWmzRRQMmDqrrBgBQmtHljhHwtwlwplcBjHGwwB
PWfPSWnvsNZSZdfjHjZtGHjchllltl
WVsnbSPTbNdbmqTQmmrmLzTq
cGtMBGSJDgtgMBsBMgMvWWSHWjpjzHTWTPpqWzqW
mNVQNsdVsdhLmCpTWWjmCjTT
NQQwrfbQrNQNbrrdLwfQsZdgFbBBFBgggRGRDMRFFMRDgM
lFnqgqWQvHWqgvlVglvqjPjcLdfLfBPLnrbLNLcN
hmTmthppsRtpTRRTZMpSbLdNjNcJLcrcBNbJBZZc
smmpRsTtpSSsRGhppmmhdCMGWwqFQgWGWWDgWwVFHQqHgg
mWFjmcdcFWcSSQjzrpvrwRGvTwQGGG
HRJfgMZVhtRlHJHBVJTGvGppbpbvvGTvTtrv
glsgVMVqffdnPRDcqLnL
MtvLJdmLLTvSSCtSzLSTcDhRjRftQjjssshfQNjPtf
nlggrFWzRsfFjVQN
WgwwBgbgZBHGBnccTzMCLTZJmLLL
sRtHTBBHZtDTtZhdPzWdGcdVFdJmGcnm
wpwMLWCgvfNvwvwbbCrwgfzPncrJPSFVGPnrcJSVznmV
bLpvwQwMwpjWMgfvgZTsDsBttqHRjTqHlH
mpmGpCpmlpmwfmCQVppCVfQSSjvSqgWvvvDgNwWDgnnDnW
RBLsHRJBRrHJWFDWSNqFWj
zZBLdsdcZrsBjGfpGVpTTPGlVc
NBbTzgwSNmrFWpVrzrFM
LnZQtQlZVnMrFBBG
CCdtddBtPdNqcvHSCCcg
ZFbZPHbZPTQVVlsGNF
qtvDWvgRftqGNccCNVThDs
fRwGBBjBppdMdBMZ
GffflsZsPZVfjsssNfZsJNNZVcMDSqMWFcwFMMpcTMTTFSTS
LhrCmvzcRbbhtmRdTCMDwWMpDWqqqMpW
dvRQmBBvLzBRRvRhhcdbhdRgjHQNllJsfsNlZZljZGGNQN
wjbMPsbfLzVCTMVbjLplmpshhSpHShhJhtsm
ZrcqZTDTGDqFdJtGmdGSpl
QNNrWvQRqRNWnTQRvqjPbjfWbCBCMbMLBwMV
wRPRsppFfWJRlPRPFlpJfwSMzzZTBwBtZTTCMCMtdz
vGLGrjcfrLVGjfnGTMCMtNNnCTnMtCBd
VrjqhjhLVcrGVRqJmqQspmfFWm
LRfdnmwMwdSBmfvJNrrgLhCNgqqJWs
llctPPVTcPStgJgshCsrCs
DpTlFpFVRFZRFFSv
sPgRgsmdcqmgSvvFRRRRdqdFfTWZhhdZrZbbWfTpwDfbWTbw
jLCCHtLljJzjlplfZSlwTfprZZ
tBHVjQHzHQJBtSVmvRsvvFRqnGgv
spppVDbVcbgVSFgFZZbGZgbJMRBTvHTvJJHGtHRwtMGvHT
LldflzQLLQmQWQQfnwMWwHJtTtwRBcBt
CPjfhCmNmNfFVchpchFVhp
bZQJgQmQmTgnLBRtNPNnml
ccszcqldGzhszrVsqdlHVNwLpppwHPHRtBBppDNRLt
VSzVhVdcfrrhcqGrVhrssQQlMbJvFjMgbFSQggCvCv
hHWVWhhlZDZVWNTgczWLjbtcTFFj
JJnPnCdBCBnnRCjSsjStBgsbFttb
MRpgCpGqdPRppJwpnRqRfZZhmvhHDrhllDHhhZGZ
SPcgLDcLLnWFWCNVCRPT
fhZQtsbtmbmfZTVTVRWfNvTCTT
jhbbmzRsQzpLDcgLHLjg
GSFRHrCCGRJDJtrgWdrL
stcVQshQZBsBmjMsZhmMQQWDDvNWdncNWvzLgdDnzdDN
sVwMBQBhVVjtQZVPlSfPCfwRpSCpRl
bBHHJMJvBvWMJWqqccNNPhMCrclChQCC
RPppPgfpwgmcQgrhmm
tfwTwpFPGGwZSRtpVjJHbHLvSvLSqVLL
jlJfZGjljJPBqJGnfGVMqGfrFWWddvDmFRDcmdFDdDvbDM
hTCTsgsgwhTbvRdcFmsddpFd
wbQNHTQLgCwSThhCgwnZnJfqnqJBlNlBnnVl
CLlfbjjbLlbbDGbLzfCGhdtdWBthdBWsHvWHBnntWs
rmJRJFqrDwVFTwFmSJvtvMtdJMMHBdBBndWt
ZVrVVZpgTpZFSqmZqRNlNNfQQbpGjDQbbpPl
mVCrhGHGmZhrNlDwbWnLWWvGLWWwnd
PNsqgzspsgNFJNFfzqpWSWdwSvSPnvdWbSbvjd
NzgJzqMcgscQqJcpJRzBmlrBRBDDlHZBBBHtHZ
NJmNJDwcMmJNMbJJDNDqcGcsWRWHQzRPQjZLRGZWLQsjZQ
dgSnTBgdpddtgShSTZjLRhRLHqWPPhPRPQ
VgdTpBntlvBVrlfcbqJcMrfmcqmb
wvqwvPwNJgFmLdvDJFDmDLvJlQZpMzSpBVflpdSSMlQnfldS
WjCcRZCWRjjRtsZhRRhpSVBVnzplBfWnfBfSQz
CbRbcsjHZrhbTRtsGbCrgNgDDPFFqvvJvJFDFw
GlsCrbCChShqgqlbSCcVbqgVhBwjBDFBhBhdDWvwBFFvWvDv
THmHMmtMnLfHRnzRZnfLBDWWsWzWFNsvWjjvjvFF
mpHRtmZffHTTMpmLMLLnJtJCgScScsPlblcpCrPbblCPlq
vscDLrcvrsLNStdTfBCvgJTqGBdd
bwLbzRhbbdTfbgCB
pplQzLwmPZVMStcDjFtQrS
RMjCrhFJhRVRVCCFFsvmnvqrmbvqmqSmbrvm
tzfpBgTHzttGzZpBfHGDBZHbccnGqbmvdNlGnSnlcvSwbn
pDWTHDTzgTfWZpVVsWSPjRFSMsFs
fmrfmrwVfjmrzjqCsqqvjsvvpG
hFDVtFStVtJnPPtJNHbtQWGbQsCvCsQgpWGggdQC
NBSDSNHStHNHnhStHNNrcflrmTzBlwmzrlMVVw
SjtZZSdNcDldPQqndl
BbgzgWgTmTBfwrbnDjQDwVPwDlnsVq
zBBrCTTMBWLMWmfMfbbmrMtjNZLFJRRZSSvFFtStvGGJ
CTCGLGCFRRSMGnZnLCTfdffhpbNbDfpdZBvhdv
rJlqclVPHJWVrgPPQqjqgJlhBhDBBQdvbhwvNfhswfNpvb
tltrcrHjlVWVCDzSGCCzLCGt
sbHHsbCCHbLSVfJbbfSLNJBzvzMMPrhPPNztZlZNZhdt
GTWjplTgDnGmQGpQnQhZrvvBMPztPzvrzvjZ
mQgGWllcFcTFmgwcDppDQGTCqfsSLqsfSbqJqLSSFsbRfF
jslsFjLLLLvFwWtQFTFDJQWp
dGzdrNmRWqVBGcTbwpRDRnbJDRhT
qzqzrrPNNrmfLPsjglHjgW
QjCHcPfcgQSgPPcffQSmmmLmrJJpNpBMrJMtFrBBBMFrrpNS
VGVZfDbbVVZWGvDbFrlBZNJBNlNMwwtM
sbvfhqTGTRnhTVGvzgHmgQLQmPqzmPLm
sLwnMHnbnLMjGpZsjGGtpc
ggvJrNNTQgQrNvgqBqZCCjClWjGtWjCpGJFW
TVdrqvVrTNTzBqQQzTRMfHbMwMbZMdMbHwRD
bcfJQQJHsQPCpdpWdPbb
RHjHDwZtrZmRDDtwtjRBVFdWVrrrBClldVphCF
zDgwgNzjmDnMnzMMHncG
vMHRvMhvHWRBRDHhRBwWvRBqLqbGwqnqnnNTbNqdNbbVVr
pslgcZszJltrsZcZgNnnqbSSTSSndbNbzS
cZcgsZgZZgPgmcpfJtfttWBQvmFWjDQDhBmFjDHvFr
bVbBvdTTVLbCgCznLJsJcwHPczfz
NFcDphSDrFjGtZNZjplZGZFnzPHPrzHHzJMnnwfPsPsRJs
cGtGljFmWdvqmVCV
qSNbTvcvTGTvGcgtBNvcbdrdjrnjRnjRVHdDqHrRHj
ZZZZPLWPzPDCCsCRnRdwVFnjdwPVFP
ChlCLLZftfcBvfDv
cRtfctVgmRclmBFGbbMBDDFPtD
svQZhHSHssjTvjpQjSSBBMJMJGDBpPbMzzpGzP
ZsvsCTWhCHhSwwjrwbndldlRnfRNmb
PQdTgdGpRcTccCfj
hHFLHlHBhBlmlDFzHrhhfZNZbfNZcVWNVVZRDjCC
LFLLMHJHSBhBFGGnMMvsGtGGtj
fwmVnVCDVqpNQqqb
ddBcZZWdvGWzBzsWvLvddlNHcHQPbQqqJQNNQHPHQT
WgGvsMMzvgbntDhCmt
JjwhFMmwjJwmCgTgSCSFlPLg
WWbsbVtftBZWtnWtncbQvctTGLpLgCpzPPPlllpzlgPPTQ
TBvnfBffWsfVtTvbZBTNjwjqddhMNqwRMMhdRMrq
SllrbtTSQrSQrbrvvMvzFDsBsssWpWdWbGpGBWNWNW
hhCfmmmjmPLCfmnPLfqPgqqNNBpjZBZQDNQdpWNpdBBsBp
RhLfPhQLQfCRnHfqTHHrFJMrttTwTtzt
BFrFBJMMJnnsNJBFCdLCnmvzbPdCmPnc
LDLVHQRfDvdHdcCmcv
llQDwqSVLwZLZSgsGZMNMgTjTMTr
mrwdbqRhdCNGgZBHbH
jVTPMjvjpvMfTfQfPlpHHZNnNBHgZDGsGMnCsZ
TLlfQpffQvvzhtNqztRFtzcm
DDfvJZZPDHVPSPcSvcgcWCsWQcTTdhQTTh
dMwpbdjRtrFhhTsTFQWqhC
bGRdNpbzlvLfDfZlLZ
bdPQdcpdbpjFqpQcQwqqhhNRhJvWRfrrWBsJrfwN
mMtlZfmtnLZtSnGDlmGWRRhrWLhJsBRvgRWghh
DnMGCtmCzfGMbjdQbVzpqcFH
jwnGggRBvvpBZCljCsCWrhhrsh
FVMcFLqLMqcJfVtDqMJcHMHWCSblzzrWsdhSLlSzbrGCLz
HQVFPDtDQDFFNTZpPgNnGgNn
HNBHNqlqHJQBRNvdmZvmPdZZlpnT
bDbbhDgSfzVVfnvPmfHmTZZd
jgzbwrhVsDgsDWLwJqqBMqcqHL
tzNtJzsJVBHzbjbglCHc
nfmnGnmPhntCgHvtvmCj
MStTwrMTWrTdBZSNLZJNVQ
NVjmwmVGGwGFHstwFHMhTh
psRSzzscZscZpgQQzqQtBBHTTlThHHtTTh
rCprbpZccggcrRzbbRRbscvVVWWvNfvVWnGDCWVNddmd
rphfGDgtPtllrPlFlGrhGjnmnTnjcBsncBBVpTTBmc
SqqZMJCLwgCwJgQRqqgZQNwdBBsBBHVBdTHNsnVNBTccnc
MJqZZMbqgzRCSJZwPtFfGzWhrrfGttWl
cSZqqcwbqVzqCbqVqVZPsvvDCDrffngvphggndhdGh
tTNTMWJNQJHMNGSSprfdGnfdth
WNRHWWMJSRWzswbczsVPRs
HCgcSMhSMBGMdvGf
RNQqbDQqFdRFdmTZfGtPZvtGlQffll
mNpdNrRDbTNrmbpzmpWmbpWcswhcHcjhscSHjSgVHwHn
MwgcFgwMMcscCbMFsMFCgMgPPLWPvptvBvPvtvvWmBBzwG
nhQQjTJRVDdQJrPpmnGGBmvtGvLz
HdJQdJHjrJQDBQjhQVQJhdJcqlFHcSqsNbCbCqCHFqCFgC
JvTnvWtdJLbhJHbMwwHjcGHCwHwQGQ
mqtmsllmfqVFwMwMrrPjmQrC
lfztRZSlRDRVzfdpWnSvWhNdbnpp
rSvrgggzHTNzrHtnptpmlDngZjWj
MdMhqMhsfMSRcGqRsQQRctjjdDnjtjClCjjpZnDlnt
BBMRsQRfRcscGqBfRRsBssPBLLzNLFPwvVFFPTLbbLwHHTvS
pCmCfdPFzmsFsDhFFDsttptpRtJjLnlJRtttHt
ZQwgWZgqJhTTRtgV
GNqWNvcqqQQrMMWcQzDDsSzBDBSssSmhhr
"""
}
