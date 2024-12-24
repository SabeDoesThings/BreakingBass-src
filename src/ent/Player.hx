package ent;

import h2d.col.Bounds;
import hxd.Key;
import hxd.Res;
import h2d.Bitmap;
import h2d.Scene;

class Player extends Bitmap {
    var speed: Int;
    
    public var bounds: Bounds;

    public function new(x, y: Float, scene: Scene) {
        super(scene);

        this.x = x;
        this.y = y;
        this.tile = Res.Orange.toTile();
        this.speed = 100;
        this.bounds = Bounds.fromValues(this.x, this.y, 19, 16);
    }

    public function update(dt: Float) {
        var maxX = 747;
        var minX = 49;
        var maxY = 543;
        var minY = 0;

        { // Movement
            // sprinting
            var currentSpeed = if (Key.isDown(Key.SHIFT)) speed * 1.5 else speed;

            if (Key.isDown(Key.W)) {
                this.y -= currentSpeed * dt;
            }
            if (Key.isDown(Key.A)) {
                this.x -= currentSpeed * dt;
                this.scaleX = -1;
            }
            if (Key.isDown(Key.S)) {
                this.y += currentSpeed * dt;
            }
            if (Key.isDown(Key.D)) {
                this.x += currentSpeed * dt;
                this.scaleX = 1;
            }
        }

        { // Bound the player inside the map
            if (this.x >= maxX) {
                this.x = maxX;
            }
            if (this.x <= minX) {
                this.x = minX;
            }
            if (this.y >= maxY) {
                this.y = maxY;
            }
            if (this.y <= minY) {
                this.y = minY;
            }
        }

        this.bounds.x = this.x;
        this.bounds.y = this.y;
    }
}