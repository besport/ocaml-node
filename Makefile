include Makefile.conf

################################################################################
CC				= ocamlc
PACKAGES		= -package gen_js_api \
							-package js_of_ocaml

ML_FILE			= $(patsubst %.mli, %.ml, $(MLI_FILE))
CMI_FILE		= $(patsubst %.mli, %.cmi, $(MLI_FILE))
CMO_FILE		= $(patsubst %.mli, %.cmo, $(MLI_FILE))
CMA_FILE		= $(LIB_NAME).cma
################################################################################

################################################################################
build:
	ocamlfind gen_js_api/gen_js_api $(MLI_FILE)
	ocamlfind $(CC) -c $(PACKAGES) $(MLI_FILE)
	ocamlfind $(CC) -c $(PACKAGES) $(ML_FILE)
	ocamlfind $(CC) -a -o $(CMA_FILE) $(CMO_FILE)

install: build
	ocamlfind install $(LIB_NAME) META $(CMA_FILE) $(CMI_FILE)

remove:
	ocamlfind remove $(LIB_NAME)

clean:
	$(RM) $(CMI_FILE) $(CMO_FILE) $(ML_FILE) $(CMA_FILE)

re: clean all

test:
	ocamlfind ocamlc \
		-o test.byte \
		-package js_of_ocaml,js_of_ocaml.ppx,gen_js_api,ocaml-nightmare,jsoo_lib -linkpkg \
		-no-check-prims \
		test.ml
	js_of_ocaml -o test.js +gen_js_api/ojs_runtime.js test.byte

clean_test:
	$(RM) test.cmo test.cmi test.js test.byte
################################################################################
