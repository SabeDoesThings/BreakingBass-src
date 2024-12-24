package;

import levels.*;

class Game extends hxd.App {
    var currentLevel: Level;

    override function init() {
        inst = this;

        currentLevel = new MainMenu();

        setLevel(currentLevel);
    }

    public function setLevel(level: Level) {
        setScene(level);
        this.currentLevel = level;
    }

    override function update(dt:Float) {
        currentLevel.update(dt);
    }

    public static var inst: Game;
    static function get_inst(): Game {
        if (inst == null)
            inst = new Game();

        return inst;
    }

    static function main() {
        get_inst().engine.backgroundColor = 0x6b74b2;

        #if sys
		hxd.Res.initLocal(); // important! allows the app access to our game's resource files: images (sprites), audio, etc.
        #else
        hxd.Res.initEmbed(); // use hxd.Res.initEmbed(); for html5/js
        #end

        inst;
    }
}
