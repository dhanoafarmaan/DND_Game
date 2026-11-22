extends StaticBody3D

@export var coordinates: Vector2i = Vector2i.ZERO
@export var elevation: float = 0.0

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D # Short for get_node("MeshInstance3D")


func _ready() -> void:
	print("HexTile initialized at: ", coordinates)
