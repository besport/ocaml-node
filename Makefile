include Makefile.conf

################################################################################
CC				= ocamlc
PACKAGES		= -package gen_js_api \
				  -package js_of_ocaml

ML_FILE			= $(patsubst %.mli, %.ml, $(MLI_FILE))
CMI_FILE		= $(patsubst %.mli, %.cmi, $(MLI_FILE))
CMO_FILE		= $(patsubst %.mli, %.cmo, $(MLI_FILE))
CMA_FILE		= $(LIB_NAME).cma
OCAMLFIND_LIB	= $(shell echo $(LIB_NAME) | sed s/_/-/g)
################################################################################

################################################################################
build:
	ocamlfind gen_js_api/gen_js_api $(MLI_FILE)
	ocamlfind $(CC) -c $(PACKAGES) $(MLI_FILE)
	ocamlfind $(CC) -c $(PACKAGES) $(ML_FILE)
	ocamlfind $(CC) -a -o $(CMA_FILE) $(CMO_FILE)

install: build
	ocamlfind install $(OCAMLFIND_LIB) META $(CMA_FILE) $(CMI_FILE)

remove:
	ocamlfind remove $(OCAMLFIND_LIB)

clean:
	$(RM) $(CMI_FILE) $(CMO_FILE) $(ML_FILE) $(CMA_FILE)

re: clean all
################################################################################
