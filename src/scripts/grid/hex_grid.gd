extends Node3D

@export var columns: int = 4
@export var rows: int = 3
@export var hex_radius: float = 1.0
@export var tile_y_offset: float = 0.1
@export var tile_scene: PackedScene

var tiles: Dictionary = {}

func _ready() -> void:
	generate_grid()


func generate_grid() -> void:
	if tile_scene == null:
		push_error("HexGrid: No tile scene has been assigned.")
		return

	for r in range(rows):
		for q in range(columns):
			var tile := tile_scene.instantiate() as StaticBody3D

			if tile == null:
				push_error("HexGrid: The tile scene root must be a StaticBody3D.")
				return

			tile.set("coordinates", Vector2i(q, r))

			var world_position := axial_to_world(q, r)
			tile.position = Vector3(
				world_position.x,
				tile_y_offset,
				world_position.z
			)

			tile.scale = Vector3(0.96, 1.0, 0.96)
			add_child(tile)
			tiles[Vector2i(q, r)] = tile


func axial_to_world(q: int, r: int) -> Vector3:
	var x: float = hex_radius * sqrt(3.0) * (q + r / 2.0)
	var z: float = hex_radius * 1.5 * r

	return Vector3(x, 0.0, z)
	
func get_tile(coordinates: Vector2i) -> StaticBody3D:
	return tiles.get(coordinates)
