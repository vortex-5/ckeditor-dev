#!/bin/sh
SCRIPT_DIR=$(dirname ${0})
SCRIPT_DIR=$(cd ${SCRIPT_DIR} && pwd)

$SCRIPT_DIR/build.sh -s --leave-js-unminified
	
pushd .	

cd $SCRIPT_DIR/release/ckeditor
	
for f in $(find . -type f -name '*.js')
do
	echo $f
	java -jar "$SCRIPT_DIR/closure-compiler/compiler.jar" --compilation_level WHITESPACE_ONLY --language_in ECMASCRIPT5_STRICT --create_source_map $f.map --js_output_file=$f $f
	#java -jar "$SCRIPT_DIR/closure-compiler/compiler.jar" --compilation_level WHITESPACE_ONLY --language_in ECMASCRIPT5_STRICT --js_output_file=$f $f
done

popd