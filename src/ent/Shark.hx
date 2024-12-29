package ent;

import h2d.col.Bounds;
import hxd.Window;
import hxd.Res;
import h2d.Scene;
import h2d.Bitmap;

class Shark extends Bitmap {
    public var speed: Float;

    var directionX: Int;
    
    public var bounds: Bounds;

    public function new(x, y: Float, scene: Scene, dirX: Int) {
        super(scene);

        this.x = x;
        this.y = y;
        this.tile = Res.Shark.toTile();
        this.speed = 200;
        this.directionX = dirX;

        this.scaleX = dirX == -1 ? -1 : 1;

        this.bounds = Bounds.fromValues(this.x, this.y, 32, 19);
    }

    public function update(dt: Float) {
        this.x += directionX * speed * dt;

        this.bounds.x = this.x;
        this.bounds.y = this.y;
    }
}
