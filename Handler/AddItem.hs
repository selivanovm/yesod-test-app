module Handler.AddItem where

import Import
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import qualified Data.ByteString as B
import qualified Data.Aeson as J
import Data.ByteString.Base64 as B64
import Data.UUID
import Data.UUID.V4(nextRandom)

postAddItemR :: HandlerT App IO Value
postAddItemR = do
  newItem <- parseJsonBody :: Handler (J.Result Item)
  case newItem of
    J.Error _ -> return errorResp
    J.Success i -> case i of
      Item description color size photo -> saveItem description color size photo
      _ -> return errorResp

saveItem :: Text -> Text -> Text -> Text -> HandlerT App IO Value
saveItem description color size photo = do
  imageName <- liftIO generateImageName
  saveImageResult <- liftIO $ storeImage photo imageName
  case (saveImageResult) of
    Left e -> return $ errorResp' e
    Right imgPath' -> do
      runDB $ insert $ Item description color size (T.pack imageName)
      return $ object [ "status" .= (T.pack imageName) ]

storeImage :: Text -> String -> IO (Either String (IO ()))
storeImage photo imageName = do
  imageBytes <- return $ B64.decode . TE.encodeUtf8 $ photo
  case imageBytes of
    Left e -> return $ Left e
    Right bytes -> do
      saveImageFile imageName bytes
      return $ Right $ return ()

saveImageFile :: String -> B.ByteString -> IO ()
saveImageFile imageName bytes = B.writeFile (generateImagePath imageName) bytes

generateImageName :: IO String
generateImageName = fmap (\x -> (toString x) ++ ".jpeg") nextRandom 

generateImagePath :: String -> FilePath
generateImagePath imageName = "./static/img/" ++ imageName

errorResp = object [ "status" .= ("Error" :: Text) ]
errorResp' e = object [ "status" .= ("Error" :: Text), "message" .= e ]

