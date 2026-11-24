extends StaticBody3D

@export var coordinates: Vector2i = Vector2i.ZERO
@export var elevation: float = 0.0
@export var base_color: Color = Color(0.3, 0.4, 0.5)
@export var selected_color: Color = Color(1.0, 0.7, 0.2)

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D # Short for get_node("MeshInstance3D")

var tile_material: StandardMaterial3D

func _ready() -> void:
	print("HexTile initialized at: ", coordinates)

	tile_material = StandardMaterial3D.new()
	tile_material.albedo_color = base_color

	mesh_instance.material_override = tile_material


func set_selected(selected: bool) -> void:
	if selected:
		tile_material.albedo_color = selected_color
	else:
		tile_material.albedo_color = base_color
