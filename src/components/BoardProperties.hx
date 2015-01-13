
package components;

import luxe.Component;
import luxe.options.ComponentOptions;


class BoardProperties extends Component
{

    public var size_x:Int;
    public var size_y:Int;

    public var margin:Int;
    public var padding:Int;

    override public function new( ?_options:BoardComponentOptions ) {

        size_x = _options.size_x;
        size_y = _options.size_y;

        margin = _options.margin;
        padding = _options.padding;

        super(_options);

    } //new


    override function init():Void
    {
        
    }

}



typedef BoardComponentOptions = {

    > ComponentOptions,

        // size of the board
    var size_x : Int;
    var size_y : Int;

    var margin : Int;
    var padding : Int;

} //ComponentOptions
