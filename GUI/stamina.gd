extends ColorRect

@onready var value = $Value

func update_sp_ui(sp,max_sp):
	value.size.x = 98*(sp/max_sp)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
