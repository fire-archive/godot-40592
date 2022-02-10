extends Node3D

@export var replayTime:float = 124140000
@export var replaySpeed:float = 1
@export var replayTimeLoopStart = 124140000
@export var replayTimeLoopEnd = 124140000 + 100 * 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	replayTime += delta * 1000 * replaySpeed
	if (replayTime >= replayTimeLoopEnd):
		replayTime = replayTimeLoopStart
	
	if Input.is_action_just_pressed("reset_playback"):
		replayTime = replayTimeLoopStart
		$AnimationPlayer.seek(0, true)
		$DebugTraces_slerp.clear()
		$DebugTraces_cubic_slerp.clear()
		$DebugTraces_LOScript_slerp.clear()
		$DebugTraces_LOScript_cubic_slerp.clear()

func _input(event):
	if event is InputEventKey and event.pressed:
		var keyEvent:InputEventKey = event
		if (keyEvent.keycode == KEY_0):
			replaySpeed = 0
			$AnimationPlayer.playback_speed = 0
		elif ((keyEvent.keycode >= KEY_1) && (keyEvent.keycode <= KEY_9)):
			var tempSpeed:float = pow(2, keyEvent.keycode - KEY_7)

			if (Input.is_action_pressed("replay_backward")):
				tempSpeed *= -1

			replaySpeed = tempSpeed;

	$AnimationPlayer.playback_speed = replaySpeed