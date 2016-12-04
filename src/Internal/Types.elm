module Internal.Types exposing (Point, Style, Orientation(..), Scale, Meta, HintInfo, Anchor(..), BarsMeta, barsMetaInit)


type alias Point =
    ( Float, Float )


type alias Style =
    List ( String, String )


type Orientation
    = X
    | Y


type Anchor
    = Inner
    | Outer


type alias BarsMeta =
    { lowest : Float
    , highest : Float
    , amount : Int
    , pointCount : Int
    }


barsMetaInit : BarsMeta
barsMetaInit =
    { lowest = 0
    , highest = 0
    , amount = 0
    , pointCount = 0
    }



type alias Meta =
    { scale : Scale
    , ticks : List Float
    , toSvgCoords : Point -> Point
    , fromSvgCoords : Point -> Point
    , oppositeTicks : List Float
    , oppositeScale : Scale
    , oppositeToSvgCoords : Point -> Point
    , axisCrossings : List Float
    , oppositeAxisCrossings : List Float
    , getHintInfo : Float -> HintInfo
    , toNearestX : Float -> Float
    , barsMeta : BarsMeta
    , id : String
    }


type alias Scale =
    { range : Float
    , lowest : Float
    , highest : Float
    , length : Float
    , offset : Float
    }


type alias HintInfo =
    { xValue : Float
    , yValues : List (Maybe Float)
    }
