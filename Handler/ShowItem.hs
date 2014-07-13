module Handler.ShowItem where

import Import

getShowItemR :: ItemId -> Handler Html
getShowItemR itemId = do
  item <- runDB $ get404 itemId
  defaultLayout $ do
    $(widgetFile "item")
