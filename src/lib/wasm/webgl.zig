const std = @import("std");

/// WebGL2 bindings.
/// https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext
/// https://developer.mozilla.org/en-US/docs/Web/API/WebGL2RenderingContext
const idl = @import("idl.zig");

// Types
pub const GLbitfield = c_uint;
pub const GLuint = c_uint;
pub const GLenum = c_uint;
pub const GLboolean = c_uint;
pub const GLvoid = c_uint;
pub const GLsizeiptr = c_uint;
pub const GLint = c_int;
pub const GLsizei = c_int;
pub const GLfloat = f32;
pub const GLchar = u8;

// Identifier constants pulled from WebGLRenderingContext
pub const GL_DEPTH_BUFFER_BIT = 0x00000100;
pub const GL_STENCIL_BUFFER_BIT = 0x00000400;
pub const GL_COLOR_BUFFER_BIT = 0x00004000;
pub const GL_FALSE = 0;
pub const GL_TRUE = 1;
pub const GL_POINTS = 0x0000;
pub const GL_LINES = 0x0001;
pub const GL_LINE_LOOP = 0x0002;
pub const GL_LINE_STRIP = 0x0003;
pub const GL_TRIANGLES = 0x0004;
pub const GL_TRIANGLE_STRIP = 0x0005;
pub const GL_TRIANGLE_FAN = 0x0006;
pub const GL_ZERO = 0;
pub const GL_ONE = 1;
pub const GL_SRC_COLOR = 0x0300;
pub const GL_ONE_MINUS_SRC_COLOR = 0x0301;
pub const GL_SRC_ALPHA = 0x0302;
pub const GL_ONE_MINUS_SRC_ALPHA = 0x0303;
pub const GL_DST_ALPHA = 0x0304;
pub const GL_ONE_MINUS_DST_ALPHA = 0x0305;
pub const GL_DST_COLOR = 0x0306;
pub const GL_ONE_MINUS_DST_COLOR = 0x0307;
pub const GL_SRC_ALPHA_SATURATE = 0x0308;
pub const GL_FUNC_ADD = 0x8006;
pub const GL_BLEND_EQUATION = 0x8009;
pub const GL_BLEND_EQUATION_RGB = 0x8009;
pub const GL_BLEND_EQUATION_ALPHA = 0x883D;
pub const GL_FUNC_SUBTRACT = 0x800A;
pub const GL_FUNC_REVERSE_SUBTRACT = 0x800B;
pub const GL_BLEND_DST_RGB = 0x80C8;
pub const GL_BLEND_SRC_RGB = 0x80C9;
pub const GL_BLEND_DST_ALPHA = 0x80CA;
pub const GL_BLEND_SRC_ALPHA = 0x80CB;
pub const GL_CONSTANT_COLOR = 0x8001;
pub const GL_ONE_MINUS_CONSTANT_COLOR = 0x8002;
pub const GL_CONSTANT_ALPHA = 0x8003;
pub const GL_ONE_MINUS_CONSTANT_ALPHA = 0x8004;
pub const GL_BLEND_COLOR = 0x8005;
pub const GL_ARRAY_BUFFER = 0x8892;
pub const GL_ELEMENT_ARRAY_BUFFER = 0x8893;
pub const GL_ARRAY_BUFFER_BINDING = 0x8894;
pub const GL_ELEMENT_ARRAY_BUFFER_BINDING = 0x8895;
pub const GL_STREAM_DRAW = 0x88E0;
pub const GL_STATIC_DRAW = 0x88E4;
pub const GL_DYNAMIC_DRAW = 0x88E8;
pub const GL_BUFFER_SIZE = 0x8764;
pub const GL_BUFFER_USAGE = 0x8765;
pub const GL_CURRENT_VERTEX_ATTRIB = 0x8626;
pub const GL_FRONT = 0x0404;
pub const GL_BACK = 0x0405;
pub const GL_FRONT_AND_BACK = 0x0408;
pub const GL_TEXTURE_2D = 0x0DE1;
pub const GL_CULL_FACE = 0x0B44;
pub const GL_BLEND = 0x0BE2;
pub const GL_DITHER = 0x0BD0;
pub const GL_STENCIL_TEST = 0x0B90;
pub const GL_DEPTH_TEST = 0x0B71;
pub const GL_SCISSOR_TEST = 0x0C11;
pub const GL_POLYGON_OFFSET_FILL = 0x8037;
pub const GL_SAMPLE_ALPHA_TO_COVERAGE = 0x809E;
pub const GL_SAMPLE_COVERAGE = 0x80A0;
pub const GL_NO_ERROR = 0;
pub const GL_INVALID_ENUM = 0x0500;
pub const GL_INVALID_VALUE = 0x0501;
pub const GL_INVALID_OPERATION = 0x0502;
pub const GL_OUT_OF_MEMORY = 0x0505;
pub const GL_CW = 0x0900;
pub const GL_CCW = 0x0901;
pub const GL_LINE_WIDTH = 0x0B21;
pub const GL_ALIASED_POINT_SIZE_RANGE = 0x846D;
pub const GL_ALIASED_LINE_WIDTH_RANGE = 0x846E;
pub const GL_CULL_FACE_MODE = 0x0B45;
pub const GL_FRONT_FACE = 0x0B46;
pub const GL_DEPTH_RANGE = 0x0B70;
pub const GL_DEPTH_WRITEMASK = 0x0B72;
pub const GL_DEPTH_CLEAR_VALUE = 0x0B73;
pub const GL_DEPTH_FUNC = 0x0B74;
pub const GL_STENCIL_CLEAR_VALUE = 0x0B91;
pub const GL_STENCIL_FUNC = 0x0B92;
pub const GL_STENCIL_FAIL = 0x0B94;
pub const GL_STENCIL_PASS_DEPTH_FAIL = 0x0B95;
pub const GL_STENCIL_PASS_DEPTH_PASS = 0x0B96;
pub const GL_STENCIL_REF = 0x0B97;
pub const GL_STENCIL_VALUE_MASK = 0x0B93;
pub const GL_STENCIL_WRITEMASK = 0x0B98;
pub const GL_STENCIL_BACK_FUNC = 0x8800;
pub const GL_STENCIL_BACK_FAIL = 0x8801;
pub const GL_STENCIL_BACK_PASS_DEPTH_FAIL = 0x8802;
pub const GL_STENCIL_BACK_PASS_DEPTH_PASS = 0x8803;
pub const GL_STENCIL_BACK_REF = 0x8CA3;
pub const GL_STENCIL_BACK_VALUE_MASK = 0x8CA4;
pub const GL_STENCIL_BACK_WRITEMASK = 0x8CA5;
pub const GL_VIEWPORT = 0x0BA2;
pub const GL_SCISSOR_BOX = 0x0C10;
pub const GL_COLOR_CLEAR_VALUE = 0x0C22;
pub const GL_COLOR_WRITEMASK = 0x0C23;
pub const GL_UNPACK_ALIGNMENT = 0x0CF5;
pub const GL_PACK_ALIGNMENT = 0x0D05;
pub const GL_MAX_TEXTURE_SIZE = 0x0D33;
pub const GL_MAX_VIEWPORT_DIMS = 0x0D3A;
pub const GL_SUBPIXEL_BITS = 0x0D50;
pub const GL_RED_BITS = 0x0D52;
pub const GL_GREEN_BITS = 0x0D53;
pub const GL_BLUE_BITS = 0x0D54;
pub const GL_ALPHA_BITS = 0x0D55;
pub const GL_DEPTH_BITS = 0x0D56;
pub const GL_STENCIL_BITS = 0x0D57;
pub const GL_POLYGON_OFFSET_UNITS = 0x2A00;
pub const GL_POLYGON_OFFSET_FACTOR = 0x8038;
pub const GL_TEXTURE_BINDING_2D = 0x8069;
pub const GL_SAMPLE_BUFFERS = 0x80A8;
pub const GL_SAMPLES = 0x80A9;
pub const GL_SAMPLE_COVERAGE_VALUE = 0x80AA;
pub const GL_SAMPLE_COVERAGE_INVERT = 0x80AB;
pub const GL_NUM_COMPRESSED_TEXTURE_FORMATS = 0x86A2;
pub const GL_COMPRESSED_TEXTURE_FORMATS = 0x86A3;
pub const GL_DONT_CARE = 0x1100;
pub const GL_FASTEST = 0x1101;
pub const GL_NICEST = 0x1102;
pub const GL_GENERATE_MIPMAP_HINT = 0x8192;
pub const GL_BYTE = 0x1400;
pub const GL_UNSIGNED_BYTE = 0x1401;
pub const GL_SHORT = 0x1402;
pub const GL_UNSIGNED_SHORT = 0x1403;
pub const GL_INT = 0x1404;
pub const GL_UNSIGNED_INT = 0x1405;
pub const GL_FLOAT = 0x1406;
pub const GL_FIXED = 0x140C;
pub const GL_DEPTH_COMPONENT = 0x1902;
pub const GL_ALPHA = 0x1906;
pub const GL_RGB = 0x1907;
pub const GL_RGBA = 0x1908;
pub const GL_LUMINANCE = 0x1909;
pub const GL_LUMINANCE_ALPHA = 0x190A;
pub const GL_UNSIGNED_SHORT_4_4_4_4 = 0x8033;
pub const GL_UNSIGNED_SHORT_5_5_5_1 = 0x8034;
pub const GL_UNSIGNED_SHORT_5_6_5 = 0x8363;
pub const GL_FRAGMENT_SHADER = 0x8B30;
pub const GL_VERTEX_SHADER = 0x8B31;
pub const GL_MAX_VERTEX_ATTRIBS = 0x8869;
pub const GL_MAX_VERTEX_UNIFORM_VECTORS = 0x8DFB;
pub const GL_MAX_VARYING_VECTORS = 0x8DFC;
pub const GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS = 0x8B4D;
pub const GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS = 0x8B4C;
pub const GL_MAX_TEXTURE_IMAGE_UNITS = 0x8872;
pub const GL_MAX_FRAGMENT_UNIFORM_VECTORS = 0x8DFD;
pub const GL_SHADER_TYPE = 0x8B4F;
pub const GL_DELETE_STATUS = 0x8B80;
pub const GL_LINK_STATUS = 0x8B82;
pub const GL_VALIDATE_STATUS = 0x8B83;
pub const GL_ATTACHED_SHADERS = 0x8B85;
pub const GL_ACTIVE_UNIFORMS = 0x8B86;
pub const GL_ACTIVE_UNIFORM_MAX_LENGTH = 0x8B87;
pub const GL_ACTIVE_ATTRIBUTES = 0x8B89;
pub const GL_ACTIVE_ATTRIBUTE_MAX_LENGTH = 0x8B8A;
pub const GL_SHADING_LANGUAGE_VERSION = 0x8B8C;
pub const GL_CURRENT_PROGRAM = 0x8B8D;
pub const GL_NEVER = 0x0200;
pub const GL_LESS = 0x0201;
pub const GL_EQUAL = 0x0202;
pub const GL_LEQUAL = 0x0203;
pub const GL_GREATER = 0x0204;
pub const GL_NOTEQUAL = 0x0205;
pub const GL_GEQUAL = 0x0206;
pub const GL_ALWAYS = 0x0207;
pub const GL_KEEP = 0x1E00;
pub const GL_REPLACE = 0x1E01;
pub const GL_INCR = 0x1E02;
pub const GL_DECR = 0x1E03;
pub const GL_INVERT = 0x150A;
pub const GL_INCR_WRAP = 0x8507;
pub const GL_DECR_WRAP = 0x8508;
pub const GL_VENDOR = 0x1F00;
pub const GL_RENDERER = 0x1F01;
pub const GL_VERSION = 0x1F02;
pub const GL_EXTENSIONS = 0x1F03;
pub const GL_NEAREST = 0x2600;
pub const GL_LINEAR = 0x2601;
pub const GL_NEAREST_MIPMAP_NEAREST = 0x2700;
pub const GL_LINEAR_MIPMAP_NEAREST = 0x2701;
pub const GL_NEAREST_MIPMAP_LINEAR = 0x2702;
pub const GL_LINEAR_MIPMAP_LINEAR = 0x2703;
pub const GL_TEXTURE_MAG_FILTER = 0x2800;
pub const GL_TEXTURE_MIN_FILTER = 0x2801;
pub const GL_TEXTURE_WRAP_S = 0x2802;
pub const GL_TEXTURE_WRAP_T = 0x2803;
pub const GL_TEXTURE = 0x1702;
pub const GL_TEXTURE_CUBE_MAP = 0x8513;
pub const GL_TEXTURE_BINDING_CUBE_MAP = 0x8514;
pub const GL_TEXTURE_CUBE_MAP_POSITIVE_X = 0x8515;
pub const GL_TEXTURE_CUBE_MAP_NEGATIVE_X = 0x8516;
pub const GL_TEXTURE_CUBE_MAP_POSITIVE_Y = 0x8517;
pub const GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = 0x8518;
pub const GL_TEXTURE_CUBE_MAP_POSITIVE_Z = 0x8519;
pub const GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = 0x851A;
pub const GL_MAX_CUBE_MAP_TEXTURE_SIZE = 0x851C;
pub const GL_TEXTURE0 = 0x84C0;
pub const GL_TEXTURE1 = 0x84C1;
pub const GL_TEXTURE2 = 0x84C2;
pub const GL_TEXTURE3 = 0x84C3;
pub const GL_TEXTURE4 = 0x84C4;
pub const GL_TEXTURE5 = 0x84C5;
pub const GL_TEXTURE6 = 0x84C6;
pub const GL_TEXTURE7 = 0x84C7;
pub const GL_TEXTURE8 = 0x84C8;
pub const GL_TEXTURE9 = 0x84C9;
pub const GL_TEXTURE10 = 0x84CA;
pub const GL_TEXTURE11 = 0x84CB;
pub const GL_TEXTURE12 = 0x84CC;
pub const GL_TEXTURE13 = 0x84CD;
pub const GL_TEXTURE14 = 0x84CE;
pub const GL_TEXTURE15 = 0x84CF;
pub const GL_TEXTURE16 = 0x84D0;
pub const GL_TEXTURE17 = 0x84D1;
pub const GL_TEXTURE18 = 0x84D2;
pub const GL_TEXTURE19 = 0x84D3;
pub const GL_TEXTURE20 = 0x84D4;
pub const GL_TEXTURE21 = 0x84D5;
pub const GL_TEXTURE22 = 0x84D6;
pub const GL_TEXTURE23 = 0x84D7;
pub const GL_TEXTURE24 = 0x84D8;
pub const GL_TEXTURE25 = 0x84D9;
pub const GL_TEXTURE26 = 0x84DA;
pub const GL_TEXTURE27 = 0x84DB;
pub const GL_TEXTURE28 = 0x84DC;
pub const GL_TEXTURE29 = 0x84DD;
pub const GL_TEXTURE30 = 0x84DE;
pub const GL_TEXTURE31 = 0x84DF;
pub const GL_ACTIVE_TEXTURE = 0x84E0;
pub const GL_REPEAT = 0x2901;
pub const GL_CLAMP_TO_EDGE = 0x812F;
pub const GL_MIRRORED_REPEAT = 0x8370;
pub const GL_FLOAT_VEC2 = 0x8B50;
pub const GL_FLOAT_VEC3 = 0x8B51;
pub const GL_FLOAT_VEC4 = 0x8B52;
pub const GL_INT_VEC2 = 0x8B53;
pub const GL_INT_VEC3 = 0x8B54;
pub const GL_INT_VEC4 = 0x8B55;
pub const GL_BOOL = 0x8B56;
pub const GL_BOOL_VEC2 = 0x8B57;
pub const GL_BOOL_VEC3 = 0x8B58;
pub const GL_BOOL_VEC4 = 0x8B59;
pub const GL_FLOAT_MAT2 = 0x8B5A;
pub const GL_FLOAT_MAT3 = 0x8B5B;
pub const GL_FLOAT_MAT4 = 0x8B5C;
pub const GL_SAMPLER_2D = 0x8B5E;
pub const GL_SAMPLER_CUBE = 0x8B60;
pub const GL_VERTEX_ATTRIB_ARRAY_ENABLED = 0x8622;
pub const GL_VERTEX_ATTRIB_ARRAY_SIZE = 0x8623;
pub const GL_VERTEX_ATTRIB_ARRAY_STRIDE = 0x8624;
pub const GL_VERTEX_ATTRIB_ARRAY_TYPE = 0x8625;
pub const GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = 0x886A;
pub const GL_VERTEX_ATTRIB_ARRAY_POINTER = 0x8645;
pub const GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 0x889F;
pub const GL_IMPLEMENTATION_COLOR_READ_TYPE = 0x8B9A;
pub const GL_IMPLEMENTATION_COLOR_READ_FORMAT = 0x8B9B;
pub const GL_COMPILE_STATUS = 0x8B81;
pub const GL_INFO_LOG_LENGTH = 0x8B84;
pub const GL_SHADER_SOURCE_LENGTH = 0x8B88;
pub const GL_SHADER_COMPILER = 0x8DFA;
pub const GL_SHADER_BINARY_FORMATS = 0x8DF8;
pub const GL_NUM_SHADER_BINARY_FORMATS = 0x8DF9;
pub const GL_LOW_FLOAT = 0x8DF0;
pub const GL_MEDIUM_FLOAT = 0x8DF1;
pub const GL_HIGH_FLOAT = 0x8DF2;
pub const GL_LOW_INT = 0x8DF3;
pub const GL_MEDIUM_INT = 0x8DF4;
pub const GL_HIGH_INT = 0x8DF5;
pub const GL_FRAMEBUFFER = 0x8D40;
pub const GL_RENDERBUFFER = 0x8D41;
pub const GL_RGBA4 = 0x8056;
pub const GL_RGB5_A1 = 0x8057;
pub const GL_RGB565 = 0x8D62;
pub const GL_DEPTH_COMPONENT16 = 0x81A5;
pub const GL_STENCIL_INDEX8 = 0x8D48;
pub const GL_RENDERBUFFER_WIDTH = 0x8D42;
pub const GL_RENDERBUFFER_HEIGHT = 0x8D43;
pub const GL_RENDERBUFFER_INTERNAL_FORMAT = 0x8D44;
pub const GL_RENDERBUFFER_RED_SIZE = 0x8D50;
pub const GL_RENDERBUFFER_GREEN_SIZE = 0x8D51;
pub const GL_RENDERBUFFER_BLUE_SIZE = 0x8D52;
pub const GL_RENDERBUFFER_ALPHA_SIZE = 0x8D53;
pub const GL_RENDERBUFFER_DEPTH_SIZE = 0x8D54;
pub const GL_RENDERBUFFER_STENCIL_SIZE = 0x8D55;
pub const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = 0x8CD0;
pub const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = 0x8CD1;
pub const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = 0x8CD2;
pub const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 0x8CD3;
pub const GL_COLOR_ATTACHMENT0 = 0x8CE0;
pub const GL_DEPTH_ATTACHMENT = 0x8D00;
pub const GL_STENCIL_ATTACHMENT = 0x8D20;
pub const GL_NONE = 0;
pub const GL_FRAMEBUFFER_COMPLETE = 0x8CD5;
pub const GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT = 0x8CD6;
pub const GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 0x8CD7;
pub const GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS = 0x8CD9;
pub const GL_FRAMEBUFFER_UNSUPPORTED = 0x8CDD;
pub const GL_FRAMEBUFFER_BINDING = 0x8CA6;
pub const GL_RENDERBUFFER_BINDING = 0x8CA7;
pub const GL_MAX_RENDERBUFFER_SIZE = 0x84E8;
pub const GL_INVALID_FRAMEBUFFER_OPERATION = 0x0506;
pub const GL_READ_BUFFER = 0x0C02;
pub const GL_UNPACK_ROW_LENGTH = 0x0CF2;
pub const GL_UNPACK_SKIP_ROWS = 0x0CF3;
pub const GL_UNPACK_SKIP_PIXELS = 0x0CF4;
pub const GL_PACK_ROW_LENGTH = 0x0D02;
pub const GL_PACK_SKIP_ROWS = 0x0D03;
pub const GL_PACK_SKIP_PIXELS = 0x0D04;
pub const GL_COLOR = 0x1800;
pub const GL_DEPTH = 0x1801;
pub const GL_STENCIL = 0x1802;
pub const GL_RED = 0x1903;
pub const GL_RGB8 = 0x8051;
pub const GL_RGBA8 = 0x8058;
pub const GL_RGB10_A2 = 0x8059;
pub const GL_TEXTURE_BINDING_3D = 0x806A;
pub const GL_UNPACK_SKIP_IMAGES = 0x806D;
pub const GL_UNPACK_IMAGE_HEIGHT = 0x806E;
pub const GL_TEXTURE_3D = 0x806F;
pub const GL_TEXTURE_WRAP_R = 0x8072;
pub const GL_MAX_3D_TEXTURE_SIZE = 0x8073;
pub const GL_UNSIGNED_INT_2_10_10_10_REV = 0x8368;
pub const GL_MAX_ELEMENTS_VERTICES = 0x80E8;
pub const GL_MAX_ELEMENTS_INDICES = 0x80E9;
pub const GL_TEXTURE_MIN_LOD = 0x813A;
pub const GL_TEXTURE_MAX_LOD = 0x813B;
pub const GL_TEXTURE_BASE_LEVEL = 0x813C;
pub const GL_TEXTURE_MAX_LEVEL = 0x813D;
pub const GL_MIN = 0x8007;
pub const GL_MAX = 0x8008;
pub const GL_DEPTH_COMPONENT24 = 0x81A6;
pub const GL_MAX_TEXTURE_LOD_BIAS = 0x84FD;
pub const GL_TEXTURE_COMPARE_MODE = 0x884C;
pub const GL_TEXTURE_COMPARE_FUNC = 0x884D;
pub const GL_CURRENT_QUERY = 0x8865;
pub const GL_QUERY_RESULT = 0x8866;
pub const GL_QUERY_RESULT_AVAILABLE = 0x8867;
pub const GL_BUFFER_MAPPED = 0x88BC;
pub const GL_BUFFER_MAP_POINTER = 0x88BD;
pub const GL_STREAM_READ = 0x88E1;
pub const GL_STREAM_COPY = 0x88E2;
pub const GL_STATIC_READ = 0x88E5;
pub const GL_STATIC_COPY = 0x88E6;
pub const GL_DYNAMIC_READ = 0x88E9;
pub const GL_DYNAMIC_COPY = 0x88EA;
pub const GL_MAX_DRAW_BUFFERS = 0x8824;
pub const GL_DRAW_BUFFER0 = 0x8825;
pub const GL_DRAW_BUFFER1 = 0x8826;
pub const GL_DRAW_BUFFER2 = 0x8827;
pub const GL_DRAW_BUFFER3 = 0x8828;
pub const GL_DRAW_BUFFER4 = 0x8829;
pub const GL_DRAW_BUFFER5 = 0x882A;
pub const GL_DRAW_BUFFER6 = 0x882B;
pub const GL_DRAW_BUFFER7 = 0x882C;
pub const GL_DRAW_BUFFER8 = 0x882D;
pub const GL_DRAW_BUFFER9 = 0x882E;
pub const GL_DRAW_BUFFER10 = 0x882F;
pub const GL_DRAW_BUFFER11 = 0x8830;
pub const GL_DRAW_BUFFER12 = 0x8831;
pub const GL_DRAW_BUFFER13 = 0x8832;
pub const GL_DRAW_BUFFER14 = 0x8833;
pub const GL_DRAW_BUFFER15 = 0x8834;
pub const GL_MAX_FRAGMENT_UNIFORM_COMPONENTS = 0x8B49;
pub const GL_MAX_VERTEX_UNIFORM_COMPONENTS = 0x8B4A;
pub const GL_SAMPLER_3D = 0x8B5F;
pub const GL_SAMPLER_2D_SHADOW = 0x8B62;
pub const GL_FRAGMENT_SHADER_DERIVATIVE_HINT = 0x8B8B;
pub const GL_PIXEL_PACK_BUFFER = 0x88EB;
pub const GL_PIXEL_UNPACK_BUFFER = 0x88EC;
pub const GL_PIXEL_PACK_BUFFER_BINDING = 0x88ED;
pub const GL_PIXEL_UNPACK_BUFFER_BINDING = 0x88EF;
pub const GL_FLOAT_MAT2x3 = 0x8B65;
pub const GL_FLOAT_MAT2x4 = 0x8B66;
pub const GL_FLOAT_MAT3x2 = 0x8B67;
pub const GL_FLOAT_MAT3x4 = 0x8B68;
pub const GL_FLOAT_MAT4x2 = 0x8B69;
pub const GL_FLOAT_MAT4x3 = 0x8B6A;
pub const GL_SRGB = 0x8C40;
pub const GL_SRGB8 = 0x8C41;
pub const GL_SRGB8_ALPHA8 = 0x8C43;
pub const GL_COMPARE_REF_TO_TEXTURE = 0x884E;
pub const GL_MAJOR_VERSION = 0x821B;
pub const GL_MINOR_VERSION = 0x821C;
pub const GL_NUM_EXTENSIONS = 0x821D;
pub const GL_RGBA32F = 0x8814;
pub const GL_RGB32F = 0x8815;
pub const GL_RGBA16F = 0x881A;
pub const GL_RGB16F = 0x881B;
pub const GL_VERTEX_ATTRIB_ARRAY_INTEGER = 0x88FD;
pub const GL_MAX_ARRAY_TEXTURE_LAYERS = 0x88FF;
pub const GL_MIN_PROGRAM_TEXEL_OFFSET = 0x8904;
pub const GL_MAX_PROGRAM_TEXEL_OFFSET = 0x8905;
pub const GL_MAX_VARYING_COMPONENTS = 0x8B4B;
pub const GL_TEXTURE_2D_ARRAY = 0x8C1A;
pub const GL_TEXTURE_BINDING_2D_ARRAY = 0x8C1D;
pub const GL_R11F_G11F_B10F = 0x8C3A;
pub const GL_UNSIGNED_INT_10F_11F_11F_REV = 0x8C3B;
pub const GL_RGB9_E5 = 0x8C3D;
pub const GL_UNSIGNED_INT_5_9_9_9_REV = 0x8C3E;
pub const GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = 0x8C76;
pub const GL_TRANSFORM_FEEDBACK_BUFFER_MODE = 0x8C7F;
pub const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = 0x8C80;
pub const GL_TRANSFORM_FEEDBACK_VARYINGS = 0x8C83;
pub const GL_TRANSFORM_FEEDBACK_BUFFER_START = 0x8C84;
pub const GL_TRANSFORM_FEEDBACK_BUFFER_SIZE = 0x8C85;
pub const GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = 0x8C88;
pub const GL_RASTERIZER_DISCARD = 0x8C89;
pub const GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = 0x8C8A;
pub const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = 0x8C8B;
pub const GL_INTERLEAVED_ATTRIBS = 0x8C8C;
pub const GL_SEPARATE_ATTRIBS = 0x8C8D;
pub const GL_TRANSFORM_FEEDBACK_BUFFER = 0x8C8E;
pub const GL_TRANSFORM_FEEDBACK_BUFFER_BINDING = 0x8C8F;
pub const GL_RGBA32UI = 0x8D70;
pub const GL_RGB32UI = 0x8D71;
pub const GL_RGBA16UI = 0x8D76;
pub const GL_RGB16UI = 0x8D77;
pub const GL_RGBA8UI = 0x8D7C;
pub const GL_RGB8UI = 0x8D7D;
pub const GL_RGBA32I = 0x8D82;
pub const GL_RGB32I = 0x8D83;
pub const GL_RGBA16I = 0x8D88;
pub const GL_RGB16I = 0x8D89;
pub const GL_RGBA8I = 0x8D8E;
pub const GL_RGB8I = 0x8D8F;
pub const GL_RED_INTEGER = 0x8D94;
pub const GL_RGB_INTEGER = 0x8D98;
pub const GL_RGBA_INTEGER = 0x8D99;
pub const GL_SAMPLER_2D_ARRAY = 0x8DC1;
pub const GL_SAMPLER_2D_ARRAY_SHADOW = 0x8DC4;
pub const GL_SAMPLER_CUBE_SHADOW = 0x8DC5;
pub const GL_UNSIGNED_INT_VEC2 = 0x8DC6;
pub const GL_UNSIGNED_INT_VEC3 = 0x8DC7;
pub const GL_UNSIGNED_INT_VEC4 = 0x8DC8;
pub const GL_INT_SAMPLER_2D = 0x8DCA;
pub const GL_INT_SAMPLER_3D = 0x8DCB;
pub const GL_INT_SAMPLER_CUBE = 0x8DCC;
pub const GL_INT_SAMPLER_2D_ARRAY = 0x8DCF;
pub const GL_UNSIGNED_INT_SAMPLER_2D = 0x8DD2;
pub const GL_UNSIGNED_INT_SAMPLER_3D = 0x8DD3;
pub const GL_UNSIGNED_INT_SAMPLER_CUBE = 0x8DD4;
pub const GL_UNSIGNED_INT_SAMPLER_2D_ARRAY = 0x8DD7;
pub const GL_BUFFER_ACCESS_FLAGS = 0x911F;
pub const GL_BUFFER_MAP_LENGTH = 0x9120;
pub const GL_BUFFER_MAP_OFFSET = 0x9121;
pub const GL_DEPTH_COMPONENT32F = 0x8CAC;
pub const GL_DEPTH32F_STENCIL8 = 0x8CAD;
pub const GL_FLOAT_32_UNSIGNED_INT_24_8_REV = 0x8DAD;
pub const GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = 0x8210;
pub const GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = 0x8211;
pub const GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE = 0x8212;
pub const GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = 0x8213;
pub const GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = 0x8214;
pub const GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = 0x8215;
pub const GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = 0x8216;
pub const GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = 0x8217;
pub const GL_FRAMEBUFFER_DEFAULT = 0x8218;
pub const GL_FRAMEBUFFER_UNDEFINED = 0x8219;
pub const GL_DEPTH_STENCIL_ATTACHMENT = 0x821A;
pub const GL_DEPTH_STENCIL = 0x84F9;
pub const GL_UNSIGNED_INT_24_8 = 0x84FA;
pub const GL_DEPTH24_STENCIL8 = 0x88F0;
pub const GL_UNSIGNED_NORMALIZED = 0x8C17;
pub const GL_DRAW_FRAMEBUFFER_BINDING = 0x8CA6;
pub const GL_READ_FRAMEBUFFER = 0x8CA8;
pub const GL_DRAW_FRAMEBUFFER = 0x8CA9;
pub const GL_READ_FRAMEBUFFER_BINDING = 0x8CAA;
pub const GL_RENDERBUFFER_SAMPLES = 0x8CAB;
pub const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = 0x8CD4;
pub const GL_MAX_COLOR_ATTACHMENTS = 0x8CDF;
pub const GL_COLOR_ATTACHMENT1 = 0x8CE1;
pub const GL_COLOR_ATTACHMENT2 = 0x8CE2;
pub const GL_COLOR_ATTACHMENT3 = 0x8CE3;
pub const GL_COLOR_ATTACHMENT4 = 0x8CE4;
pub const GL_COLOR_ATTACHMENT5 = 0x8CE5;
pub const GL_COLOR_ATTACHMENT6 = 0x8CE6;
pub const GL_COLOR_ATTACHMENT7 = 0x8CE7;
pub const GL_COLOR_ATTACHMENT8 = 0x8CE8;
pub const GL_COLOR_ATTACHMENT9 = 0x8CE9;
pub const GL_COLOR_ATTACHMENT10 = 0x8CEA;
pub const GL_COLOR_ATTACHMENT11 = 0x8CEB;
pub const GL_COLOR_ATTACHMENT12 = 0x8CEC;
pub const GL_COLOR_ATTACHMENT13 = 0x8CED;
pub const GL_COLOR_ATTACHMENT14 = 0x8CEE;
pub const GL_COLOR_ATTACHMENT15 = 0x8CEF;
pub const GL_COLOR_ATTACHMENT16 = 0x8CF0;
pub const GL_COLOR_ATTACHMENT17 = 0x8CF1;
pub const GL_COLOR_ATTACHMENT18 = 0x8CF2;
pub const GL_COLOR_ATTACHMENT19 = 0x8CF3;
pub const GL_COLOR_ATTACHMENT20 = 0x8CF4;
pub const GL_COLOR_ATTACHMENT21 = 0x8CF5;
pub const GL_COLOR_ATTACHMENT22 = 0x8CF6;
pub const GL_COLOR_ATTACHMENT23 = 0x8CF7;
pub const GL_COLOR_ATTACHMENT24 = 0x8CF8;
pub const GL_COLOR_ATTACHMENT25 = 0x8CF9;
pub const GL_COLOR_ATTACHMENT26 = 0x8CFA;
pub const GL_COLOR_ATTACHMENT27 = 0x8CFB;
pub const GL_COLOR_ATTACHMENT28 = 0x8CFC;
pub const GL_COLOR_ATTACHMENT29 = 0x8CFD;
pub const GL_COLOR_ATTACHMENT30 = 0x8CFE;
pub const GL_COLOR_ATTACHMENT31 = 0x8CFF;
pub const GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = 0x8D56;
pub const GL_MAX_SAMPLES = 0x8D57;
pub const GL_HALF_FLOAT = 0x140B;
pub const GL_MAP_READ_BIT = 0x0001;
pub const GL_MAP_WRITE_BIT = 0x0002;
pub const GL_MAP_INVALIDATE_RANGE_BIT = 0x0004;
pub const GL_MAP_INVALIDATE_BUFFER_BIT = 0x0008;
pub const GL_MAP_FLUSH_EXPLICIT_BIT = 0x0010;
pub const GL_MAP_UNSYNCHRONIZED_BIT = 0x0020;
pub const GL_RG = 0x8227;
pub const GL_RG_INTEGER = 0x8228;
pub const GL_R8 = 0x8229;
pub const GL_RG8 = 0x822B;
pub const GL_R16F = 0x822D;
pub const GL_R32F = 0x822E;
pub const GL_RG16F = 0x822F;
pub const GL_RG32F = 0x8230;
pub const GL_R8I = 0x8231;
pub const GL_R8UI = 0x8232;
pub const GL_R16I = 0x8233;
pub const GL_R16UI = 0x8234;
pub const GL_R32I = 0x8235;
pub const GL_R32UI = 0x8236;
pub const GL_RG8I = 0x8237;
pub const GL_RG8UI = 0x8238;
pub const GL_RG16I = 0x8239;
pub const GL_RG16UI = 0x823A;
pub const GL_RG32I = 0x823B;
pub const GL_RG32UI = 0x823C;
pub const GL_VERTEX_ARRAY_BINDING = 0x85B5;
pub const GL_R8_SNORM = 0x8F94;
pub const GL_RG8_SNORM = 0x8F95;
pub const GL_RGB8_SNORM = 0x8F96;
pub const GL_RGBA8_SNORM = 0x8F97;
pub const GL_SIGNED_NORMALIZED = 0x8F9C;
pub const GL_PRIMITIVE_RESTART_FIXED_INDEX = 0x8D69;
pub const GL_COPY_READ_BUFFER = 0x8F36;
pub const GL_COPY_WRITE_BUFFER = 0x8F37;
pub const GL_COPY_READ_BUFFER_BINDING = 0x8F36;
pub const GL_COPY_WRITE_BUFFER_BINDING = 0x8F37;
pub const GL_UNIFORM_BUFFER = 0x8A11;
pub const GL_UNIFORM_BUFFER_BINDING = 0x8A28;
pub const GL_UNIFORM_BUFFER_START = 0x8A29;
pub const GL_UNIFORM_BUFFER_SIZE = 0x8A2A;
pub const GL_MAX_VERTEX_UNIFORM_BLOCKS = 0x8A2B;
pub const GL_MAX_FRAGMENT_UNIFORM_BLOCKS = 0x8A2D;
pub const GL_MAX_COMBINED_UNIFORM_BLOCKS = 0x8A2E;
pub const GL_MAX_UNIFORM_BUFFER_BINDINGS = 0x8A2F;
pub const GL_MAX_UNIFORM_BLOCK_SIZE = 0x8A30;
pub const GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = 0x8A31;
pub const GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = 0x8A33;
pub const GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT = 0x8A34;
pub const GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = 0x8A35;
pub const GL_ACTIVE_UNIFORM_BLOCKS = 0x8A36;
pub const GL_UNIFORM_TYPE = 0x8A37;
pub const GL_UNIFORM_SIZE = 0x8A38;
pub const GL_UNIFORM_NAME_LENGTH = 0x8A39;
pub const GL_UNIFORM_BLOCK_INDEX = 0x8A3A;
pub const GL_UNIFORM_OFFSET = 0x8A3B;
pub const GL_UNIFORM_ARRAY_STRIDE = 0x8A3C;
pub const GL_UNIFORM_MATRIX_STRIDE = 0x8A3D;
pub const GL_UNIFORM_IS_ROW_MAJOR = 0x8A3E;
pub const GL_UNIFORM_BLOCK_BINDING = 0x8A3F;
pub const GL_UNIFORM_BLOCK_DATA_SIZE = 0x8A40;
pub const GL_UNIFORM_BLOCK_NAME_LENGTH = 0x8A41;
pub const GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS = 0x8A42;
pub const GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = 0x8A43;
pub const GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = 0x8A44;
pub const GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = 0x8A46;
pub const GL_INVALID_INDEX = 0xFFFFFFFF;
pub const GL_MAX_VERTEX_OUTPUT_COMPONENTS = 0x9122;
pub const GL_MAX_FRAGMENT_INPUT_COMPONENTS = 0x9125;
pub const GL_MAX_SERVER_WAIT_TIMEOUT = 0x9111;
pub const GL_OBJECT_TYPE = 0x9112;
pub const GL_SYNC_CONDITION = 0x9113;
pub const GL_SYNC_STATUS = 0x9114;
pub const GL_SYNC_FLAGS = 0x9115;
pub const GL_SYNC_FENCE = 0x9116;
pub const GL_SYNC_GPU_COMMANDS_COMPLETE = 0x9117;
pub const GL_UNSIGNALED = 0x9118;
pub const GL_SIGNALED = 0x9119;
pub const GL_ALREADY_SIGNALED = 0x911A;
pub const GL_TIMEOUT_EXPIRED = 0x911B;
pub const GL_CONDITION_SATISFIED = 0x911C;
pub const GL_WAIT_FAILED = 0x911D;
pub const GL_SYNC_FLUSH_COMMANDS_BIT = 0x00000001;
pub const GL_TIMEOUT_IGNORED = 0xFFFFFFFFFFFFFFFF;
pub const GL_VERTEX_ATTRIB_ARRAY_DIVISOR = 0x88FE;
pub const GL_ANY_SAMPLES_PASSED = 0x8C2F;
pub const GL_ANY_SAMPLES_PASSED_CONSERVATIVE = 0x8D6A;
pub const GL_SAMPLER_BINDING = 0x8919;
pub const GL_RGB10_A2UI = 0x906F;
pub const GL_TEXTURE_SWIZZLE_R = 0x8E42;
pub const GL_TEXTURE_SWIZZLE_G = 0x8E43;
pub const GL_TEXTURE_SWIZZLE_B = 0x8E44;
pub const GL_TEXTURE_SWIZZLE_A = 0x8E45;
pub const GL_GREEN = 0x1904;
pub const GL_BLUE = 0x1905;
pub const GL_INT_2_10_10_10_REV = 0x8D9F;
pub const GL_TRANSFORM_FEEDBACK = 0x8E22;
pub const GL_TRANSFORM_FEEDBACK_PAUSED = 0x8E23;
pub const GL_TRANSFORM_FEEDBACK_ACTIVE = 0x8E24;
pub const GL_TRANSFORM_FEEDBACK_BINDING = 0x8E25;
pub const GL_PROGRAM_BINARY_RETRIEVABLE_HINT = 0x8257;
pub const GL_PROGRAM_BINARY_LENGTH = 0x8741;
pub const GL_NUM_PROGRAM_BINARY_FORMATS = 0x87FE;
pub const GL_PROGRAM_BINARY_FORMATS = 0x87FF;
pub const GL_COMPRESSED_R11_EAC = 0x9270;
pub const GL_COMPRESSED_SIGNED_R11_EAC = 0x9271;
pub const GL_COMPRESSED_RG11_EAC = 0x9272;
pub const GL_COMPRESSED_SIGNED_RG11_EAC = 0x9273;
pub const GL_COMPRESSED_RGB8_ETC2 = 0x9274;
pub const GL_COMPRESSED_SRGB8_ETC2 = 0x9275;
pub const GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 = 0x9276;
pub const GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 = 0x9277;
pub const GL_COMPRESSED_RGBA8_ETC2_EAC = 0x9278;
pub const GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC = 0x9279;
pub const GL_TEXTURE_IMMUTABLE_FORMAT = 0x912F;
pub const GL_MAX_ELEMENT_INDEX = 0x8D6B;
pub const GL_NUM_SAMPLE_COUNTS = 0x9380;
pub const GL_TEXTURE_IMMUTABLE_LEVELS = 0x82DF;

pub const KEY_BACKSPACE = 8;
pub const KEY_TAB = 9;
pub const KEY_ENTER = 13;
pub const KEY_SHIFT = 16;
pub const KEY_CTRL = 17;
pub const KEY_ALT = 18;
pub const KEY_PAUSE = 19;
pub const KEY_CAPS_LOCK = 20;
pub const KEY_ESCAPE = 27;
pub const KEY_SPACE = 32;
pub const KEY_PAGEUP = 33;
pub const KEY_PAGEDOWN = 34;
pub const KEY_END = 35;
pub const KEY_HOME = 36;
pub const KEY_LEFT = 37;
pub const KEY_UP = 38;
pub const KEY_RIGHT = 39;
pub const KEY_DOWN = 40;
pub const KEY_INSERT = 45;
pub const KEY_DELETE = 46;
pub const KEY_0 = 48;
pub const KEY_1 = 49;
pub const KEY_2 = 50;
pub const KEY_3 = 51;
pub const KEY_4 = 52;
pub const KEY_5 = 53;
pub const KEY_6 = 54;
pub const KEY_7 = 55;
pub const KEY_8 = 56;
pub const KEY_9 = 57;
pub const KEY_A = 65;
pub const KEY_B = 66;
pub const KEY_C = 67;
pub const KEY_D = 68;
pub const KEY_E = 69;
pub const KEY_F = 70;
pub const KEY_G = 71;
pub const KEY_H = 72;
pub const KEY_I = 73;
pub const KEY_J = 74;
pub const KEY_K = 75;
pub const KEY_L = 76;
pub const KEY_M = 77;
pub const KEY_N = 78;
pub const KEY_O = 79;
pub const KEY_P = 80;
pub const KEY_Q = 81;
pub const KEY_R = 82;
pub const KEY_S = 83;
pub const KEY_T = 84;
pub const KEY_U = 85;
pub const KEY_V = 86;
pub const KEY_W = 87;
pub const KEY_X = 88;
pub const KEY_Y = 89;
pub const KEY_Z = 90;
pub const KEY_META_LEFT = 91;
pub const KEY_META_RIGHT = 92;
pub const KEY_SELECT = 93;
pub const KEY_NP0 = 96;
pub const KEY_NP1 = 97;
pub const KEY_NP2 = 98;
pub const KEY_NP3 = 99;
pub const KEY_NP4 = 100;
pub const KEY_NP5 = 101;
pub const KEY_NP6 = 102;
pub const KEY_NP7 = 103;
pub const KEY_NP8 = 104;
pub const KEY_NP9 = 105;
pub const KEY_NPMULTIPLY = 106;
pub const KEY_NPADD = 107;
pub const KEY_NPSUBTRACT = 109;
pub const KEY_NPDECIMAL = 110;
pub const KEY_NPDIVIDE = 111;
pub const KEY_F1 = 112;
pub const KEY_F2 = 113;
pub const KEY_F3 = 114;
pub const KEY_F4 = 115;
pub const KEY_F5 = 116;
pub const KEY_F6 = 117;
pub const KEY_F7 = 118;
pub const KEY_F8 = 119;
pub const KEY_F9 = 120;
pub const KEY_F10 = 121;
pub const KEY_F11 = 122;
pub const KEY_F12 = 123;
pub const KEY_NUM_LOCK = 144;
pub const KEY_SCROLL_LOCK = 145;
pub const KEY_SEMICOLON = 186;
pub const KEY_EQUAL_SIGN = 187;
pub const KEY_COMMA = 188;
pub const KEY_MINUS = 189;
pub const KEY_PERIOD = 190;
pub const KEY_SLASH = 191;
pub const KEY_BACKQUOTE = 192;
pub const KEY_BRACKET_LEFT = 219;
pub const KEY_BACKSLASH = 220;
pub const KEY_BRAKET_RIGHT = 221;
pub const KEY_QUOTE = 22;

pub fn glClear(mask: GLbitfield) callconv(.C) void {
    idl.jsGlClear(mask);
}

pub fn glGetUniformLocation(program: GLuint, name: [*:0]const u8) callconv(.C) GLint {
    const len = std.mem.indexOfSentinel(u8, 0, name);
    return @intCast(i32, idl.jsGlGetUniformLocation(program, &name[0], len));
}

pub fn glGenTextures(n: GLsizei, textures: [*c]GLuint) callconv(.C) void {
    if (n == 1) {
        textures[0] = idl.jsGlCreateTexture();
    } else {
        @panic("got >1 count");
    }
}

pub fn glDeleteTextures(n: GLsizei, textures: [*c]const GLuint) callconv(.C) void {
    if (n == 1) {
        idl.jsGlDeleteTexture(textures[0]);
    } else {
        @panic("glDeleteTextures got >1 textures");
    }
}

pub fn glLineWidth(width: GLfloat) callconv(.C) void {
    idl.jsGlLineWidth(width);
}

pub fn glTexParameteri(target: GLenum, pname: GLenum, param: GLint) callconv(.C) void {
    // webgl2 supported targets:
    // GL_TEXTURE_2D
    // GL_TEXTURE_CUBE_MAP
    // GL_TEXTURE_3D
    // GL_TEXTURE_2D_ARRAY
    idl.jsGlTexParameteri(target, pname, param);
}

pub fn glEnable(cap: GLenum) callconv(.C) void {
    // webgl2 supports:
    // GL_BLEND
    // GL_DEPTH_TEST
    // GL_DITHER
    // GL_POLYGON_OFFSET_FILL
    // GL_SAMPLE_ALPHA_TO_COVERAGE
    // GL_SAMPLE_COVERAGE
    // GL_SCISSOR_TEST
    // GL_STENCIL_TEST
    idl.jsGlEnable(cap);
}

pub fn glDisable(cap: GLenum) callconv(.C) void {
    idl.jsGlDisable(cap);
}

pub fn glBindTexture(target: GLenum, texture: GLuint) callconv(.C) void {
    // webgl2 supports:
    // GL_TEXTURE_2D
    // GL_TEXTURE_CUBE_MAP
    // GL_TEXTURE_3D
    // GL_TEXTURE_2D_ARRAY
    idl.jsGlBindTexture(target, texture);
}

pub fn glClearColor(red: f32, green: f32, blue: f32, alpha: f32) callconv(.C) void {
    idl.jsGlClearColor(red, green, blue, alpha);
}

pub fn glGetIntegerv(pname: GLenum, params: [*c]GLint) callconv(.C) void {
    switch (pname) {
        GL_MAJOR_VERSION => {
            params[0] = 3;
        },
        GL_MINOR_VERSION => {
            params[0] = 0;
        },
        GL_FRAMEBUFFER_BINDING => {
            params[0] = @intCast(i32, idl.jsGlGetFrameBufferBinding());
        },
        else => {
            params[0] = idl.jsGlGetParameterInt(pname);
        },
    }
}

pub fn glRenderbufferStorageMultisample(target: GLenum, samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei) callconv(.C) void {
    // webgl2 supported targets:
    // GL_RENDERBUFFER
    idl.jsGlRenderbufferStorageMultisample(target, samples, internalformat, width, height);
}

pub fn getMaxTotalTextures() usize {
    var res: c_int = 0;
    glGetIntegerv(GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, &res);
    return @intCast(usize, res);
}

pub fn getMaxFragmentTextures() usize {
    var res: c_int = 0;
    glGetIntegerv(GL_MAX_TEXTURE_IMAGE_UNITS, &res);
    return @intCast(usize, res);
}

pub fn getMaxSamples() usize {
    var res: c_int = 0;
    glGetIntegerv(GL_MAX_SAMPLES, &res);
    return @intCast(usize, res);
}

pub fn getNumSampleBuffers() usize {
    var res: c_int = 0;
    glGetIntegerv(GL_SAMPLE_BUFFERS, &res);
    return @intCast(usize, res);
}

pub fn getNumSamples() usize {
    var res: c_int = 0;
    glGetIntegerv(GL_SAMPLES, &res);
    return @intCast(usize, res);
}

pub fn getDrawFrameBufferBinding() usize {
    var res: c_int = 0;
    glGetIntegerv(GL_FRAMEBUFFER_BINDING, &res);
    return @intCast(usize, res);
}

pub fn glCheckFramebufferStatus(target: GLenum) callconv(.C) GLenum {
    return idl.jsGlCheckFramebufferStatus(target);
}

// pub fn glDrawArrays(mode: GLenum, first: GLint, count: usize)  callconv(.C) void {
//     glDrawArrays(mode, first, @intCast(c_int, count));
// }

pub fn glDrawElements(mode: GLenum, num_indices: GLsizei, index_type: GLenum, index_offset: usize) callconv(.C) void {
    idl.jsGlDrawElements(mode, @intCast(usize, num_indices), index_type, index_offset);
}

pub fn glFlush() callconv(.C) void {
    idl.jsGlFlush();
}

pub fn glFinish() callconv(.C) void {
    idl.jsGlFinish();
}

pub fn glUseProgram(program: GLuint) callconv(.C) void {
    idl.jsGlUseProgram(program);
}

pub fn glCreateShader(@"type": GLenum) callconv(.C) GLuint {
    // webgl2 supported types:
    // GL_VERTEX_SHADER
    // GL_FRAGMENT_SHADER
    return idl.jsGlCreateShader(@"type");
}

pub fn glGetShaderInfoLog(shader: GLuint, buf_size: GLsizei, length: [*c]GLsizei, info_log: [*c]GLchar) callconv(.C) void {
    length[0] = @intCast(i32, idl.jsGlGetShaderInfoLog(shader, @intCast(u32, buf_size), info_log));
}

pub fn glCreateProgram() callconv(.C) GLuint {
    return idl.jsGlCreateProgram();
}

pub fn glAttachShader(program: GLuint, shader: GLuint) callconv(.C) void {
    idl.jsGlAttachShader(program, shader);
}

pub fn glLinkProgram(program: GLuint) callconv(.C) void {
    idl.jsGlLinkProgram(program);
}

pub fn glGetProgramiv(program: GLuint, pname: GLenum, params: [*c]GLchar) callconv(.C) void {
    idl.jsGlGetProgramiv(program, pname, params);
}

pub fn glGetProgramInfoLog(program: GLuint, buf_size: GLsizei, length: [*c]GLsizei, info_log: [*c]GLchar) callconv(.C) void {
    length[0] = @intCast(i32, idl.jsGlGetProgramInfoLog(program, @intCast(u32, buf_size), info_log));
}

pub fn glDeleteProgram(program: GLuint) callconv(.C) void {
    idl.jsGlDeleteProgram(program);
}

pub fn glDeleteShader(shader: GLuint) callconv(.C) void {
    idl.jsGlDeleteShader(shader);
}

pub fn glGenVertexArrays(n: GLsizei, arrays: [*c]GLuint) callconv(.C) void {
    if (n == 1) {
        arrays[0] = idl.jsGlCreateVertexArray();
    } else {
        @panic("got >1 count");
    }
}

pub fn glGenVertexArray() callconv(.C) GLuint {
    return idl.jsGlCreateVertexArray();
}

pub fn glDrawArraysInstanced(mode: c_uint, first: c_uint, count: c_uint, instanceCount: c_uint) callconv(.C) void {
    return idl.jsGlDrawArraysInstanced(mode, first, count, instanceCount);
}

pub fn glDrawArrays(mode: c_uint, first: c_int, count: c_int) callconv(.C) void {
    return idl.jsGlDrawArrays(mode, first, count);
}

pub fn glShaderSource(shader: GLuint, count: usize, string: [*c]const [*c]const GLchar, length: ?*c_int) callconv(.C) void {
    idl.jsGlShaderSource(shader, count, @ptrCast(*const anyopaque, string), length);
}

pub fn glCompileShader(shader: GLuint) callconv(.C) void {
    idl.jsGlCompileShader(shader);
}

pub fn glGetShaderiv(shader: GLuint, pname: GLenum, params: [*c]GLchar) callconv(.C) void {
    idl.jsGlGetShaderiv(shader, pname, params);
}

pub fn glScissor(x: GLint, y: GLint, width: GLsizei, height: GLsizei) callconv(.C) void {
    idl.jsGlScissor(x, y, width, height);
}

pub fn glBlendFunc(sfactor: GLenum, dfactor: GLenum) callconv(.C) void {
    idl.jsGlBlendFunc(sfactor, dfactor);
}

pub fn glBlendEquation(mode: GLenum) callconv(.C) void {
    idl.jsGlBlendEquation(mode);
}

pub fn glCreateVertexArray() callconv(.C) GLuint {
    return idl.jsGlCreateVertexArray();
}
pub fn glBindVertexArray(array: GLuint) callconv(.C) void {
    idl.jsGlBindVertexArray(array);
}

pub fn glBindBuffer(target: GLenum, buffer: GLuint) callconv(.C) void {
    // webgl2 supported targets:
    // GL_ARRAY_BUFFER
    // GL_ELEMENT_ARRAY_BUFFER
    // GL_COPY_READ_BUFFER
    // GL_COPY_WRITE_BUFFER
    // GL_TRANSFORM_FEEDBACK_BUFFER
    // GL_UNIFORM_BUFFER
    // GL_PIXEL_PACK_BUFFER
    // GL_PIXEL_UNPACK_BUFFER
    idl.jsGlBindBuffer(target, buffer);
}

// extern "C" void glBufferData (GLenum target, GLsizeiptr size, const void *data, GLenum usage);
pub fn glBufferData(target: GLenum, size: GLsizeiptr, data: ?*const anyopaque, usage: GLenum) callconv(.C) void {
    idl.jsGlBufferData(target, @intCast(u32, size), @ptrCast(?*const u8, data), usage);
}

// extern "C" void glBufferSubData (GLenum target, GLintptr offset, GLsizeiptr size, const void *data);
pub fn glBufferSubData(target: GLenum, offset: GLint, size: GLsizeiptr, data: ?*const anyopaque) callconv(.C) void {
    idl.jsGlBufferSubData(target, offset, @intCast(u32, size), @ptrCast(?*const u8, data));
}

// extern "C" GLboolean glIsEnabled (GLenum cap);
pub fn glIsEnabled(target: GLenum) callconv(.C) GLboolean {
    return idl.jsGlIsEnabled(target);
}

// extern "C" void glPixelStorei (GLenum pname, GLint param);
pub fn glPixelStorei(pname: GLenum, param: GLint) callconv(.C) void {
    idl.jsGlPixelStorei(pname, param);
}

// extern "C" GLint glGetAttribLocation (GLuint program, const GLchar *name);
pub fn glGetAttribLocation(program: GLuint, param: [*c]const u8) callconv(.C) i32 {
    return idl.glGetAttribLocation(program, param);
}

// extern "C" void glGetVertexAttribiv (GLuint index, GLenum pname, GLint *params);
pub fn glGetVertexAttribiv(index: GLuint, pname: GLenum, params: [*c]const i32) callconv(.C) void {
    idl.glGetVertexAttribiv(index, pname, params);
}

// extern "C" void glGetVertexAttribfv (GLuint index, GLenum pname, GLint *params);
pub fn glGetVertexAttribfv(index: GLuint, pname: GLenum, params: [*c]const f32) callconv(.C) void {
    idl.glGetVertexAttribfv(index, pname, params);
}

// extern "C" void glGetVertexAttribPointerv (GLuint index, GLenum pname, void **pointer);
pub fn glGetVertexAttribPointerv(index: GLuint, pname: GLenum, params: ?*const anyopaque) callconv(.C) void {
    idl.glGetVertexAttribPointerv(index, pname, params);
}

pub fn glPolygonOffset(factor: GLfloat, units: GLfloat) callconv(.C) void {
    idl.jsGlPolygonOffset(factor, units);
}

pub fn glEnableVertexAttribArray(index: GLuint) callconv(.C) void {
    idl.jsGlEnableVertexAttribArray(index);
}

pub fn glActiveTexture(texture: GLenum) callconv(.C) void {
    idl.jsGlActiveTexture(texture);
}

pub fn glVertexAttribDivisor(index: GLuint, divisor: GLuint) callconv(.C) void {
    idl.jsGlVertexAttribDivisor(index, divisor);
}

pub fn glDetachShader(program: GLuint, shader: GLuint) callconv(.C) void {
    idl.jsGlDetachShader(program, shader);
}

pub fn glGenRenderbuffers(n: GLsizei, renderbuffers: [*c]GLuint) callconv(.C) void {
    var i: u32 = 0;
    while (i < n) : (i += 1) {
        renderbuffers[i] = idl.jsGlCreateRenderbuffer();
    }
}

pub fn glViewport(x: GLint, y: GLint, width: GLsizei, height: GLsizei) callconv(.C) void {
    idl.jsGlViewport(x, y, width, height);
}

pub fn setWindowSize(width: u32, height: u32) void {
    _ = idl.jsSetCanvasBuffer(width, height);
}

pub fn glGenFramebuffers(n: GLsizei, framebuffers: [*c]GLuint) callconv(.C) void {
    if (n == 1) {
        framebuffers[0] = idl.jsGlCreateFramebuffer();
    } else {
        @panic("glGenFrameBuffers got >1 count");
    }
}

pub fn glBindFramebuffer(target: GLenum, framebuffer: GLuint) callconv(.C) void {
    // webgl2 supports targets:
    // GL_FRAMEBUFFER
    // GL_DRAW_FRAMEBUFFER
    // GL_READ_FRAMEBUFFER
    idl.jsGlBindFramebuffer(target, framebuffer);
}

pub fn glBindRenderbuffer(target: GLenum, renderbuffer: GLuint) callconv(.C) void {
    // webgl2 supports targets:
    // GL_RENDERBUFFER
    idl.jsGlBindRenderbuffer(target, renderbuffer);
}

pub fn glTexSubImage2D(target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, width: GLsizei, height: GLsizei, format: GLenum, @"type": GLenum, pixels: ?*const GLvoid) callconv(.C) void {
    idl.jsGlTexSubImage2D(target, level, xoffset, yoffset, width, height, format, @"type", @ptrCast(?*const u8, pixels));
}

pub fn glTexImage2D(target: GLenum, level: GLint, internal_format: GLint, width: GLsizei, height: GLsizei, border: GLint, format: GLenum, @"type": GLenum, pixels: ?*const u8) callconv(.C) void {
    idl.jsGlTexImage2D(target, level, internal_format, width, height, border, format, @"type", @ptrCast(?*const u8, pixels));
}
// extern "C" void glBlendEquationSeparate (GLenum modeRGB, GLenum modeAlpha);
pub fn glBlendEquationSeparate(modeRGB: GLenum, modeAlpha: GLenum) callconv(.C) void {
    idl.jsGlBlendEquationSeparate(modeRGB, modeAlpha);
}

// extern "C" void glBlendFuncSeparate (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);
pub fn glBlendFuncSeparate(sfactorRGB: GLenum, dfactorRGB: GLenum, sfactorAlpha: GLenum, dfactorAlpha: GLenum) callconv(.C) void {
    idl.jsGlBlendFuncSeparate(sfactorRGB, dfactorRGB, sfactorAlpha, dfactorAlpha);
}

pub fn glFramebufferRenderbuffer(target: GLenum, attachment: GLenum, renderbuffertarget: GLenum, renderbuffer: GLuint) callconv(.C) void {
    idl.jsGlFramebufferRenderbuffer(target, attachment, renderbuffertarget, renderbuffer);
}

pub fn glFramebufferTexture2D(target: GLenum, attachment: GLenum, textarget: GLenum, texture: GLuint, level: GLint) callconv(.C) void {
    idl.jsGlFramebufferTexture2D(target, attachment, textarget, texture, level);
}

pub fn glGenBuffers(n: GLsizei, buffers: [*c]GLuint) callconv(.C) void {
    var i: u32 = 0;
    while (i < n) : (i += 1) {
        buffers[i] = idl.jsGlCreateBuffer();
    }
}

pub fn glCreateBuffer() callconv(.C) GLuint {
    return idl.jsGlCreateBuffer();
}

pub fn glVertexAttribPointer(index: GLuint, size: GLint, @"type": GLenum, normalized: GLboolean, stride: GLsizei, pointer: ?*const anyopaque) callconv(.C) void {
    idl.jsGlVertexAttribPointer(index, size, @"type", normalized, stride, pointer);
}

pub fn glDeleteVertexArrays(n: GLsizei, arrays: [*c]const GLuint) callconv(.C) void {
    var i: u32 = 0;
    while (i < n) : (i += 1) {
        idl.jsGlDeleteVertexArray(arrays[i]);
    }
}

pub fn glDeleteBuffers(n: GLsizei, buffers: [*c]const GLuint) callconv(.C) void {
    var i: u32 = 0;
    while (i < n) : (i += 1) {
        idl.jsGlDeleteBuffer(buffers[i]);
    }
}

pub fn glBlitFramebuffer(srcX0: GLint, srcY0: GLint, srcX1: GLint, srcY1: GLint, dstX0: GLint, dstY0: GLint, dstX1: GLint, dstY1: GLint, mask: GLbitfield, filter: GLenum) callconv(.C) void {
    idl.jsGlBlitFramebuffer(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter);
}

pub fn glUniformMatrix3fv(location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) callconv(.C) void {
    if (count == 1) {
        idl.jsGlUniformMatrix3fv(location, transpose, value);
    } else {
        @panic("got >1 count");
    }
}

pub fn glUniformMatrix4fv(location: GLint, count: GLsizei, transpose: GLboolean, value: [*c]const GLfloat) callconv(.C) void {
    if (count == 1) {
        idl.jsGlUniformMatrix4fv(location, transpose, value);
    } else {
        @panic("got >1 count");
    }
}

pub fn glUniform1fv(location: GLint, count: GLsizei, value: [*c]const GLfloat) callconv(.C) void {
    if (count == 1) {
        idl.jsGlUniform1fv(location, value);
    } else {
        @panic("got >1 count");
    }
}

pub fn glUniform2fv(location: GLint, count: GLsizei, value: [*c]const GLfloat) callconv(.C) void {
    if (count == 1) {
        idl.jsGlUniform2fv(location, value);
    } else {
        @panic("got >1 count");
    }
}

pub fn glUniform3fv(location: GLint, count: GLsizei, value: [*c]const GLfloat) callconv(.C) void {
    if (count == 1) {
        idl.jsGlUniform3fv(location, value);
    } else {
        @panic("got >1 count");
    }
}

pub fn glUniform4fv(location: GLint, count: GLsizei, value: [*c]const GLfloat) callconv(.C) void {
    if (count == 1) {
        idl.jsGlUniform4fv(location, value);
    } else {
        @panic("got >1 count");
    }
}

pub fn glUniform1i(location: GLint, v0: GLint) callconv(.C) void {
    idl.jsGlUniform1i(location, v0);
}

// extern "C" void glDisableVertexAttribArray (GLuint index);
pub fn glDisableVertexAttribArray(index: GLuint) callconv(.C) void {
    idl.glDisableVertexAttribArray(index);
}

comptime {
    //   (func $glGetIntegerv (;7;) (import "env" "glGetIntegerv") (param i32 i32))
    @export(glGetIntegerv, .{ .name = "glGetIntegerv", .linkage = .Strong });
    //   (func $glGetString (;8;) (import "env" "glGetString") (param i32) (result i32))
    // @export(glGetString, .{ .name = "glGetString", .linkage = .Strong });
    //   (func $glGetStringi (;9;) (import "env" "glGetStringi") (param i32 i32) (result i32))
    // @export(glGetStringi, .{ .name = "glGetStringi", .linkage = .Strong });
    //   (func $glCreateShader (;10;) (import "env" "glCreateShader") (param i32) (result i32))
    @export(glCreateShader, .{ .name = "glCreateShader", .linkage = .Strong });
    //   (func $glShaderSource (;11;) (import "env" "glShaderSource") (param i32 i32 i32 i32))
    @export(glShaderSource, .{ .name = "glShaderSource", .linkage = .Strong });
    //   (func $glCompileShader (;12;) (import "env" "glCompileShader") (param i32))
    @export(glCompileShader, .{ .name = "glCompileShader", .linkage = .Strong });
    //   (func $glCreateProgram (;13;) (import "env" "glCreateProgram") (result i32))
    @export(glCreateProgram, .{ .name = "glCreateProgram", .linkage = .Strong });
    //   (func $glAttachShader (;14;) (import "env" "glAttachShader") (param i32 i32))
    @export(glAttachShader, .{ .name = "glAttachShader", .linkage = .Strong });
    //   (func $glLinkProgram (;15;) (import "env" "glLinkProgram") (param i32))
    @export(glLinkProgram, .{ .name = "glLinkProgram", .linkage = .Strong });
    //   (func $glDetachShader (;16;) (import "env" "glDetachShader") (param i32 i32))
    @export(glDetachShader, .{ .name = "glDetachShader", .linkage = .Strong });
    //   (func $glDeleteShader (;17;) (import "env" "glDeleteShader") (param i32))
    @export(glDeleteShader, .{ .name = "glDeleteShader", .linkage = .Strong });
    //   (func $glGetUniformLocation (;18;) (import "env" "glGetUniformLocation") (param i32 i32) (result i32))
    @export(glGetUniformLocation, .{ .name = "glGetUniformLocation", .linkage = .Strong });
    //   (func $glGetAttribLocation (;19;) (import "env" "glGetAttribLocation") (param i32 i32) (result i32))
    @export(glGetAttribLocation, .{ .name = "glGetAttribLocation", .linkage = .Strong });

    @export(glGetVertexAttribiv, .{ .name = "glGetVertexAttribiv", .linkage = .Strong });
    @export(glGetVertexAttribfv, .{ .name = "glGetVertexAttribfv", .linkage = .Strong });
    @export(glGetVertexAttribPointerv, .{ .name = "glGetVertexAttribPointerv", .linkage = .Strong });
    @export(glDisableVertexAttribArray, .{ .name = "glDisableVertexAttribArray", .linkage = .Strong });

    //   (func $glGenBuffers (;20;) (import "env" "glGenBuffers") (param i32 i32))
    @export(glGenBuffers, .{ .name = "glGenBuffers", .linkage = .Strong });
    //   (func $glBindTexture (;21;) (import "env" "glBindTexture") (param i32 i32))
    @export(glBindTexture, .{ .name = "glBindTexture", .linkage = .Strong });
    //   (func $glBindBuffer (;22;) (import "env" "glBindBuffer") (param i32 i32))
    @export(glBindBuffer, .{ .name = "glBindBuffer", .linkage = .Strong });
    //   (func $glBindVertexArray (;23;) (import "env" "glBindVertexArray") (param i32))
    @export(glBindVertexArray, .{ .name = "glBindVertexArray", .linkage = .Strong });
    //   (func $glActiveTexture (;24;) (import "env" "glActiveTexture") (param i32))
    @export(glActiveTexture, .{ .name = "glActiveTexture", .linkage = .Strong });
    //   (func $glIsEnabled (;25;) (import "env" "glIsEnabled") (param i32) (result i32))
    @export(glIsEnabled, .{ .name = "glIsEnabled", .linkage = .Strong });
    //   (func $glGenVertexArrays (;26;) (import "env" "glGenVertexArrays") (param i32 i32))
    @export(glGenVertexArrays, .{ .name = "glGenVertexArrays", .linkage = .Strong });
    //   (func $glBufferData (;27;) (import "env" "glBufferData") (param i32 i32 i32 i32))
    @export(glBufferData, .{ .name = "glBufferData", .linkage = .Strong });
    //   (func $glBufferSubData (;28;) (import "env" "glBufferSubData") (param i32 i32 i32 i32))
    @export(glBufferSubData, .{ .name = "glBufferSubData", .linkage = .Strong });
    //   (func $glScissor (;29;) (import "env" "glScissor") (param i32 i32 i32 i32))
    @export(glScissor, .{ .name = "glScissor", .linkage = .Strong });
    //   (func $glDrawElements (;30;) (import "env" "glDrawElements") (param i32 i32 i32 i32))
    @export(glDrawElements, .{ .name = "glDrawElements", .linkage = .Strong });
    //   (func $glDeleteVertexArrays (;31;) (import "env" "glDeleteVertexArrays") (param i32 i32))
    @export(glDeleteVertexArrays, .{ .name = "glDeleteVertexArrays", .linkage = .Strong });
    //   (func $glUseProgram (;32;) (import "env" "glUseProgram") (param i32))
    @export(glUseProgram, .{ .name = "glUseProgram", .linkage = .Strong });
    //   (func $glBlendEquationSeparate (;33;) (import "env" "glBlendEquationSeparate") (param i32 i32))
    @export(glBlendEquationSeparate, .{ .name = "glBlendEquationSeparate", .linkage = .Strong });
    //   (func $glBlendFuncSeparate (;34;) (import "env" "glBlendFuncSeparate") (param i32 i32 i32 i32))
    @export(glBlendFuncSeparate, .{ .name = "glBlendFuncSeparate", .linkage = .Strong });
    //   (func $glEnable (;35;) (import "env" "glEnable") (param i32))
    @export(glEnable, .{ .name = "glEnable", .linkage = .Strong });
    //   (func $glDisable (;36;) (import "env" "glDisable") (param i32))
    @export(glDisable, .{ .name = "glDisable", .linkage = .Strong });
    //   (func $glPolygonMode (;37;) (import "env" "glPolygonMode") (param i32 i32))
    // @export(glPolygonMode, .{ .name = "glPolygonMode", .linkage = .Strong });
    //   (func $glViewport (;38;) (import "env" "glViewport") (param i32 i32 i32 i32))
    @export(glViewport, .{ .name = "glViewport", .linkage = .Strong });
    //   (func $glBlendEquation (;39;) (import "env" "glBlendEquation") (param i32))
    @export(glBlendEquation, .{ .name = "glBlendEquation", .linkage = .Strong });
    //   (func $glUniform1i (;40;) (import "env" "glUniform1i") (param i32 i32))
    @export(glUniform1i, .{ .name = "glUniform1i", .linkage = .Strong });
    //   (func $glUniformMatrix4fv (;41;) (import "env" "glUniformMatrix4fv") (param i32 i32 i32 i32))
    @export(glUniformMatrix4fv, .{ .name = "glUniformMatrix4fv", .linkage = .Strong });
    //   (func $glEnableVertexAttribArray (;42;) (import "env" "glEnableVertexAttribArray") (param i32))
    @export(glEnableVertexAttribArray, .{ .name = "glEnableVertexAttribArray", .linkage = .Strong });
    //   (func $glVertexAttribPointer (;43;) (import "env" "glVertexAttribPointer") (param i32 i32 i32 i32 i32 i32))
    @export(glVertexAttribPointer, .{ .name = "glVertexAttribPointer", .linkage = .Strong });
    //   (func $glGenTextures (;44;) (import "env" "glGenTextures") (param i32 i32))
    @export(glGenTextures, .{ .name = "glGenTextures", .linkage = .Strong });
    //   (func $glTexParameteri (;45;) (import "env" "glTexParameteri") (param i32 i32 i32))
    @export(glTexParameteri, .{ .name = "glTexParameteri", .linkage = .Strong });
    //   (func $glPixelStorei (;46;) (import "env" "glPixelStorei") (param i32 i32))
    @export(glPixelStorei, .{ .name = "glPixelStorei", .linkage = .Strong });
    //   (func $glTexImage2D (;47;) (import "env" "glTexImage2D") (param i32 i32 i32 i32 i32 i32 i32 i32 i32))
    @export(glTexImage2D, .{ .name = "glTexImage2D", .linkage = .Strong });
    //   (func $glGetShaderiv (;48;) (import "env" "glGetShaderiv") (param i32 i32 i32))
    @export(glGetShaderiv, .{ .name = "glGetShaderiv", .linkage = .Strong });
    //   (func $glGetShaderInfoLog (;50;) (import "env" "glGetShaderInfoLog") (param i32 i32 i32 i32))
    @export(glGetShaderInfoLog, .{ .name = "glGetShaderInfoLog", .linkage = .Strong });
    //   (func $glGetProgramiv (;51;) (import "env" "glGetProgramiv") (param i32 i32 i32))
    @export(glGetProgramiv, .{ .name = "glGetProgramiv", .linkage = .Strong });
    //   (func $glGetProgramInfoLog (;52;) (import "env" "glGetProgramInfoLog") (param i32 i32 i32 i32))
    @export(glGetProgramInfoLog, .{ .name = "glGetProgramInfoLog", .linkage = .Strong });
}
