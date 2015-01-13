
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
            color: color,
            depth: 2
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
        _shapesize = Card.CARD_SIZE*0.25;
        face.geometry = Luxe.draw.ngon({
            x:0, y:0,
            r: _shapesize,
            sides: 8,
            solid: true
        });
    }
    function drawBox():Void
    {
        _shapesize = Card.CARD_SIZE*0.25;
        face.geometry = Luxe.draw.ngon({
            x:0, y:0,
            r: _shapesize,
            sides: 4,
            solid: true
        });
    }
    function drawTriangle():Void
    {
        _shapesize = Card.CARD_SIZE*0.25;
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
