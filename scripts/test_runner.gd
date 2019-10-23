extends Node2D

class_name TestRunner

func _ready():
	run_tests()
	yield(get_tree(), "idle_frame") # Wait a frame or two or the printed output gets lost
	yield(get_tree(), "idle_frame")
	get_tree().quit()


func run_tests():
	for file in list_files_in_directory("res://scripts/tests"):
		print("Loading test script: " + file)
		var test_object = load(file).new()
		for method in test_object.get_method_list():
			if method.name.substr(0, 5) == "test_":
				print("Running test: " + method.name)
				test_object.call(method.name)
	print("Test run finished")



# Swiped from https://godotengine.org/qa/5175/how-to-get-all-the-files-inside-a-folder
func list_files_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin(true, true)

    while true:
        var file = dir.get_next()
        if file == "":
            break
        else:
            files.append(path + "/" + file)

    dir.list_dir_end()

    return files
