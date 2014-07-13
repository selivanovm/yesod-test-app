module Handler.ListItems where

import Import

getListItemsR :: Handler Html
getListItemsR = do
  items <- runDB $ selectList [] [Asc ItemDescription]
  defaultLayout $ do
    $(widgetFile "items")
