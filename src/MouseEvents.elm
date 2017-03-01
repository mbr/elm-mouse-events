module MouseEvents
    exposing
        ( MouseEvent
        , Position
        , relPos
        , onMouseEnter
        , onMouseOver
        , onMouseMove
        , onMouseDown
        , onMouseUp
        , onClick
        , onDoubleClick
        , onContextMenu
        , onWheel
        , onMouseLeave
        , onMouseOut
        , onSelect
        , onPointerLockChange
        , onPointerLockError
        )

{-| Offers MouseEvents that expose more information about these events than
`elm-lang/html`.

Specifically, the position of mouse events can be determined precisely as
client coordinates and element (`targetPos`) coordinates are included.

# Example

```elm
import MouseEvents exposing (onMouseMove)

type Msg =
    Clicked MouseEvent

div
  [ onClick MouseMove ]
  [ text "Example div" ]
```

The `Clicked` message will contain the coordinates of the click.

# Data structures
@docs Position
@docs relPos

@docs MouseEvent

# Events
@docs onClick
@docs onContextMenu
@docs onDoubleClick
@docs onMouseDown
@docs onMouseEnter
@docs onMouseLeave
@docs onMouseMove
@docs onMouseOut
@docs onMouseOver
@docs onMouseUp
@docs onPointerLockChange
@docs onPointerLockError
@docs onSelect
@docs onWheel
-}

import DOM exposing (Rectangle)
import Html
import Html.Events exposing (on, defaultOptions)
import Json.Decode as Decode exposing (field)


{-| Encodes a position on screen
-}
type alias Position =
    { x : Int, y : Int }


{-| Mouse event data. Does not include the type of the event, but information
common to all mouse events like position.

## Fields
* `clientPos`: Event position relative to the document
* `targetPos`: Position of the element that fired the event
-}
type alias MouseEvent =
    { clientPos : Position
    , targetPos : Position
    }


{-| Calculates the relative position of an Event.

-}
relPos : MouseEvent -> Position
relPos ev =
    Position (ev.clientPos.x - ev.targetPos.x) (ev.clientPos.y - ev.targetPos.y)


mouseEvent : Int -> Int -> Rectangle -> MouseEvent
mouseEvent clientX clientY target =
    { clientPos = Position clientX clientY
    , targetPos = Position (truncate target.left) (truncate target.top)
    }


mouseEventDecoder : Decode.Decoder MouseEvent
mouseEventDecoder =
    Decode.map3
        mouseEvent
        (field "clientX" Decode.int)
        (field "clientY" Decode.int)
        (field "target" DOM.boundingClientRect)



-- reference: https://developer.mozilla.org/en-US/docs/Web/Events


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.

Note that `onMouseEnter` and other events may be prone to strange behaviour
similar to [Z-fighting](https://en.wikipedia.org/wiki/Z-fighting) they overlap
while no `z-index` style attribute is set.
-}
onMouseEnter : (MouseEvent -> msg) -> Html.Attribute msg
onMouseEnter target =
    on "mouseenter" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onMouseOver : (MouseEvent -> msg) -> Html.Attribute msg
onMouseOver target =
    on "mouseover" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onMouseMove : (MouseEvent -> msg) -> Html.Attribute msg
onMouseMove target =
    on "mousemove" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onMouseDown : (MouseEvent -> msg) -> Html.Attribute msg
onMouseDown target =
    on "mousedown" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onMouseUp : (MouseEvent -> msg) -> Html.Attribute msg
onMouseUp target =
    on "mouseup" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onClick : (MouseEvent -> msg) -> Html.Attribute msg
onClick target =
    on "click" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onDoubleClick : (MouseEvent -> msg) -> Html.Attribute msg
onDoubleClick target =
    on "dblclick" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onContextMenu : (MouseEvent -> msg) -> Html.Attribute msg
onContextMenu target =
    on "contextmenu" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onWheel : (MouseEvent -> msg) -> Html.Attribute msg
onWheel target =
    on "wheel" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onMouseLeave : (MouseEvent -> msg) -> Html.Attribute msg
onMouseLeave target =
    on "mouseleave" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onMouseOut : (MouseEvent -> msg) -> Html.Attribute msg
onMouseOut target =
    on "mouseout" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onSelect : (MouseEvent -> msg) -> Html.Attribute msg
onSelect target =
    on "select" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onPointerLockChange : (MouseEvent -> msg) -> Html.Attribute msg
onPointerLockChange target =
    on "pointerlockchange" (Decode.map target mouseEventDecoder)


{-| A mouse event, maps to the JS event with the same name. See
https://developer.mozilla.org/en-US/docs/Web/Events for details.
-}
onPointerLockError : (MouseEvent -> msg) -> Html.Attribute msg
onPointerLockError target =
    on "pointerlockerror" (Decode.map target mouseEventDecoder)
