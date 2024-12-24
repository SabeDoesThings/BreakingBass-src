package ent;

import h2d.col.Bounds;
import hxd.Res;
import h2d.Scene;
import h2d.Bitmap;

class MaxSeaweed extends Bitmap {
    public var bounds: Bounds;
    public var collected: Bool = false;

    public function new(x, y: Float, scene: Scene) {
        super(scene);

        this.x = x;
        this.y = y;
        this.tile = Res.Pink.toTile();

        this.bounds = Bounds.fromValues(this.x, this.y, 5, 18);
    }
}