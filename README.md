* Yesod Test App
  
  Tested on : 
    GHC 7.6.3
    cabal lib 1.20.0.1
    cabal-install 1.20.0.3
 
  to run execute in console:

  # cabal sandbox init
  # cabal install --enable-tests . yesod-platform yesod-bin --max-backjumps=-1 --reorder-goals
  # yesod devel

* API

  List items : http://localhost:3000/shoes-list
  Add item : http://localhost:3000/shoes-list/add
  Show item : http://locahost:3000/get/#itemId

  To add test items execute: addItem1.sh or addItem2.sh





