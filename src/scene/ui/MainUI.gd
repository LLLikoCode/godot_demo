extends Control

@onready var lb_score = $lb_score as Label
@onready var lb_hp = $lb_player_hp as Label
@onready var lb_lose = $lb_lose as Label
@onready var lb_win = $lb_win as Label
@onready var btn_reset = $btn_reset as Button

# Called when the node enters the scene tree for the first time.
func _ready():
	EventManager.add_event("add_score", _on_add_score)
	EventManager.add_event("change_hp", _on_change_hp)
	EventManager.add_event("game_win", _on_game_win)
	

func _process(_delta):
	lb_score.text = 'score: %d' % PlayerInfo.score
	lb_hp.text = 'hp: %d' % PlayerInfo.hp
	

func _on_add_score(score):
	PlayerInfo.score += score
	lb_score.text = 'score: %d' % PlayerInfo.score
	
	GameData.check_score(PlayerInfo.score)

func _on_change_hp(hp):
	PlayerInfo.hp += hp
	PlayerInfo.hp = maxi(PlayerInfo.hp, 0)
	lb_hp.text = 'hp: %d' % PlayerInfo.hp
	
	if PlayerInfo.hp <= 0:
		get_tree().paused = true
		lb_lose.visible = true
		$mask.visible = true
		btn_reset.visible = true

func _on_btn_reset():
	GameData.reset_data()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_game_win():
	get_tree().paused = true
	lb_win.visible = true
	$mask.visible = true
	btn_reset.visible = true

