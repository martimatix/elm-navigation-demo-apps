module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
import UrlParsing exposing (..)


view : Model -> Html msg
view model =
    case model.currentRoute of
        Just Home ->
            homeView model

        Just Birds ->
            animalView "birds" "have wings and a beak"

        Just Cats ->
            animalView "cats" "have whiskers and claws"

        Just Dogs ->
            animalView "dogs" "bark and like to go for walks."

        Nothing ->
            notFoundView


homeView : Model -> Html msg
homeView model =
    div []
        [ h1 [] [ text "Pages" ]
        , ul [] (List.map viewLink [ "birds", "cats", "dogs" ])
        , h1 [] [ text "History" ]
        , ul [] (List.map viewRoute model.history)
        ]


viewRoute : Maybe Route -> Html msg
viewRoute maybeRoute =
    case maybeRoute of
        Nothing ->
            li [] [ text "Invalid URL" ]

        Just route ->
            li [] [ code [] [ text (toString route) ] ]


viewLink : String -> Html msg
viewLink name =
    li [] [ a [ href ("#" ++ name) ] [ text name ] ]


animalView : String -> String -> Html msg
animalView animal description =
    let
        animalDescription =
            animal ++ " " ++ description

        imagePath =
            "images/" ++ animal ++ ".jpg"
    in
        div []
            [ p [] [ a [ href "#" ] [ text "Back to index " ] ]
            , h1 [] [ text animalDescription ]
            , img [ src imagePath ] []
            ]


notFoundView : Html msg
notFoundView =
    div []
        [ h1 [] [ text "Not found :(" ]
        ]
