-- Задача №12
-- Определите функцию, разбивающую список (a, b, c, d, ...) на пары ((a, b), (c, d), ...).

couples :: [Float] -> [[Float]]
couples [] = []
couples (a:b:tail) = [a, b]:(couples tail)

-- Задача №14
-- Определите функцию, вычисляющую глубину списка (самой глубокой ветви).

listDepth :: [[Float]] -> [Float]
listDepth [] = []
listDepth ([x]) = x
listDepth (x:xs) = listDepth xs

-- Задача №17
-- Определите функцию МНОЖЕСТВО, преобразующую список в множество.

array = foldl (\y x -> if x `elem` y then y else y ++ [x]) []
main = do
  putStrLn "================================================================"
  putStrLn "========================== Task №12 ============================"
  putStrLn "================================================================"
  putStrLn "================================================================"
  putStrLn "=========================== Tests: ============================="
  putStrLn "================================================================"
  print $ (couples [0.1, 1.1, 2.1, 3.1, 4.1, 5.1, 6.1, 7.1, 8.1, 9.1])
  print $ (couples [0.2, 1.2, 2.2, 3.2, 4.2, 5.2])
  print $ (couples [0.3, 1.3])
  putStrLn "================================================================"
  putStrLn "========================== Task №14 ============================"
  putStrLn "================================================================"
  putStrLn "================================================================"
  putStrLn "=========================== Tests: ============================="
  putStrLn "================================================================"
  print $ (listDepth [[1.1, 2.1, 3.1], [4.1, 3.1, 2.1], [9.1, 1.1, 2.1, 3.1]])
  print $ (listDepth [])
  print $ (listDepth [[1.3]])
  putStrLn "================================================================"
  putStrLn "========================== Task №17 ============================"
  putStrLn "================================================================"
  putStrLn "================================================================"
  putStrLn "=========================== Tests: ============================="
  putStrLn "================================================================"
  print $ (array [0.1, 1.1, 1.1, 2.1, 2.1, 3.1, 3.1, 3.1, 4.1, 5.1])
  print $ (array [0.2, 1.2, 1.2, 2.2, 3.2, 4.2])
  print $ (array [0.3, 0.3])
