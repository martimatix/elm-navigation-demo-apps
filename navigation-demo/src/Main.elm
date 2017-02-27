module Main exposing (..)

import Navigation
import Model exposing (init, Model)
import View exposing (view)
import Update exposing (update)
import Msg exposing (..)


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
