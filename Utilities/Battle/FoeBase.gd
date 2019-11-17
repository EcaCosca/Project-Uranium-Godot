extends TextureRect

var cry
onready var sprite = $Battler/Sprite

func setup_by_pokemon(poke):
	cry = poke.get_cry()
	sprite = poke.get_battle_foe_sprite()
	$Battler.add_child(sprite)
	$Battler/Shadow.texture = sprite.texture

	pass

func ball_flash():
	$Battler.visible = true
	sprite.visible = true
	var scene = load("res://Utilities/Battle/BallFlash.tscn")
	var ballflash = scene.instance()
	self.add_child(ballflash)
	ballflash.position = Vector2(140, -60)

	# Play Recall sound
	$Ball/AudioStreamPlayer.stream = load("res://Audio/SE/recall.wav")
	$Ball/AudioStreamPlayer.play()
	yield($Ball/AudioStreamPlayer, "finished")

	# Play cry sound
	$Ball/AudioStreamPlayer.stream = load(cry)
	$Ball/AudioStreamPlayer.play()

	# Play animation
	$Battler/AnimationPlayer.play("UnveilDrop")