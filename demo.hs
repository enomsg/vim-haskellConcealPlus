{-# LANGUAGE ExistentialQuantification, RankNTypes #-}
import Control.Applicative
import Data.Monoid
import Control.Monad.ST.Lazy
import Control.Monad
import Numeric
import Data.Complex
import Data.List

factorial :: Integer -> Integer
factorial n = product as
  where as = [n, n-1..1]

integral :: (Num a, Enum a) => (a -> a) -> a -> (a,a) -> a
integral f dx (a,b) = sum  ((\x -> f(x)*dx) <$> ab)
  where ab = [a,a+dx..b-dx]

isValid :: Integer -> Bool -> Bool -> Bool
isValid a b c = (a >= 0 && a <= 10) || (b && not c)

rs :: forall a. (forall s. ST s a) -> a
rs = runST

main :: IO ()
main = do
    let tau = 2*pi
    putSL $ showF 2 $ integral sin 0.001 (pi,tau)
    print $ unsafe [pi,tau]
    print $ factorial <$> [1..13`div`2]
    print $ texNum . showF 2 <$> (mag <$> [1,2] <*> [3,4])
    print $ Just True >>= (\x -> return $ x `elem` [True, False, False])
                   >>= (\x -> if x /= True
                            then Nothing
                            else return True)
                   >>= (\x -> return $ isValid 1 True x)
    print $ [1,2] `union` [3,4] == [-9,-8..4] `intersect` [1,2..9]
    print $ (++"il") <$> (Just "fa" >> guard False >> return undefined)
    print $ realPart(4:+2) == imagPart(2:+4)
    print $ liftM3 (\x y z -> x+y+z) [1] [2] [39]
    putSL $ "Hask" <> "ell"
  where
    mag a b = sqrt(a^2 + b^2)
    showF n f = showFFloat (Just n) f empty
    unsafe xs = (xs!!0,xs!!1)
    texNum num = "$\\num{" ++ num ++ "}$"
    putSL = putStrLn
