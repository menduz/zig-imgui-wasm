pub const gl = @import("../lib/wasm/webgl.zig");

pub const Shader = @import("../lib/engine/shader.zig");
pub const Texture = @import("../lib/engine/texture.zig");
pub const RenderTarget = @import("../lib/engine/renderTarget.zig");
pub const GenerateBuffer = @import("../lib/engine/generateBuffer.zig").GenerateBuffer;
pub const Renderer = @import("../lib/engine/renderer.zig");

pub const math = @import("./zlm.zig");
pub const imgui = @import("./imgui.zig");
