
LEVEL := Debug

ZIG_VERSION := master
ZIG := /usr/local/lib/zig/lib

install: patch
	npm ci

build: idl patch
	@echo '~ Building zig optimize=$(LEVEL)'
	@zig build -freference-trace -Doptimize=$(LEVEL) -freference-trace
	@echo '~ Extracting debug symbols'
	@./tools/wasm-split-aarch64 zig-out/lib/imgui-webgl.wasm \
		-o web/imgui-webgl.wasm \
		--strip \
		--debug-out=web/imgui-wegbl.debug \
		--external-dwarf-url=http://localhost:7655/webgl.debug
	@echo '~ Building JS'
	@./build.js
	@echo '~ DONE'

release: export LEVEL=ReleaseFast
release: build

src/modules/imgui.zig: libs/cimgui/cimgui.h
	zig translate-c -target wasm32-freestanding-musl -lc -D CIMGUI_DEFINE_ENUMS_AND_STRUCTS=1 libs/cimgui/cimgui.h > src/modules/imgui.zig
	@echo "IMPORTANT!"
	@echo "  remember to replace the generic struct_ImVec2 and struct_ImVec4 in src/modules/imgui.zig"
	@echo "  by  'pub const struct_ImVec2 = zlm.Vec2;'"
	@echo "  and 'pub const struct_ImVec4 = zlm.Vec4;'"

clean:
	rm -rf zig-cache
	rm -rf zig-out

patch:
	# local devcontainer
	@touch /usr/local/lib/zig/lib/libc/include/generic-musl/bits/syscall.h || true


start: build
	./build.js --watch

idl: scripts/idl.ts scripts/gen-idl.ts
	@echo '~ Building IDL'
	@node_modules/.bin/ts-node scripts/idl.ts