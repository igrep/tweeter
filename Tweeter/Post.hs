{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FlexibleContexts #-}

{-
Most code of this file is copied from one of the samples of Takahiro Himura's twitter-conduit.
  https://github.com/himura/twitter-conduit/blob/46b8f37e55f10eed3c71e4245ea94c5e17cfca87/sample/Common.hs
  https://github.com/himura/twitter-conduit/blob/46b8f37e55f10eed3c71e4245ea94c5e17cfca87/sample/post.hs

Copyright (c)2011-2014, Takahiro Himura

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.

    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-}

module Tweeter.Post (post) where

import Web.Twitter.Conduit

import Web.Authenticate.OAuth as OA
import qualified Network.URI as URI
import Network.HTTP.Conduit
import qualified Data.Map as M
import qualified Data.ByteString.Char8 as BSC8
import qualified Data.CaseInsensitive as CI
import Control.Applicative
import Control.Monad.IO.Class
import Control.Monad.Base
import Control.Monad.Trans.Resource
import System.Environment
import Control.Monad.Logger
import Control.Lens

post :: String -> TWInfo -> IO ()
post status TWInfo = do
  res <- withManager $ \mgr -> do
    call twInfo mgr $ update status
  print res
