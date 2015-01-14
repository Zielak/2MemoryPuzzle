
package ;

import luxe.Color;
import luxe.Input;
import luxe.Vector;


import components.BoardProperties;




class Main extends luxe.Game
{

    var playing:Bool;

    var score:Int;

    var board:Board;


    override function config(config:luxe.AppConfig):luxe.AppConfig
    {
        config.window.width = 640;
        config.window.height = 480;
        config.window.resizable = false;
                
        return config;
    }

    override function ready()
    {

        initGame();
        play();

    } //ready

    override function onkeyup( e:KeyEvent )
    {

        if(e.keycode == Key.escape)
        {
            Luxe.shutdown();
        }

        // if(e.keycode == Key.enter)
        // {
        //     initGame();
        //     play();
        // }

    } //onkeyup

    override function update(dt:Float)
    {
        
    } //update

    // override function onmousemove(event:luxe.MouseEvent):Void
    // {
    //     Luxe.events.fire('mouse.move', event);
    // }

    function initGame():Void
    {

        var boardProperties:BoardProperties = new BoardProperties({
            name: 'properties',
            size_x: 4,
            size_y: 4,
            padding: 5,
            margin: 20
        });

        board = new Board({
            name: 'board',
            pos: new Vector(100, 100),
            color: new Color().rgb(0x223322)
        });
        board.add(boardProperties);

    }


    function play():Void
    {
        
    }




} //Main

