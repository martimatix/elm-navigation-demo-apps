module Main exposing (..)

import Html exposing (..)
import Navigation
import Time exposing (Time, second, inSeconds)


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
    List String


init : Navigation.Location -> ( Model, Cmd Msg )
init _ =
    ( theatricalScript, Cmd.none )



-- UPDATE


type Msg
    = Tick Time
    | UrlChange Navigation.Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange _ ->
            model ! []

        Tick time ->
            if time |> inSeconds |> isMultipleOfThree then
                let
                    ( nextLine, nextModel ) =
                        nextLineAndCycleList model
                in
                    nextModel ! [ Navigation.modifyUrl nextLine ]
            else
                model ! []


isMultipleOfThree : Float -> Bool
isMultipleOfThree float =
    round float % 3 == 0


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
    Time.every second Tick



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Look at the location bar." ]
        ]



-- THEATRICAL SCRIPT
-- Underscores have been used in place of spaces as they are not supported
-- in the location bar.


theatricalScript : List String
theatricalScript =
    [ "Why_did_it_all_turn_out_like_this_for_me?"
    , "I_had_so_much_promise."
    , "I_was_personable,_I_was_bright"
    , "oh,_maybe_not_academically_speaking,_but_I_was_perceptive."
    , "I_always_know_when_someone’s_uncomfortable_at_a_party."
    , "It_became_very_clear_to_me_sitting_out_there_today"
    , "that_every_decision_I've_made_in_my_entire_life_has_been_wrong."
    , "My_life_is_the_complete_opposite_of_everything_I_want_it_to_be."
    , "Every_instinct_I_have,_in_every_aspect_of_life"
    , "be_it_something_to_wear,_something_to_eat"
    , "it's_all_been_wrong."
    , "-George_Costanza"
    , ""
    , "Show's_over,_you_can_go_home_now."
    , ""
    ]
