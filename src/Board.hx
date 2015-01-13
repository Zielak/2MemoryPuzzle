
package ;

import luxe.Color;
import luxe.Vector;
import luxe.Visual;

import components.ShapeFace;
import components.BoardProperties;

class Board extends Visual
{

    var animi:Float = 0;
    var startPos:Vector;

    var cards:Array<Array<Card>>;

        // Reference to properties
    var properties:BoardProperties;
    
    override function init():Void
    {
        
        properties = get('properties');
        startPos = new Vector(pos.x, pos.y);

        // initBackground();
        // generateCards();
        // testCards();

    }

    override public function update(dt:Float):Void
    {
        animi += dt;
        if(animi > Math.PI*2) animi = 0;

        pos.x = Math.sin(animi)*10 + startPos.x;
        pos.y = Math.cos(animi)*10 + startPos.y;

    }


    function initBackground():Void
    {
        // trace('color = ${color}');
        geometry = Luxe.draw.box({
            x: 0,
            y: 0,
            w: (properties.size_x*Card.CARD_SIZE) + ((properties.size_x-1)*properties.padding) + 2*properties.margin,
            h: (properties.size_y*Card.CARD_SIZE) + ((properties.size_y-1)*properties.padding) + 2*properties.margin
        });
        
    }

    function generateCards():Void
    {
        cards = new Array<Array<Card>>();

        var _card:Card;
        var _front:Visual;
        var _shapeface:ShapeFace;

        var _color:Int;
        var _shapeRND:Int;
        var _shape:String;

        for(i in 0...properties.size_x)
        {
            cards[i] = new Array<Card>();

            for(j in 0...properties.size_y)
            {
                _color =      Math.floor(Math.random()*0xFFFFFF);
                _shapeRND =   Math.floor(Math.random()*3);
                switch(_shapeRND)
                {
                    case 0: _shape = 'box';
                    case 1: _shape = 'circle';
                    case 2: _shape = 'triangle';
                    default: _shape = 'box';
                }

                    // new card's front face Component
                _shapeface = new ShapeFace({
                    name: 'shapeface',
                    color: new Color().rgb(_color),
                    shape: _shape
                });

                    // new card
                _card = new Card({
                    name: 'card',
                    name_unique:true,
                    pos: new Vector(
                        i * (Card.CARD_SIZE + 20) + properties.margin + Card.CARD_SIZE/2,
                        j * (Card.CARD_SIZE + 20) + properties.margin + Card.CARD_SIZE/2
                    ),

                });
                    // new front face thing
                _front = new Visual({
                    name: 'cardfront',
                    name_unique:true
                });
                _front.add(_shapeface);
                _front.transform.parent = _card.transform;

                    // change parents
                _card.transform.parent = transform;

                cards[i][j] = _card;
            }
        }
    }

    function testCards():Void
    {
        var newThing:Visual = new Visual({
            name: 'testthing',
            geometry: Luxe.draw.box({
                x: 0,
                y: 0,
                w: 10,
                h: 100
            }),
            color: new Color().rgb(0x00ff00)
        });

        // newThing.transform.parent = transform;
    }

    override function ondestroy():Void
    {
        cards = null;
    }


}
