.POSIX:

all: build-rust

build-rust:
	mkdir -p ../../bin
	cargo build --release --workspace || true
	find target/release \
		-maxdepth 1 \
		-type f \
		-perm +111 \
		-exec cp {} ../../bin/ \; 2>/dev/null || true
	find . \
		-maxdepth 1 \
		-type f \
		-perm +111 \
		! -name "Makefile" \
		-exec cp {} ../../bin/ \; 2>/dev/null || true

clean:
	cargo clean || true

.PHONY: all build-rust clean
