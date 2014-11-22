{-# LANGUAGE OverloadedStrings #-}

module Tweeter.Settings
  ( Settings(..)
  , loadSettings
  ) where

import qualified Data.ByteString as BS
import Control.Applicative ((<$>), (<*>))
import Control.Monad

import Data.Yaml

data Settings =
  Settings
  { consumerKey :: String
  , consumerSecret :: String
  , accessKey :: String
  , accessToken :: String
  } deriving Show

instance FromJSON Settings where
  parseJSON (Object o) =
    Settings <$> o .: "consumerKey"
             <*> o .: "consumerSecret"
             <*> o .: "accessKey" .!= ""
             <*> o .: "accessToken" .!= ""
  parseJSON _ = mzero

loadSettings :: FilePath -> IO (Either String Settings)
loadSettings fp = decodeEither <$> BS.readFile fp
