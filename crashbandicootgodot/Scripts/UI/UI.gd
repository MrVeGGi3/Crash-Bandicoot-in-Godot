extends Control

@onready var active_ui_timer: Timer = $ActiveUITimer
@onready var fruit_collected_animator: AnimationPlayer = %FruitCollectedAnimator
@onready var life_collected_animator: AnimationPlayer = %LifeCollectedAnimator

@onready var wumpas = get_tree().get_nodes_in_group("Wumpa")

func _ready() -> void:
	_connect_wumpas_signal()
	GameManager.fruits_to_life.connect(play_life_animation)

func _on_active_ui_timer_timeout() -> void:
	hide()

func show_ui_status():
	show()
	active_ui_timer.start()


func play_fruit_animation():
	if not fruit_collected_animator.is_playing():
		fruit_collected_animator.play("added_fruit")
	else:
		fruit_collected_animator.stop()
		fruit_collected_animator.play()
	

func play_life_animation():
	life_collected_animator.play("add_life")

func _connect_wumpas_signal():
	for wumpa in wumpas:
		wumpa.wumpa_collected.connect(play_fruit_animation)
