
package ;

import Card.CardEvent;

import luxe.Color;
import luxe.Timer;
import luxe.Vector;
import luxe.Visual;

import components.ShapeFace;
import components.BoardProperties;

class Board extends Visual
{

    var animi:Float = 0;
    var startPos:Vector;

    var cards:Array<Array<Card>>;
    var emptySpots:Array<XY>;

        // Reference to properties
    var properties:BoardProperties;


    var pickedCards:PickedCards;
    var canPick:Bool = false;

    
    override function init():Void
    {
        fixed_rate = 1/60;
        properties = get('properties');
        startPos = new Vector(pos.x, pos.y);

        initBackground();
        generateCards();
        
            // Hide all cards $ init gameplay
        Luxe.timer.schedule(2, function(){
            Luxe.events.fire('card.hide');
            canPick = true;
        });

            // Picking cards
        pickedCards = {card1:null, card2:null};
        Luxe.events.listen('card.clicked', function(e){

                // break if can't pick
            if(!canPick) return;

                // first pick?
            if(pickedCards.card1 == null)
            {
                pickedCards.card1 = e;
                pickedCards.card1.events.fire('card.show');
            }
            else if(pickedCards.card2 == null)
            {
                pickedCards.card2 = e;
                pickedCards.card2.events.fire('card.show');

                // Match?
                if(pickedCards.card1.twin == pickedCards.card2)
                {
                    selectionFound();
                }
                // No match?
                else
                {
                    selectionReset();
                }
            }
        });
    }


        // Reset selection after 1 second
    function selectionReset():Void
    {
        trace('selectionReset()');
        canPick = false;
        Luxe.timer.schedule(1, function(){
            pickedCards.card1.events.fire('card.hide');
            pickedCards.card2.events.fire('card.hide');
            canPick = true;
            pickedCards = {card1:null, card2:null};
        });
    }

    function selectionFound():Void
    {
        trace('selectionFound()');
        canPick = false;
            // Send them that we found them! (blink anim?)
        pickedCards.card1.events.fire('card.found');
        pickedCards.card2.events.fire('card.found');

        Luxe.timer.schedule(1, function(){

                // remove them from array
            findAndRemoveCard(pickedCards.card1);
            findAndRemoveCard(pickedCards.card2);

                // remove them from scene
            pickedCards.card1.events.fire('card.destroy');
            pickedCards.card2.events.fire('card.destroy');

                // gameplay again
            canPick = true;
            pickedCards = {card1:null, card2:null};
        });
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
        emptySpots = new Array<XY>();

        var _card1:Card;
        var _card2:Card;

        var _color:Int;
        var _shapeRND:Int;
        var _shape:String;

        // Init 2D table
        for(i in 0...properties.size_x)
        {
            cards[i] = new Array<Card>();
        }
        // init emptyspots
        for(i in 0...properties.size_x)
        {
            for(j in 0...properties.size_y)
            {
                emptySpots.push({x:i, y:j});
            }
        }


        // Populate the table
        var k:Int = Math.floor(properties.size_x * properties.size_y / 2);
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
            _card1 = createCard(_color, _shape);
            _card2 = createCard(_color, _shape);

            _card1.twin = _card2;
            _card2.twin = _card1;
        }   
    }


    function createCard(_color:Int, _shape:String):Card
    {
        var _pos:XY = pickEmptySpot();

            // new card
        var _card:Card = new Card({
            name: 'card',
            name_unique:true,
            pos: new Vector(
                _pos.x * (Card.CARD_SIZE + properties.padding) + properties.margin + Card.CARD_SIZE/2,
                _pos.y * (Card.CARD_SIZE + properties.padding) + properties.margin + Card.CARD_SIZE/2
            )
        });
        _card.transform.parent = transform;
        _card.add(new ShapeFace({
            name: 'shapeface',
            color: new Color().rgb(_color),
            shape: _shape
        }));

        cards[_pos.x][_pos.y] = _card;

        return _card;
    }


    function pickEmptySpot():XY
    {
        var _x:Int;
        var _y:Int;
        var _r:Int;
        var _xy:XY;

        _r = Math.floor(Math.random()*emptySpots.length);
        _xy = {
            x: emptySpots[_r].x,
            y: emptySpots[_r].y
        };

        emptySpots.splice(_r, 1);

        return _xy;
    }

    function findAndRemoveCard(_card:Card):Void
    {
        var _arr:Array<Card>;
        for(i in 0...cards.length)
        {
            _arr = cards[i];
            for(j in 0..._arr.length)
            {
                if(_arr[j].name == _card.name)
                {
                    _arr.splice(j,1);
                    return;
                }
            }
        }
        trace('findAndRemoveCard() probably found nothing');
    }

    override function ondestroy():Void
    {
        cards = null;
    }




    function play():Void
    {
        
    }

}


typedef XY = {
    var x : Int;
    var y : Int;
}

typedef PickedCards = {
    var card1 : Card;
    var card2 : Card;
}
