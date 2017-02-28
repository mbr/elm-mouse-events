module Demo exposing (..)

import MouseEvents exposing (..)
import Html exposing (Html, div, text, code)
import Html.Attributes exposing (style)


main =
    Html.program
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { mouseEnters : Int
    , lastMouseEnter : Position
    , mouseOvers : Int
    , lastMouseOver : Position
    , mouseMoves : Int
    , lastMouseMove : Position
    , mouseDowns : Int
    , lastMouseDown : Position
    , mouseUps : Int
    , lastMouseUp : Position
    , clicks : Int
    , lastClick : Position
    , doubleClicks : Int
    , lastDoubleClick : Position
    , contextMenus : Int
    , lastContextMenu : Position
    , wheels : Int
    , lastWheel : Position
    , mouseLeaves : Int
    , lastMouseLeave : Position
    , mouseOuts : Int
    , lastMouseOut : Position
    }


type Msg
    = MouseEnter MouseEvent
    | MouseOver MouseEvent
    | MouseMove MouseEvent
    | MouseDown MouseEvent
    | MouseUp MouseEvent
    | Click MouseEvent
    | DoubleClick MouseEvent
    | ContextMenu MouseEvent
    | Wheel MouseEvent
    | MouseLeave MouseEvent
    | MouseOut MouseEvent


origin : Position
origin =
    Position 0 0


init : ( Model, Cmd Msg )
init =
    ( { mouseEnters = 0
      , lastMouseEnter = origin
      , mouseOvers = 0
      , lastMouseOver = origin
      , mouseMoves = 0
      , lastMouseMove = origin
      , mouseDowns = 0
      , lastMouseDown = origin
      , mouseUps = 0
      , lastMouseUp = origin
      , clicks = 0
      , lastClick = origin
      , doubleClicks = 0
      , lastDoubleClick = origin
      , contextMenus = 0
      , lastContextMenu = origin
      , wheels = 0
      , lastWheel = origin
      , mouseLeaves = 0
      , lastMouseLeave = origin
      , mouseOuts = 0
      , lastMouseOut = origin
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( case msg of
        MouseEnter ev ->
            { model
                | mouseEnters = model.mouseEnters + 1
                , lastMouseEnter = relPos ev
            }

        MouseOver ev ->
            { model
                | mouseOvers = model.mouseOvers + 1
                , lastMouseOver = relPos ev
            }

        MouseMove ev ->
            { model
                | mouseMoves = model.mouseMoves + 1
                , lastMouseMove = relPos ev
            }

        MouseDown ev ->
            { model
                | mouseDowns = model.mouseDowns + 1
                , lastMouseDown = relPos ev
            }

        MouseUp ev ->
            { model
                | mouseUps = model.mouseUps + 1
                , lastMouseUp = relPos ev
            }

        Click ev ->
            { model
                | clicks = model.clicks + 1
                , lastClick = relPos ev
            }

        DoubleClick ev ->
            { model
                | doubleClicks = model.doubleClicks + 1
                , lastDoubleClick = relPos ev
            }

        ContextMenu ev ->
            { model
                | contextMenus = model.contextMenus + 1
                , lastContextMenu = relPos ev
            }

        Wheel ev ->
            { model
                | wheels = model.wheels + 1
                , lastWheel = relPos ev
            }

        MouseLeave ev ->
            { model
                | mouseLeaves = model.mouseLeaves + 1
                , lastMouseLeave = relPos ev
            }

        MouseOut ev ->
            { model
                | mouseOuts = model.mouseOuts + 1
                , lastMouseOut = relPos ev
            }
    , Cmd.none
    )



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ code [] [ text <| toString model ]
        , div
            [ style
                [ ( "width", "200px" )
                , ( "height", "200px" )
                , ( "position", "absolute" )
                , ( "background-color", "rgba(200,0,0,0.5)" )
                , ( "top", "250px" )
                , ( "left", "250px" )
                , ( "z-index", "20" )
                ]
            , onMouseEnter MouseEnter
            , onMouseOver MouseOver
            , onMouseMove MouseMove
            , onMouseDown MouseDown
            , onMouseUp MouseUp
            , onClick Click
            , onDoubleClick DoubleClick
            , onContextMenu ContextMenu
            , onWheel Wheel
            , onMouseLeave MouseLeave
            , onMouseOut MouseOut
            ]
            []
          -- note that defining the z-index is crucial here
        , div
            [ style
                [ ( "width", "200px" )
                , ( "height", "200px" )
                , ( "position", "absolute" )
                , ( "background-color", "rgba(0,200,0,0.5)" )
                , ( "top", "150px" )
                , ( "left", "150px" )
                , ( "z-index", "10" )
                ]
            , onMouseEnter MouseEnter
            , onMouseOver MouseOver
            , onMouseMove MouseMove
            , onMouseDown MouseDown
            , onMouseUp MouseUp
            , onClick Click
            , onDoubleClick DoubleClick
            , onContextMenu ContextMenu
            , onWheel Wheel
            , onMouseLeave MouseLeave
            , onMouseOut MouseOut
            ]
            []
        ]
