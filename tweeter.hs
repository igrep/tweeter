{-# LANGUAGE OverloadedStrings #-}

import Tweeter.Authentication
import Tweeter.Post
import Tweeter.Settings

import Data.Aeson (eitherDecode, FromJSON)
import qualified Web.Authenticate.OAuth as OA

import qualified Data.ByteString.Lazy as BSL
import System.Environment (getArgs)
import Control.Applicative ((<$>))
import qualified Data.Text.IO as TIO
import Data.Text (Text)
import Data.Monoid

main :: IO ()
main = do
  (cmd:args) <- getArgs
  exec cmd args
  where
    exec "tw" = tryTweet
    exec "tw-akey" = tryGetTwitterAccessKey
    exec other = error $ "Undefined command: " ++ other

tryTweet :: [String] -> IO ()
tryTweet args = do
  undefined

tryGetTwitterAccessKey :: [String] -> IO ()
tryGetTwitterAccessKey args = do
  (Settings cKey cSecret _ _) <- leftError <$> loadSettings $ head args
  OA.Credential cred <- getCredential cKey cSecret
  print cred

leftError :: Either String a -> a
leftError = either error id

formatEither :: Either Text Text -> Text
formatEither (Left  t) = "Left: "  <> t
formatEither (Right t) = "Right: " <> t
