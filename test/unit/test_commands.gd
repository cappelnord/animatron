extends GutTest

var main : Main

func before_each():
	gut.p("ran setup logger", 2)
	main = preload("res://main.tscn").instantiate()
	add_child(main)

func after_each():
	gut.p("ran teardown logger", 2)
	main.queue_free()

func before_all():
	gut.p("ran run setup logger", 2)

func after_all():
	gut.p("ran run teardown logger", 2)

func test_load():
	# asset doesn't exist
	var result = main.evalCommand(["/load", "xyz"], "127.0.0.1")
	assert_eq(result.type, Status.ERROR)
	assert_eq(result.value, null)
	assert_eq(result.msg, "Animation not loaded: xyz")
	# should pass
	result = main.evalCommand(["/load", "default"], "127.0.0.1")
	assert_eq(result.type, Status.OK)
	assert_eq(result.value, true)
	assert_eq(result.msg, "")

func test_createActor():
	# animation doesn't exist
	var result = main.evalCommand(["/create", "bla", "xyz"], "127.0.0.1")
	assert_eq(result.type, Status.ERROR)
	assert_eq(result.value, null)
	assert_eq(result.msg, "Animation not loaded: xyz")
	# should pass
	result = main.evalCommand(["/create", "bla", "default"], "127.0.0.1")
	assert_eq(result.type, Status.OK)
	assert_eq(result.value, true)
	assert_eq(result.msg, "")
