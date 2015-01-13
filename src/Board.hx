
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
        fixed_rate = 1/60;
        properties = get('properties');
        startPos = new Vector(pos.x, pos.y);

        initBackground();
        generateCards();
        // testCards();

    }


    function initBackground():Void
    {
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

        var _color:Int;
        var _shapeRND:Int;
        var _shape:String;
        var _pos:Vector<Int>;

        // Init 2D table
        for(i in 0...properties.size_x)
        {
            cards[i] = new Array<Card>();
        }

        // Populate the table
        var k:Int = properties.size_x * properties.size_y;
        for(i in 0...k)
        {
            _color =      Math.floor(Math.random()*0xFFFFFF);
            _shapeRND =   Math.floor(Math.random()*3);
            switch(_shapeRND)
            {
                case 1: _shape = 'circle';
                case 2: _shape = 'triangle';
                default: _shape = 'box';
            }

            _pos = pickEmptySpot();

                // new card
            _card = new Card({
                name: 'card',
                name_unique:true,
                pos: new Vector(
                    i * (Card.CARD_SIZE + properties.padding) + properties.margin + Card.CARD_SIZE/2,
                    j * (Card.CARD_SIZE + properties.padding) + properties.margin + Card.CARD_SIZE/2
                )
            });
            _card.transform.parent = transform;
            _card.add(new ShapeFace({
                name: 'shapeface',
                color: new Color().rgb(_color),
                shape: _shape
            }));

            cards[i][j] = _card;
        }
    }


    function pickEmptySpot():Vector
    {
        var newpos = new Vector();

        newpos.x = 0;
        newpos.y = 0;


        return newpos;
    }

    override function ondestroy():Void
    {
        cards = null;
    }

}
