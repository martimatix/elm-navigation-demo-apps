module Model exposing (..)

import Navigation
import Msg exposing (Msg)
import UrlParsing exposing (..)
import UrlParser as Url


type alias Model =
    { history : List (Maybe Route)
    , currentRoute : Maybe Route
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( Model [ Url.parseHash route location ] (Just Home)
    , Cmd.none
    )
