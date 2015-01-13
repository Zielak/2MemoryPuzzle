
package components;

import luxe.Circle;
import luxe.Rectangle;

import luxe.Component;
import luxe.Color;
import luxe.Visual;
import luxe.options.ComponentOptions;

class ShapeFace extends Component
{

    public var color:Color;
    public var shape:String;

    var _shapesize:Float;
    var face:Visual;



    override public function new( ?_options:ShapeFaceOptions ) {

        shape = _options.shape;
        color = _options.color;

        super(_options);

    } //new

    override function init():Void
    {
        // trace('color ${color}');
        // trace('shape ${shape}');
        // trace('-----');
    }

    override function onadded():Void
    {
        draw();
    }

    override function onremoved():Void
    {

    }

    public function draw():Void
    {
        face = new Visual({
            name:'face',
            name_unique:true,
            color: color
        });
        switch(shape)
        {
            case 'circle': drawCircle();
            case 'box': drawBox();
            case 'triangle': drawTriangle();
        }

        face.transform.parent = entity.transform;
    }


    function drawCircle():Void
    {
        _shapesize = Card.CARD_SIZE*0.4;
        // face.geometry = Luxe.draw.circle({
        //     x:0, y:0,
        //     r: _shapesize
        // });
        face.geometry = Luxe.draw.ngon({
            x:0, y:0,
            r: _shapesize,
            sides: 16,
            solid: true
        });
    }
    function drawBox():Void
    {
        _shapesize = Card.CARD_SIZE*0.6;
        // face.geometry = Luxe.draw.box({
        //     x: -_shapesize/2,
        //     y: -_shapesize/2,
        //     w: _shapesize,
        //     h: _shapesize
        // });
        face.geometry = Luxe.draw.ngon({
            x:0, y:0,
            r: _shapesize,
            sides: 4,
            solid: true
        });
    }
    function drawTriangle():Void
    {
        _shapesize = Card.CARD_SIZE*0.4;
        face.geometry = Luxe.draw.ngon({
            x:0, y:0,
            r: _shapesize,
            sides: 3,
            solid: true
        });
    }


}


typedef ShapeFaceOptions = {

    > ComponentOptions,

    var shape : String;
    var color : Color;

}
