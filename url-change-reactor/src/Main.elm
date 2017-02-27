module Main exposing (..)

import Html exposing (..)
import Navigation


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { location : Navigation.Location, phrase : String, phrases : List String }


init : Navigation.Location -> ( Model, Cmd Msg )
init initialLocation =
    ( { location = initialLocation
      , phrase = "Change the url - but only the bit after the #"
      , phrases = onChangePhrases
      }
    , Navigation.modifyUrl "#change-me-to-something-else"
    )


onChangePhrases : List String
onChangePhrases =
    [ "Change the url - but only the bit after the #"
    , "I detected a change."
    , "There was another change."
    , "It changed again."
    , "And again!"
    , "All I can do is detect changes; nothing more and nothing less."
    , "Thanks for changing the location so many times but I've run out of things to say."
    ]



-- UPDATE


type Msg
    = UrlChange Navigation.Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            let
                ( nextPhrase, nextPhrases ) =
                    nextLineAndCycleList model.phrases
            in
                { model
                    | location = location
                    , phrase = nextPhrase
                    , phrases = nextPhrases
                }
                    ! []


nextLineAndCycleList : List String -> ( String, List String )
nextLineAndCycleList script =
    case script of
        head :: tail ->
            ( head, tail ++ [ head ] )

        [] ->
            ( "Nothing to show, I'm afraid.", [] )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        href =
            model.location.href
    in
        div []
            [ h1 [] [ text "This program knows when you've changed the URL" ]
            , h2 [] [ text model.phrase ]
            , p [] [ text ("Current location is " ++ href) ]
            ]
