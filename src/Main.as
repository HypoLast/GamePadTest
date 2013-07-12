package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import utils.GamePad;
	import utils.Logitech;
	
	/**
	 * ...
	 * @author Mike
	 */
	public class Main extends Sprite 
	{
		
		private var ball:Sprite;
		private var frameTime:TextField;
		private var lastFrameTime:Number;
		private var ySpeed:Number = 0;
		private var xSpeed:Number = 0;
		private var energy:Number = 100;
		
		private const speed:Number = 8;
		private const jumpSpeed:Number = 14;
		
		private var energyBar:Sprite;
		
		public function Main():void 
		{
			GamePad.init();
			
			var ground:Sprite = new Sprite();
			ground.graphics.beginFill(0xAAAAAA);
			ground.graphics.drawRect(0, 410, 800, 200);
			stage.addChild(ground);
			
			ball = new Sprite();
			ball.graphics.beginFill(0);
			ball.graphics.drawCircle(0, 0, 10);
			ball.x = 200;
			ball.y = 200;
			stage.addChild(ball);
			
			energyBar = new Sprite();
			energyBar.graphics.beginFill(0xFF8822);
			energyBar.graphics.drawRect(0, 0, 200, 20);
			energyBar.x = 20;
			energyBar.y = 30;
			stage.addChild(energyBar);
			
			frameTime = new TextField();
			stage.addChild(frameTime);
			lastFrameTime = new Date().getTime();
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void
		{
			if (xSpeed <= speed && xSpeed >= -speed)
			{
				if (isRight(GamePad.getValue(Logitech.LEFT_ANALOG_X)) || GamePad.isButtonDown(Logitech.D_RIGHT))
				{
					xSpeed = speed;
					energy -= 0.3;
					if (energy < 0)
					{
						energy = 0;
					}
				} else if (isLeft(GamePad.getValue(Logitech.LEFT_ANALOG_X)) || GamePad.isButtonDown(Logitech.D_LEFT))
				{
					xSpeed = -speed;
					energy -= 0.3;
					if (energy < 0)
					{
						energy = 0;
					}
				} else
				{
					xSpeed = 0;
				}
				if (GamePad.isButtonDown(Logitech.LT) && energy >= 10)
				{
					xSpeed = -22;
					energy -= 10;
				}
				if (GamePad.isButtonDown(Logitech.RT) && energy >= 10)
				{
					xSpeed = 22;
					energy -= 10;
				}
				if (GamePad.isButtonDown(Logitech.A) && ySpeed >= 0 && energy >= 8)
				{
					ySpeed = -jumpSpeed;
					energy -= 8;
				}
			}
			if (xSpeed > speed || xSpeed < -speed)
			{
				ySpeed = 0;
			}
			ball.y += ySpeed;
			ball.x += xSpeed;
			if (xSpeed > speed)
			{
				xSpeed --;
			}
			if (xSpeed < -speed)
			{
				xSpeed ++;
			}
			if (ball.y > 400)
			{
				ball.y = 400;
				ySpeed = 0;
			} else
			{
				ySpeed ++;
			}
			if (ball.y == 400 && energy < 100 && xSpeed <= speed && xSpeed >= -speed)
			{
				energy += 2;
				if (energy > 100)
				{
					energy = 100;
				}
			} else if (xSpeed == 0)
			{
				energy += 0.1;
				if (energy > 100)
				{
					energy = 100;
				}
			}
			if (ball.x < 10)
			{
				ball.x = 10;
			}
			if (ball.x > 790)
			{
				ball.x = 790;
			}
			energyBar.scaleX = energy / 100;
			UpdateTime();
		}
		
		private function UpdateTime():void
		{
			var t:Number = new Date().getTime();
			if (t - lastFrameTime > 40)
			{
				frameTime.text = (t - lastFrameTime) + "";
			}
			lastFrameTime = t;
		}
		
		private function isRight(value:Number):Boolean
		{
			return (value > .5);
		}
		
		private function isLeft(value:Number):Boolean
		{
			return (value < -.5);
		}
		
	}
	
}