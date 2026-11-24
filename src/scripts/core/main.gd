extends Node3D

@onready var camera: Camera3D = $Camera3D
@onready var hex_grid = $HexGrid

var selected_tile: StaticBody3D = null


func _ready() -> void:
	print("DND initialized")


func _process(_delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			select_mouse_tile()

func select_mouse_tile() -> void:
	var mouse_position := get_viewport().get_mouse_position()

	var ray_origin := camera.project_ray_origin(mouse_position)
	var ray_direction := camera.project_ray_normal(mouse_position)

	var ray_end := ray_origin + ray_direction * 1000.0

	var query := PhysicsRayQueryParameters3D.create(
		ray_origin,
		ray_end
	)

	var result := get_world_3d().direct_space_state.intersect_ray(query)

	if result:
		var collider = result["collider"]

		if collider.has_method("set_selected"):
			if selected_tile != null:
				selected_tile.set_selected(false)

			selected_tile = collider
			selected_tile.set_selected(true)

			print("Selected hex: ", selected_tile.get("coordinates"))
