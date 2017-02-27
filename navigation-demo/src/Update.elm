module Update exposing (update)

import Msg exposing (Msg(..))
import Model exposing (Model)
import UrlParser as Url exposing (parsePath)
import UrlParsing exposing (route)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            let
                nextRoute =
                    Url.parseHash route location
            in
                { model
                    | history = nextRoute :: model.history
                    , currentRoute = nextRoute
                }
                    ! []
