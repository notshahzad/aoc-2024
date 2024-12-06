import Control.Exception (assert)
import GHC.Utils.Misc

main :: IO ()
inputToParsedList :: String -> [[Int]]
inputToParsedList input = map (map (read :: String -> Int) . split ' ') (lines input)

removeElements :: [a] -> [[a]]
removeElements [] = []
removeElements xs = [take i xs ++ drop (i + 1) xs | i <- [0 .. length xs - 1]]

checkListDecreasing :: [Int] -> Bool
checkListDecreasing [] = True
checkListDecreasing [x] = True
checkListDecreasing [x, x1] = x - x1 > 0 && x - x1 <= 3
checkListDecreasing (x : x1 : xs) = checkListDecreasing [x, x1] && checkListDecreasing (x1 : xs)

checkListIncreasing :: [Int] -> Bool
checkListIncreasing [] = True
checkListIncreasing [x] = True
checkListIncreasing [x, x1] = x1 - x > 0 && x1 - x <= 3
checkListIncreasing (x : x1 : xs) = checkListIncreasing [x, x1] && checkListIncreasing (x1 : xs)

checkListsIncreasing :: [[Int]] -> Bool
checkListsIncreasing [] = False
checkListsIncreasing [x] = checkListIncreasing x
checkListsIncreasing (x : xs) = checkListIncreasing x || checkListsIncreasing xs

checkListsDecreasing :: [[Int]] -> Bool
checkListsDecreasing [] = False
checkListsDecreasing [x] = checkListDecreasing x
checkListsDecreasing (x : xs) = checkListDecreasing x || checkListsDecreasing xs

part1 :: [[Int]] -> String
part1 parsed_input = show $ length $ filter id (map (\x -> checkListIncreasing x || checkListDecreasing x) parsed_input)

part2 :: [[Int]] -> String
part2 parsed_input = show $ length $ filter id $ map (\x -> checkListsIncreasing (x : removeElements x) || checkListsDecreasing (x : removeElements x)) parsed_input

main = interact $ part2 . inputToParsedList
