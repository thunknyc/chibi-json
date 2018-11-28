(import (thunknyc json) (scheme red) (chibi test) (chibi show))

(test-begin "(thunknyc json)")
(test "Integer" 42 (parse-json "42"))
(test "True" #t (parse-json "true"))
(test "False" #f (parse-json "false"))
(test "String" "foo" (parse-json "\"foo\""))
(let* ((simple-array "[0, 1, 2, true, \"bar\"]")
       (simple-dictionary "{\"foo\": 42, \"bar\": true}")
       (complex-dictionary (show #f "{\"snafu\": " simple-dictionary "}"))
       (complex-array (show #f "[[],{}," complex-dictionary "]")))
  (test "Array" #(0 1 2 #t "bar") (parse-json simple-array))
  (test "Simple dictionary"
	'(("foo" . 42) ("bar" . #t))
	(parse-json simple-dictionary))
  (test "Complex dictionary"
	'(("snafu" . (("foo" . 42) ("bar" . #t))))
	(parse-json complex-dictionary))
  (test "Complex array"
	#(#() () (("snafu" . (("foo" . 42) ("bar" . #t)))))
	(parse-json complex-array)))
(test-end)
(test-exit)
