package raccoon.particle;

import kha.Canvas;
using kha.graphics2.GraphicsExtension;
import kha.Color;
import kha.Assets;

import raccoon.Raccoon;
import raccoon.Entity;
import raccoon.particle.Particle;
import raccoon.tool.Util;

class Emitter extends Entity {
	public var arParticle:Array<Particle>;
	public var amount:Int;
	public var power = 3.0;
	
	public function new(?amount:Int = 3, ?power:Float = 3.0){
		super(0, 0, 0, 0);
		this.amount = amount;
		this.power = power;

		arParticle = [];
	}

	override public function update(){
		super.update();
		var p = arParticle.length;
		while (p --> 0){
			arParticle[p].update();
			if (arParticle[p].position.x <= 0 || arParticle[p].position.x >= Raccoon.BUFFERWIDTH || arParticle[p].position.y <= 0 || arParticle[p].position.y >= Raccoon.BUFFERHEIGHT){
				arParticle.splice(p, 1);
			}
		}
	}

	override public function render(canvas:Canvas){
		super.render(canvas);
		for (particle in arParticle){
			particle.render(canvas);
		}
	}

	public function spawn(?x:Float, ?y:Float, ?width:Float = 2.0, ?height:Float = 2.0){
		for (i in 0 ... amount){
			var particle = new Particle(x, y, width, height);
			particle.acceleration = -0.5;
			particle.velocity.x = Util.randomRangeFloat(-power, power);
			particle.velocity.y = Util.randomRangeFloat(-power, power);
			arParticle.push(particle);
		}
	}

	public function empty(){
		arParticle = [];
	}
}