extends Node

func is_facing_right(angle: float) -> bool:
	return int(round(angle / PI)) % 2 == 0
