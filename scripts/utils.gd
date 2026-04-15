extends Node

func is_facing_right(angle: float) -> bool:
	return int(round(angle / PI)) % 2 == 0

func round_to_dec(num, digit) -> float:
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
