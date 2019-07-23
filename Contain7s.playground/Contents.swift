import UIKit
import Foundation

/*
*#1 Numbers containing 7s in given range*
Let g(N) be the count of numbers that contain a 7 when you write out all the numbers from 1 to N.

Example
* g(7) = 1
* g(20) = 2
* g(70) = 8
* g(100) = 19

Goals
* What is g(1000)?
* Write a computer program to compute g(N)
* Provide useful and meaningful test cases for the function
 */

// Time complexity: O(N*digits)
// Space complexity: O(1)
extension Int {
    func has7() -> Bool{
        var num = self
        while num != 0 {
            if num % 10 == 7 {
                return true
            }
            num = num / 10
        }
        return false
    }
}
func contain7sWithoutString (_ N: Int) -> Int {
    var numsOf7 = 0
    for i in 1...N {
        if i.has7() {
            numsOf7 += 1
        }
    }
    return numsOf7
}

// Time complexity: O(N*digits)
// Space complexity: O(1)
func contain7sByString (_ N: Int) -> Int {
    var numsOf7 = 0
    for i in 1...N {
        if String(i).contains("7") {
            numsOf7 += 1
        }
    }
    return numsOf7
}

// Time complexity: O(digits*digits)
// Space complexity: O(digits*digits)
func contain7sByHeuristic (_ N: Int) -> Int {
    guard N >= 7 else {
        return 0
    }
    var numsOf7 = 0
    let digits = String(N).count
    var magicNumbers = [0]
    var i = 0
    while i < digits-1 {
        magicNumbers.append((magicNumbers[i] * 9) + Int(pow(Double(10), Double(i))))
        i+=1
    }
    
    let MSD = N / Int(pow(Double(10), Double(digits-1)))
    let remainder = N % Int(pow(Double(10), Double(digits-1)))
    if MSD == 7 {
        numsOf7 = MSD * magicNumbers[digits-1] + remainder + 1
    } else if MSD > 7 {
        numsOf7 = (MSD - 1) * magicNumbers[digits-1] + Int(pow(Double(10), Double(digits-1))) + contain7sByHeuristic(remainder)
    } else {
        numsOf7 = MSD * magicNumbers[digits-1] + contain7sByHeuristic(remainder)
    }
    return numsOf7
}

contain7sWithoutString(9725)
contain7sByString(9725)
contain7sByHeuristic(9725)

/*
 Test case:
 1.  7           Ans: 1
 2.  20          Ans: (1 * 2)
 3.  70          Ans: (1 * 7) + 1
 4.  80          Ans: (1 * 7) + 10
 5.  100         Ans: (1 * 9) + 10 = 19
 6.  200         Ans: (19 * 2)
 7.  700         Ans: (19 * 7) + 1
 8.  800         Ans: (19 * 7) + 100
 9.  1000        Ans: 19 * 9 + 100 = 271
 10. 2000        Ans: 271 * 2
 11. 5789        Ans: (271 * 5) + (19 * 7) + (89 + 1) = 1578
 12. 7268        Ans: (271 * 7) + 268 + 1 = 2166
 13. 9725        Ans: (271 * 8) + 1000 + (19 * 7) + (25 + 1) = 3327
*/
