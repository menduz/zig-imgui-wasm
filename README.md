# Small example of Zig + WASM + CPP + WebGL2

This project compiles cimgui using the zig toolchain, then linkes it with
a thin WebGL2 renderer.

To run it locally, use the `master` zig branch. Then run

```bash
npm install
make build
```

To preview locally, run 

```bash
npm install
make start
```