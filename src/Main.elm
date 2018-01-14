module Main exposing (..)

import Html exposing (Html, div, h1, text, label, input)
import Html.Attributes as Attributes exposing (class, placeholder, type_)
import Html.Events exposing (onClick, onInput)


---- MODEL ----


type alias Model =
    { inputValue : String, friendsList : List String }


init : ( Model, Cmd msg )
init =
    ( { inputValue = "", friendsList = [ "Friend 1", "Friend 2" ] }, Cmd.none )



---- UPDATE ----


type Msg
    = ChangeName
    | UpdateInputValue String
    | AddFriend
    | RemoveFriend String


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        ChangeName ->
            ( { inputValue = model.inputValue, friendsList = [ "Tony Stark" ] }, Cmd.none )

        AddFriend ->
            if String.isEmpty model.inputValue then
                ( model, Cmd.none )
            else
                ( { inputValue = "", friendsList = model.inputValue :: model.friendsList }, Cmd.none )

        RemoveFriend name ->
            ( { model | friendsList = List.filter String.})                

        UpdateInputValue value ->
            ( { inputValue = value, friendsList = model.friendsList }, Cmd.none )



---- VIEW ----


cardView : String -> Html Msg
cardView name =
    div [ class "card" ]
        [ div [ class "content" ]
            [ Html.i [ class "right floated remove red icon link" ]
                []
            , div [ class "description", onClick ChangeName ]
                [ text name ]
            ]
        ]


friends =
    [ "Tony Stark", "Bruce Wayne" ]


view { friendsList } =
    div [ class "ui main text container" ]
        [ h1 [ class "ui header" ]
            [ text "Friends List" ]
        , div [ class "ui segment" ]
            [ div [ class "ui form" ]
                [ div [ class "field" ]
                    [ label []
                        [ text "Name" ]
                    , input [ placeholder "Name", type_ "text", onInput UpdateInputValue, Attributes.required True ]
                        []
                    ]
                , div [ class "ui button", onClick AddFriend ]
                    [ text "Add a friend" ]
                ]
            ]
        , div [ class "ui two column cards" ]
            (List.map cardView friendsList)
        ]



---- PROGRAM ----


main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
