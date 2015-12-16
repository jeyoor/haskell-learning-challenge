module Paths_starting_out (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\development\\learning\\haskell\\for_great\\starting-out\\.stack-work\\install\\9827668f\\bin"
libdir     = "C:\\development\\learning\\haskell\\for_great\\starting-out\\.stack-work\\install\\9827668f\\lib\\x86_64-windows-ghc-7.10.2\\starting-out-0.1.0.0-FVG2EbornqcGi6fqcF1jES"
datadir    = "C:\\development\\learning\\haskell\\for_great\\starting-out\\.stack-work\\install\\9827668f\\share\\x86_64-windows-ghc-7.10.2\\starting-out-0.1.0.0"
libexecdir = "C:\\development\\learning\\haskell\\for_great\\starting-out\\.stack-work\\install\\9827668f\\libexec"
sysconfdir = "C:\\development\\learning\\haskell\\for_great\\starting-out\\.stack-work\\install\\9827668f\\etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "starting_out_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "starting_out_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "starting_out_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "starting_out_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "starting_out_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
