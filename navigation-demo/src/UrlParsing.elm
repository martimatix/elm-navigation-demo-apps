module UrlParsing exposing (..)

import UrlParser as Url exposing (..)


type Route
    = Home
    | Birds
    | Cats
    | Dogs


route : Url.Parser (Route -> a) a
route =
    Url.oneOf
        [ Url.map Home top
        , Url.map Birds (s "birds")
        , Url.map Cats (s "cats")
        , Url.map Dogs (s "dogs")
        ]
