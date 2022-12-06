//
//  Puzzle_2022_06.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/22.
//  Copyright © 2022 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2022_06: PuzzleBaseClass {
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

    private func solve(str: String, uniqueCount: Int) -> Int {
        var charArray: [Character] = []
        var idx = 0
        for char in str {
            idx += 1
            if charArray.count == uniqueCount {
                charArray.removeFirst()
            }

            charArray.append(char)
            let charSet = Set(charArray)
            if charSet.count == uniqueCount {
                return idx
            }
        }

        return -1
    }

    private func solvePart1(str: String) -> Int {
        solve(str: str, uniqueCount: 4)
    }

    private func solvePart2(str: String) -> Int {
        solve(str: str, uniqueCount: 14)
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
mjqjpqmgbljsphdztnvjfqwrcgsmlb
"""

    static let final = """
gzbzwzjwwrfftfrrbvvcbcvcffpssvhhzfzbfzzrbrtrcttnthnhsnhsnnclcpctpprwwgppppchhvvctvtsvswwcdcrrdzdhzdzvddvfvfjjlldvvfllfhlfhlhghnhghrgrsggvbbhdhffzggmttjqtjjgljjwtjwjggldlzzrfrpppjsjggqrrdbbgwgtwwwtqwtqqvccjnnhrhqqsnssjbssmjjbzjjqnqnlnjncjjzzqddfqqqnqvnqncqqmsshqqccssvpvllbbfvfmmmgzgdggtjgjtjbttngtnnhhfrfddmtmtftcftthvttwzwrzrbrgrbrqbqccmmtvtqvtqqzmzwmzzzsvzvhhhqlhqlqplpggvmvwmmshhnshsjszzljlnlrnllgddqllpmllsgswwqnqlnlqqlmqqvrqvrqrppvrrqwqhqllgjgcggsllqgllghlghhbvhhcvvbddvcvwwwzdzzfjjvcczbbwccjvccmvmfvfgfmfttwrttpmtmsszccjggcssmqsmsgszzfpphghvgvvcddtltwlwnnrbbfdbbtssrvvmwwjfflmlblwlrlmlwwhrhnhqnnvdvllzblzzndzdlzzhpprbrprnrzrjjlnlnrrjddgrrwrttcstsgshszzvgvfvpfpqfpfbpbfbwbmmzvvnnqvvqppzspzpzplldqlqsqlldmlmgmcmwmsmfsfzfdzzbpzzbbcwbbtppphlhshchjjszztctpprqppszzchcqczczddscsrstsntstjsjqjjfggvccgbggqhghrhppdldnlndnpddllgplgppnlpnnmwwglghhftfrtrqtqsszrssfjjzhzfhfssflfslsmmgrrcdrdnrdnnqznndrrbtrrmhrhbhsbsgsnslsqlqnncpccplpldpldppshsdssqdsqdsqdsdsdfsddchczhczcszcscffzhfzffpbbgttdhthnhnjnwnnwrrmwmlljzlzlzdzrrcvcbbsfstfsfnfqftqffgjfjzfjfsjswswccsvcvlccshhjpjcccnfnqqmsqmmrwmwjwswgsgjsjttmjmjttpqtqwttgmgfmmnbnrnpnwppgspggwnwqnqpqmmbmmnwnllbwwdqqzsqqtgttnrtrllcwcchpchcbhbpbnpbpsptpvtvzvrzzslljddjzjjmqmmdpmddcdzzrdrqddtctppwzzwrzrvzrvrzzjtztqqsmmcncllhmlmpmhgsrtrzjhjbtfvhmzpssfbjwcdshthnmmqmfhlhwcbbllwzbwfgfvzjcqblchzqqqgcgmpnbnnblhbcpgmvsbvtcmhsghldlhqlghgtpdvjflmjsmppdsvrjlwvhmwsmfvvdnzpmtfqjqpjdctnnrlfjfvdtmvdmhsczlfsqwfrqtlqwnzdzrcdzmhvrgwnjjtqjrqljhgcffglvhnsdssqdpfrfhtjwlqzvfjmpjnqhsjvndtstqjsqgcmgqdjvfqnlmtjlvcblndprmffrgqdnnncnlfflclgqbjbmsdqsjrmzpwtbqqqqsqmgthhjfqwzvcbqwlvdbffhcvncpldmchnptbnlbhmzrrjhzvzdrvtlhsnfnfdnvhlrlrmdcpnmvdwswctcqldszlvftqtwldrhmfjmfvcgjcdjsbjqjwdtslblwhqfvgrfcpnhszqqsfwbwcmvfvccvztdmcjqfjvdvmbdtcjvtwqpwsqjtdvpvvvsdrrvngmjztgjtnpdbmtlrbrjlwsdnthgzgpssgbzzrqvgblqhrtfbflnphvhpzmdfrwqvjjvcpsmdrqwdbzlpnqpmglgqzfhctrzdpzdthqgjtvpwcrlsmqnjwgzlnqbthvfswhjtrrsrswhbmnddgzmznvppbnmtjpzpdpmpzpmsgfstzldgmrtgplwwsbztphtcvdfgsqzqwrmlqpnhvpcqpfjpbrthrtwgqlfnrqcrpvhssjmhfgpnzzvlrlcbnpmddhtdvvfrrvprqrwbhfgvvltgrhrpwsdgvrlgthbztcgcfggtcfzqtlcdhpmcvpgcszslhpfrttnrdrqpqlgdfwtccmbhfrnlbhhmrtrjmzstbqhmtphzcpcllzsnghfvlwvzzvlqrjmfsvhrnjnvldgnbqvpjsmmphhrmhqrtcncmjwbdlqtrvmhgjrjsrddcpqnjhfmczfgwzspnrjfwvfdpdlcfpvctfrlspdwwlnpbvbglzsmgfsmrshsqgcvlfrvjssrglbwvvvgpvtqshbtqmzbnglflhhldtfzqssptrbnnzdqwqtstpftdqgmmhfjdlfwtmcmtmcgcvtfhzvsbllgbchvlhrgnvvbsnrwqrlvdqlcwwlgbjrvrzgcvljqzvdngtbhpnppjrzpmbwztzvnvrbfccfgvnqvrcmpdblngcvlwjwzpbbwmnslsdjmbrwbvnjsgcmsfvzvnwbzrrlzvgdnzcqqgggvmcwczjqnrddnzhlndgzjbvtbtjqdnlvlflqnfvjdmfstpdfqsgjdslgtpgdnvvpmfwvlqbmbgdrqjhdfhlmsdtfwpscsvdzmswszjfwqtsjqpfnjjlnsspvlgzwwtvwgdzfjjljfwbvfbvpglcqcdbdpshwcqzswbwhftbfqblzpqfmqpvzdjsrcqtvjntnhmlhmzllffcjsdnwpfzdglvlrhrljbrhjhgdnfcqcrccwrbbhrvqwrzlwjrrwzsfcwsvbqsjgtgpzqwlczljrtdhtzcgsfgqssdbjjmttdtzhrqtbqjtqfwmcpdftrfjmznpscsqmtfcdpcdjwcqjvmhngcqnmtmwfttcvpwgcnhhgnnbgjdvztzhczvqljjqwcmwcbvmqqjsfnmhtbtsvsnsfwfzgdvlctrgdvbjqpgfrrlsnppmvhfbbclprlvcssnvtsgftmlpqrpjzrrphrzltbtgfwjqqvbgqjdpdgqvzppfzcbhdbbjttcdzclsphtlzfvnfqgpmqvpzrqgpdnbmsrqgsnfdwpvndzmsllgmnrlhnnzldwshtrrsrsmdncwrcjnmcjlwbbfpzcwzvldtgvbcvhnbhgjgwjcvslrfcwbqlrqldvpcgnbwbzzncncftrgbrwchfrrtnpqsjbcpzvplnbqdgtvnnrcwwfvbdzdrsfspvtbhflhsbqmlsjvfmpvjbfvcrdmgrfqsmqgfrntfqnlqbvmsqtpncjrstspbqvfmddmhwsssdcddshmwdlscttmdzljtpwhzhzhwsdnmgjstfmlnqqvzzdqpqsjdsllswmqcjtnthwqnhbscrjdstljqgncjvjvlpfrtscrzrqghrdvdnbtnpshpldcchljzrzqjlwwscnphvrwlvzttcdjdrddgmvqpvdmttdqhwpfmslzvnrwlrrdttbhctgpgzjrmdwjbcmsprwggvmdmmltldgpbfnppnrpwcnpgtblccdvbsnfvgzmjppftvndmdslfshjvndfvvzjjlzhgfmhcggttrcrbrlwrqgjpchvhnjwqnbsnmftwszhzftglrfdvvnbcbzsslgmdchtrrrqqzhllrfhwfwbbdgfpdfwssmzcfcnzmrhfdddtdhfqmctsglqbwhwpnbdzbsfbbvvthrrgjvztjjwgjcgjntrddmmdldtmvjnwjbcqwfwvfhsrpchznhlqpcttqjffbrpbftftdjzlrqchmzrfgjrqlndfwfrghtsfsblcvtjmjrbfrwdgsgzmmjpdlbwzfscfsfcdqwdwnjwjbvvbptmfrqltmnlpbtrqspwdfmhnncqgtrtmbzhfmwrbcqhmmpmvprvwrjplspcmmspldmbgpbtmqjtrfcpfhcnpjbnlhjpzflstjqfqvzcnfgvrmtplndchffzrtfrqdpdnzrspddwmpzlfchrzzfcfvmbvfnlfwtfbvnffdqhljbvwwdtmszgrjtzwqdbgvvfphcnsdgvlmslqngfmsbrztrnpjprghmjffscbnfqwrvjjjtfzrmjtzbwdsmzgmbtjzvddhngmzvflwftblbzfd
"""
}
