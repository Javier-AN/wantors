extends Node


## Studies whether a vector with the given [param angle] would be facing right.
## Returns [code]true[/code] if it is, [code]false[/code] if not.
func is_facing_right(angle: float) -> bool:
	return int(round(angle / PI)) % 2 == 0


## Returns [param string] with its first character converted to
## [code]UPPERCASE[/code].
func first_to_upper(string: String) -> String:
	return string[0].to_upper() + string.substr(1,-1)


## Returns an [code]Array[/code] with [param n] random elements from
## [param array].
func pick_randoms(array: Array, n: int) -> Array:
	var pool := array.duplicate()
	var picks := []
	while picks.size() < n and pool.size() > 0:
		var index := randi_range(0, pool.size() - 1)
		picks.append(pool[index])
		pool.remove_at(index)
	return picks


## Returns [param file_name] without the [code].remap[/code] extension.
func trim_remap(file_name: String) -> String:
	return file_name.left(-6) if file_name.ends_with(".remap") else file_name
