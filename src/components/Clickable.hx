
package components;

import Card;

import luxe.Component;
import luxe.Color;
import luxe.Input.MouseEvent;
import luxe.Rectangle;
import luxe.Vector;
import luxe.Visual;


class Clickable extends Component
{

    public var overColor:Color;
    public var outColor:Color;

    var bounds:Rectangle;

    var isOver:Bool = false;

    

    override function init():Void
    {
        

        outColor = cast(entity, Visual).color;
        overColor = new Color().rgb(0xEEEEEE);

        bounds = new Rectangle(entity.pos.x - Card.CARD_SIZE/2, entity.pos.y - Card.CARD_SIZE/2, Card.CARD_SIZE, Card.CARD_SIZE);
    }

    override function onfixedupdate(rate:Float):Void
    {
        bounds.x = entity.pos.x - Card.CARD_SIZE/2;
        bounds.y = entity.pos.y - Card.CARD_SIZE/2;

        if(entity.transform.parent != null)
        {
            bounds.x += entity.transform.parent.local.pos.x;
            bounds.y += entity.transform.parent.local.pos.y;
        }
    }

    override public function onmousemove(event:MouseEvent):Void
    {
        if( bounds.point_inside(event.pos) && !isOver )
        {
            onover();
        }
        if( !bounds.point_inside(event.pos) && isOver )
        {
            onout();
        }
    }

    function onover():Void
    {
        trace('OVER');
        isOver = true;
        cast(entity, Visual).color = overColor;
    }


    function onout():Void
    {
        trace('OUT');
        isOver = false;
        cast(entity, Visual).color = outColor;
    }

}