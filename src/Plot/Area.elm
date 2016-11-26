module Plot.Area exposing (..)

import Plot.Types exposing (..)
import Helpers exposing (..)
import Svg
import Svg.Attributes


--## Area configuration
--@docs AreaAttr, areaStyle


type alias Config =
    { style : Style }


{-| The type representing an area attribute.
-}
type alias Attribute =
    Config -> Config


{-| Add styles to your area serie.

    main =
        plot
            []
            [ area
                [ areaStyle
                    [ ( "fill", "deeppink" )
                    , ( "stroke", "deeppink" )
                    , ( "opacity", "0.5" ) ]
                    ]
                ]
                areaDataPoints
            ]
-}
style : Style -> Attribute
style style config =
    { config | style = style }


toConfig : List Attribute -> Config
toConfig attrs =
    List.foldr (<|) defaultConfig attrs


defaultConfig : Config
defaultConfig =
    { style = [] }


view : Meta -> Config -> List Point -> Svg.Svg a
view { toSvgCoords } { style } points =
    let
        range =
            List.map Tuple.first points

        ( lowestX, highestX ) =
            ( getLowest range, getHighest range )

        svgCoords =
            List.map toSvgCoords points

        ( highestSvgX, originY ) =
            toSvgCoords ( highestX, 0 )

        ( lowestSvgX, _ ) =
            toSvgCoords ( lowestX, 0 )

        startInstruction =
            toInstruction "M" [ lowestSvgX, originY ]

        endInstructions =
            toInstruction "L" [ highestSvgX, originY ]

        instructions =
            coordToInstruction "L" svgCoords
    in
        Svg.path
            [ Svg.Attributes.d (startInstruction ++ instructions ++ endInstructions ++ "Z")
            , Svg.Attributes.style (toStyle style)
            ]
            []