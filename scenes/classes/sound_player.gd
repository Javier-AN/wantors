@abstract
class_name SoundPlayer
extends Node
## Credit to mrcdk.
## https://forum.godotengine.org/t/best-proper-way-to-do-ui-sounds-hover-click/39081/2

var playback: AudioStreamPlaybackPolyphonic
var pausable: bool


func _enter_tree() -> void:
	# Create an audio player
	var player = AudioStreamPlayer.new()
	player.process_mode = PROCESS_MODE_PAUSABLE if pausable else PROCESS_MODE_ALWAYS
	player.bus = "SFX"
	add_child(player)

	# Create a polyphonic stream so we can play sounds directly from it
	var stream = AudioStreamPolyphonic.new()
	stream.polyphony = 32
	player.stream = stream
	player.play()
	# Get the polyphonic playback stream to play sounds
	playback = player.get_stream_playback()

	get_tree().node_added.connect(_on_node_added)


@abstract func _on_node_added(node:Node) -> void


## Plays [param sound].
func play(sound: Resource):
	playback.play_stream(sound)
